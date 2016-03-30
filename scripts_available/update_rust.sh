#!/bin/bash

user="updater"
git_url="https://github.com/rust-lang/rust"
git_repo_path="/home/updater/git/rust"
runfile="/tmp/`basename $0`"
if [[ "${0:0:1}" == "/" ]]
then
    full_command="$0"
else
    full_command="`pwd`/$0"
fi

if [[ ! -e "$git_repo_path" ]]
then
    su -s /bin/sh -c "/usr/bin/git clone $git_url $git_repo_path" "$user"
fi
cd "$git_repo_path"

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
    tag=`git tag -l | grep -E "^[0-9.]+$" | tail -1`
    current_version=`rustc --version`
    if [[ $? -ne 0 ]] || [[ "$current_version" != "$tag" ]]
    then
        git checkout "$tag"
        ./configure
        make
    else
        echo "Already at the last version"
    fi
    git checkout master
else
    echo "Need to be run as root"
fi
