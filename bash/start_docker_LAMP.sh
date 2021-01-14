#!/bin/bash

#############################################################################################
# Usage:
# 	start_docker_LAMP.sh [directory_www]
#
# Description:
#	The optional argument "directory_www" is the directory that the Apache server will serve as content directory.
#
#	The script starts the docker-compose-lamp. The server will serve by default the directory "www"
#	inside its directory structure. So this script first mounts a development directory as the "www" directory,
#	by doing this it is ensured that the server serves the development content and a lot of copy/paste is avoided.
#	
#	Also the mounted directory belongs to a different git repository, so this eases the development
#	process.
#	
#	Note that the original contents of the directory "www" are not accessible anymore while the development directory
#	is mounted. But once the development directory is umnomted, the original contents of "www" will be accesible again
#	by the filesystem. 
#	
# Referenced by:
#	/home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp/README.md
#
# Depends on:
#	stop_docker_LAMP.sh
#
# See:
#	
#	
#
#############################################################################################

LAMP_HOME=/home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp
LAMP_WWW=$LAMP_HOME/www

# If an argument is supplied then try to mount the given directory as the www directory of the Apache server.
if [ "$#" -eq  "1" ]
then
    # Test that the given directory exists...	
    if [[ ! -d $1 ]]
    then
        echo "The given directory ${1} does not exist!"
    exit 1
    fi
 
    # Mount the given directory in the place of the LAMP_WWW directory.
    sudo mount -o bind $1 $LAMP_WWW
fi

sleep 0.5
cd $LAMP_HOME

sudo docker-compose start
