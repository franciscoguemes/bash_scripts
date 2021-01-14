#!/bin/bash

#############################################################################################
#
# Description:
#	The script starts the docker-compose-lamp serving the contents of the given directory.
#
# 	The server would serve by default the directory "www" inside its directory structure, therefore 
#	this script first mounts a development directory as the "www" directory, by doing this it is ensured 
#	that the server serves the development content and a lot of copy/paste is avoided.
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
#	start_docker_LAMP.sh
#	stop_docker_LAMP_mywebsite.sh
#
# See:
#	
#	
#
#############################################################################################

MYWEBSITE_DIR=/home/francisco/git/Francisco/gitlab/mywebsite

start_docker_LAMP.sh $MYWEBSITE_DIR

