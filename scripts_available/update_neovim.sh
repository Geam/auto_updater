#!/bin/bash

user="updater"
git_url="https://github.com/neovim/neovim"
git_repo_path="/home/updater/git/neovim"
runfile="/tmp/`basename $0`"
if [[ "${0:0:1}" == "/" ]]
then
    fullcommand="$0"
else
    fullcommand="`pwd`/$0"
fi

if [[ ! -e "$git_repo_path" ]]
then
    su -s /bin/sh -c "/usr/bin/git clone $git_url $git_repo_path" "$user"
fi
cd `dirname $fullcommand`

if [[ `id -u` -eq 0 ]]
then
    if [[ -e "$runfile" ]]; then
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
    make clean
    make CMAKE_BUILD_TYPE=Release
else
    echo "Need to be run as root"
fi
