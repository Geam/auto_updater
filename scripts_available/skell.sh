#!bin/bash

#### change these variables ####
user=""
git_url=""
git_repo_path=""
#### ! change these variables ###

runfile="/tmp/`basename $0`"
if [[ "${0:0:1}" == "/" ]]
then
    full_command=$0
else
    full_command="`pwd`/$0"
fi

if [[ ! -e "$git_repo_path" ]]
then
    su -s /bin/sh -c /usr/bin/git clone "$git_url" "$git_repo_path"
fi
cd "$git_repo_path"

if [[ `id -u` -eq 0 ]]
then
    if [[ -e $runfile ]]; then
        echo "already start"
        exit 1
    fi
    touch "$runfile"
    su -s /bin/sh -c "$full_command" "$user"
    make install
    rm "$runfile"
elif [[ -e "$runfile" ]]
then
    git pull

    #### change here to match your need ####
    ./configure
    make
    #### ! change here to match your need ####

else
    echo "Need to be run as root"
fi
