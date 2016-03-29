# auto_updater
Some script to auto-update some program installed from source

## How to use
* Clone it
* Set the user that will do the update (not root)
* Launch the main_launcher.sh script
* Put your scripts in the scripts_available
* Make symbolic links to thoses scripts in scripts_enabled
* Add an entry in the root crontab that call the main_launcher.sh script

## Create your update script
Take exemple on the skel.sh script
