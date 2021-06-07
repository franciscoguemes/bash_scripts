#!/bin/bash

# This script only works for files in the specified directory, it does not search recursively in subdirectories.
# Subdirectories of the given directory will be ignored by the script.
#

# Sources:
#  https://askubuntu.com/questions/584724/split-contents-of-a-directory-into-multiple-sub-directories
#  https://stackoverflow.com/questions/29116212/split-a-folder-into-multiple-subfolders-in-terminal-bash-script (Not working)

# TODO: Check the mandatory arguments
#       $1 - The target directory
#       $2 - The number of files per directory
# TODO: Check the optional arguments
#       $3 - Verbose (yes/no)
#       $4 - DryRun  (yes/no)
#       $5 - Directory Prefix


TRUE=1
FALSE=0

DRY_RUN=$TRUE
VERBOSE=$TRUE

MAX_FILES_PER_DIRECTORY=30

DIR_PREFIX=dir_


declare -i filecount=0 # number of moved files per dir
declare -i dircount=0  # number of subdirs created per top level dir

if [ $VERBOSE -eq $TRUE ] 
then
    echo "Start"
    echo "Scaning directory: `pwd`"
fi

for f in *; 
do 

    if [[ -f $f ]]
    then

        #If the file counter is zero, then create a directory
        if [ "$filecount" -eq 0 ]
        then
            d=$DIR_PREFIX$(printf %03d $dircount);
            if [ $VERBOSE -eq $TRUE ] 
            then
                echo "Creating directory: $d"
            fi
            if [ $DRY_RUN -eq $FALSE ] 
            then
                mkdir $d
            fi
        fi

        if [ $VERBOSE -eq $TRUE ] 
        then
            echo "   Moving file $f to ${d}/"
        fi
        if [ $DRY_RUN -eq $FALSE ] 
        then
            mv "$f" $d;
        fi
        filecount+=1

        # When the file counter reaches the maximum files per directory then reset it.
        if [ "$filecount" -ge "$MAX_FILES_PER_DIRECTORY" ]
        then
            dircount+=1
            filecount=0
        fi
        
    fi

done

echo "End"