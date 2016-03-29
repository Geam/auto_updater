#!/bin/bash

user="updater"
scripts_relative_path="scripts_enabled"

if [[ "${0:0:1}" == "/" ]]
then
    scripts_path="`dirname $0`/$scripts_relative_path"
else
    scripts_path="`pwd`/`dirname $0`/$scripts_relative_path"
fi

if [[ `id -u` -ne 0 ]]
then
    echo "Need to be run as root"
    exit 1
fi

if [[ ! -e "$scripts_path" ]]
then
    su -s /bin/sh -c "mkdir -p $scripts_path" "$user"
    echo "It appear to be the first time you run this script."
    echo "Put in $scripts_path the scripts or symbolic link to your scripts"
else
    for script in `find "$scripts_path" -mindepth 1`
    do
        echo "### $script ###"
        $script
    done
fi

