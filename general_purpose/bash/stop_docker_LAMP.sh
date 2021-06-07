#!/bin/bash

#############################################################################################
# Usage:
# 	stop_docker_LAMP.sh [directory_www]
#
# Description:
#	The optional argument "directory_www" is the directory that the Apache is serving as content directory and it was supplied
#	in the equivalent script start_docker_LAMP.sh
#
#	The script stops the docker-compose-lamp. First it stops the server and then it unmounts the development directory
#	that was mounted in place of the "www" directory (if any).
#	
#	Note that the original contents of the directory "www" are not accessible until the development directory
#	is unmounted. But once the development directory is umnomted, the original contents of "www" will be accesible again
#	by the filesystem. 
#
# Description:
#	The script stops the docker-compose-lamp
#	
# Referenced by:
#	/home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp/README.md
#
# Depends on:
#	start_docker_LAMP.sh
#
# See:
#	
#	
#
#############################################################################################

LAMP_HOME=/home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp
LAMP_WWW=$LAMP_HOME/www

cd $LAMP_HOME

sudo docker-compose stop
sleep 0.5

# If an argument is supplied then try to umount the given directory as the www directory of the Apache server.
if [ "$#" -eq  "1" ]
then
    # Test that the given directory exists...	
    if [[ ! -d $1 ]]
    then
        echo "The given directory ${1} does not exist!"
    exit 1
    fi
 
    # Umount the given directory in the place of the LAMP_WWW directory.
    sudo umount -$1 $LAMP_WWW
fi


