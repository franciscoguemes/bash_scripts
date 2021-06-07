#!/bin/bash

#############################################################################################
#
# Description:
# 	The scripts goes to the directory PICTURES_DIR and search for all files that matches the 
# 	pattern PATTERN and delete them.
#
#
# See:
# 	List files in directory (Non recursive): https://stackoverflow.com/a/7265285
# 	Remove path from absoulte path name: https://stackoverflow.com/a/23497364
# 	Compare strings against regex: https://unix.stackexchange.com/a/370919
#	Begin of line in bash regex: https://stackoverflow.com/a/4800246
#	Work with file names that contain spaces: https://unix.stackexchange.com/a/208144
#
#############################################################################################

PICTURES_DIR=/home/francisco/Pictures

# Pattern for strings that starts with the word Screenshot and finish with the png extension
PATTERN=^Screenshot.*\\.png$

for file in $PICTURES_DIR/*
do
    if [[ -f $file ]]; then
	fileName=${file##*/}
	# echo $file
	# echo $fileName
	if [[ $fileName =~ $PATTERN ]]; then
		# echo "$file"
        	# echo "$fileName"
		rm -v "$file"
	fi
    fi
done


