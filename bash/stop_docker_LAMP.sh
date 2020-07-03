#!/bin/bash

#############################################################################################
#
# Description:
#	The script stops the docker-compose-lamp. First it stops the server and then it unmounts the development directory
#	that was mounted in place of the "www" directory.
#	
#	Note that the original contents of the directory "www" are not accessible until the development directory
#	is unmounted. But once the development directory is umnomted, the original contents of "www" will be accesible again
#	by the filesystem. 
#
# Description:
#	The script stops the docker-compose-lamp
#	
# Referenced by:
#
#
# Depends on:
#	start_docker_LAMP.sh
#
# See:
#	
#	
#
#############################################################################################

cd /home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp

sudo docker-compose stop
sleep 0.5
sudo umount /home/francisco/git/Francisco/gitlab/mywebsite /home/francisco/git/Others/docker-compose-lamp/docker-compose-lamp/www
