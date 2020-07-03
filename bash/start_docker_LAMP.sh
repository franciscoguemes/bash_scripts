#!/bin/bash

#############################################################################################
#
# Description:
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
#	
#
# Depends on:
#	stop_docker_LAMP.sh
#
# See:
#	
#	
#
#############################################################################################

sudo mount -o bind /home/francisco/git/Francisco/gitlab/mywebsite /home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp/www
sleep 0.5
cd /home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp

sudo docker-compose start
