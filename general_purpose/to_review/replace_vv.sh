#!/usr/bin/env bash
####################################################################################################
#Args           : 
#                   $1 directory or file 1 
#                   $2 directory or file 2 
#                   ...
#                   $n directory or file N
#Usage          :   ./replave_vv.sh -vR directory1 file2.txt                                                                                     
#Output stdout  :   
#Output stderr  :   
#Return code    :   
#Description	: Replaces the characters 'vv' and 'VV' by 'w' and 'W'
#                 execute the 'set_test.sh' script to set the test environment
#                                                                                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : https://stackoverflow.com/questions/14008125/shell-script-common-template
#                 https://devhints.io/bash
#                 https://linuxhint.com/30_bash_script_examples/
#                 https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash  
####################################################################################################


# TODOs
# 1- Do the recursive functionality
# 2- Do the verbose functionality
# 3- Do the dry-run functionality


# Options
#  -h , --help
#  -v , --verbose 
#  -R , --recursive  (Only applies for directories)
#  -d , --dry-run    
RECURSIVE=1
VERBOSE=1
DRY_RUN=1

# Arguments:
#   if argument is a file then process the file
#   if argument is a directory then process the directory contents
#   if no argument is supplied then process the $PWD directory
#   if multiple arguments are supplied, then the arguments are parsed one by one
ARGUMENTS=()


# Function to display usage instructions
function usage() {
    echo "Usage: ./$0 [OPTIONS]"
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --verbose    Enable verbose mode"
    echo "  --recursive  Enable recursive mode"
    echo "  --dry-run    Enable dry-run mode"
}


function parse_arguments {
    local -r SHORT_OPTIONS="hvRd"
    local -r LONG_OPTIONS=("help","verbose","recursive","dry-run")

    ! getopt --test > /dev/null 
    if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
        echo 'I’m sorry, `getopt --test` failed in this environment.'
        exit 1
    fi

    ! PARSED=$(getopt --options=$SHORT_OPTIONS --longoptions=$LONG_OPTIONS --name "$0" -- "$@")
    if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
        # e.g. return value is 1
        #  then getopt has complained about wrong arguments to stdout
        exit 2
    fi

    eval set -- "$PARSED"

    # now enjoy the options in order and nicely split until we see --
    while true; do
        #echo "parsing $1"
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -R|--recursive)
                RECURSIVE=0
                shift
                ;;
            -v|--verbose)
                VERBOSE=0
                shift
                ;;
            -d|--dry-run)
                DRY_RUN=0
                shift
                ;;
            --)
                shift
                break
                ;;
            *)
                echo "Programming error"
                exit 3
                ;;
        esac
    done

    #echo $RECURSIVE $VERBOSE $DRY_RUN
    #echo "here $@"

    if [[ $# -eq 0 ]]; then
        ARGUMENTS+=($PWD)
    else
        ARGUMENTS=($@)
    fi

    #echo "arguments length ${#ARGUMENTS[@]}"
    #echo ${ARGUMENTS[@]}
}

function print_verbose {
    if [[ $VERBOSE -eq 0 ]]; then
        echo "$@"
    fi
}

function is_invalid_name {
    local -r FILE=$(basename "$1")
    local -r PATTERN="(vv|VV)"
    if [[ "$FILE" =~ $PATTERN ]]; then
        return 0
    fi
    return 1
}

function is_valid_name {
    if is_invalid_name "$1"; then
        return 1
    fi
    return 0
}

function fix_name {
    # Do not echo anything in this function because that return garbage as file name
    local FILE=$(basename "$1")
    local DIRECTORY=$(dirname "$1")
    local NEW_FILE=${FILE//vv/w}
    NEW_FILE=${NEW_FILE//VV/W}
    if [[ "$FILE" != "$NEW_FILE" ]]; then
        mv "$DIRECTORY/$FILE" "$DIRECTORY/$NEW_FILE"
    fi
    echo "$DIRECTORY/$NEW_FILE"
}

function fix_contents {
    local FILE="$1"
    #echo "Sed over file: $FILE"
    #sleep 3
    sed -i 's/vv/w/g; s/VV/W/g' "$FILE" 
    if [[ $? -ne 0 ]]; then
        echo "ERROR processing file: $FILE ..."
        exit 1
    fi
}

function process_file {
    local FILE="$1"
    print_verbose "Processing file: $FILE ..."
    if is_invalid_name "$FILE"; then
        OLD_FILE=$FILE
        #echo "old file: $OLD_FILE"
        FILE=$(fix_name "$FILE")
        #echo "new file: $FILE"
        print_verbose "Renamed file: \"$OLD_FILE\" to \"$FILE\""
    fi   
	fix_contents "$FILE"
}

function process_directory {
    local DIRECTORY="$1"
    print_verbose "Processing directory: $DIRECTORY ..."
    if is_invalid_name "$DIRECTORY"; then
        OLD_DIRECTORY=$DIRECTORY
        DIRECTORY=$(fix_name "$DIRECTORY")
        print_verbose "Renamed directory: \"$OLD_DIRECTORY\" to \"$DIRECTORY\""
    fi    
    elements=( $(ls "$DIRECTORY") )
    for element in "${elements[@]}"; do
        path="${DIRECTORY}/${element}"
        if [[ -d "$path" ]]; then
            process_directory "$path"
        else
            process_file "$path"
        fi
    done
}

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
parse_arguments $@

for argument in "${ARGUMENTS[@]}"; do
    #print_verbose "Processing argument: $argument ..."
    # if is_valid_name "$argument"; then
    #     echo "is valid name"
    # else
    #     echo "is invalid name"
    # fi
    if [[ -f $argument ]]; then
        process_file "$argument"
    else
        process_directory "$argument"
    fi
done

IFS=$SAVEIFS


#
#
# function process_directory DIRECTORY
# 	iterate over elements in directory
# 	if $ELEMENT is a file
# 		process_file $ELEMENT
# 	else # Element is a directory
# 	 	process_directory $ELEMENT
# 
# function process_file FILE
#	FILE = fix_name FILE
#	fix_contents FILE
#	
# function fix_name FILE
#	if name contains vv (case insensitive)
#		NEVV_NAME = replace vv in name
#		mv FILE NEVV_NAME
#		return NEVV_NAME
#	return FILE
#	
#
# function fix_contents FILE
#	sed -i 's/vv/w/gI' $FILE     # Case insensitive
#
#
#
#####################################################################################


