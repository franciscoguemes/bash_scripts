#!/usr/bin/env bash

#############################################################################################
# Usage:
# 	install_java.sh $JDK_NAME $PRIORITY
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

# TODO: Script documentation
# This script must do 2 different things:
#   Generate the file .JDK_VERSION.jinfo
#   Install the different executable files using updage-alternatives (Create the links)

# Use:
#   sudo ./install_java.sh java-15-openjdk-amd64 1500

# TODO: Check the arguments
# The expected arguments are the JDK name (must match the installation directory)
# The priority: It will be used for the creation of the *.jinfo file and for the update-alternatives install

JDK_NAME=$1
PRIORITY=$2

# https://linuxconfig.org/how-to-use-arrays-in-bash-script#h1-1-2-create-indexed-arrays-on-the-fly
# https://stackoverflow.com/questions/11426529/reading-output-of-a-command-into-an-array-in-bash
# https://stackoverflow.com/a/9958143
# https://stackoverflow.com/questions/3578584/bash-how-to-delete-elements-from-an-array-based-on-a-pattern
# https://linuxhint.com/bash_append_array/
# https://stackoverflow.com/questions/3294072/get-last-dirname-filename-in-a-file-path-argument-in-bash
# https://stackoverflow.com/questions/13633638/create-file-with-contents-from-shell-script
# https://gist.github.com/hadisfr/b1af472d3d943f5448f9e0840296e700
# https://askubuntu.com/questions/420513/what-are-the-standard-places-that-java-virtual-machine-is-configured-on-ubuntu-1/844551#844551
#   https://askubuntu.com/a/844551
# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value

BASE_DIR=/usr/lib/jvm
JDK_DIR=$BASE_DIR/$JDK_NAME

# Define empty array
executable_files=()
# Store files in array https://stackoverflow.com/a/9958143
files=($JDK_DIR/bin/* $JDK_DIR/lib/*)
#echo ${files[@]}

# Filter files, we are only interested in the executables
for file in "${files[@]}";
do
    if [[ -f $file ]] && [[ -x $file ]]; then
        #echo $file
        executable_files+=($file)
    fi
done

#TODO: Create the .*.jinfo file
echo "
name=$JDK_NAME
alias=$JDK_NAME
priority=$PRIORITY
section=main
 
" > $BASE_DIR/.$JDK_NAME.jinfo

# https://gist.github.com/dedeibel/685dc47e6361b341d208b1747cedbc5b
# https://gist.github.com/hadisfr/b1af472d3d943f5448f9e0840296e700
# https://askubuntu.com/questions/420513/what-are-the-standard-places-that-java-virtual-machine-is-configured-on-ubuntu-1/844551#844551
headless_executables=(java jexec keytool pack200 rmid rmiregistry unpack200 jjs jfr)
for executable_file in "${executable_files[@]}";
do
    executable=`basename $executable_file`
    if [[ " ${headless_executables[@]} " =~ " ${executable} " ]]; then
        echo "hl $executable $executable_file " >> $BASE_DIR/.$JDK_NAME.jinfo
    else
        echo "jdkhl $executable $executable_file " >> $BASE_DIR/.$JDK_NAME.jinfo
    fi
done

#TODO: Install the executables
for executable_file in "${executable_files[@]}";
do
    # echo $executable_file
    executable=`basename $executable_file`
    # echo $executable
    update-alternatives --install /usr/bin/$executable $executable $executable_file $PRIORITY
done


#######################################################################################################
FROM HERE DOWN IS OBSOLETE...
#######################################################################################################

for file in $JDK_DIR/bin/*
do
    if [[ -f $file ]] && [[ -x $file ]]; then
        #copy stuff ....
        #echo $file

        # take last part of the path ($EXECUTABLE)
        # if not exists in /usr/bin/* then
        #   sudo update-alternatives --install /usr/bin/$EXECUTABLE $EXECUTABLE /usr/lib/jvm/java-15-openjdk-amd64/bin/$EXECUTABLE 1500
        #       or create manually the following links
        #           create the link in /etc/alternatives/$EXECUTABLE pointing to the $JDK_DIR/bin/$EXECUTABLE
        #           create the link in /usr/bin/$EXECUTABLE pointing to /etc/alternatives/$EXECUTABLE
        #   
    fi
done

for file in $JDK_DIR/lib/*
do
    if [[ -f $file ]] && [[ -x $file ]]; then
        #copy stuff ....
        #echo $file
    fi
done
