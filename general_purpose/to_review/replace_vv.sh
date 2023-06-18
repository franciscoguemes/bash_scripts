#!/usr/bin/env bash
####################################################################################################
#Args           : 
#                   $1  What is the first argument?
#                   $2  What is the second argument?
#                   ...
#                   $n  What is the n-th argument?                                                                                         
#Usage          :   Typical example of usage of the script...                                                                                            
#Output stdout  :   What is the output of the script in stdout?
#Output stderr  :   What is the output of the script in stderr?
#Return code    :   Which status code does the script returns to the OS?
#Description	: Here it goes your description
#                                                                                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : https://stackoverflow.com/questions/14008125/shell-script-common-template
#                 https://devhints.io/bash
#                 https://linuxhint.com/30_bash_script_examples/
#                 https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash  
####################################################################################################

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


function fix_name {
    FILE="$1"
    NEW_FILE=${FILE//vv/w}
    NEW_FILE=${NEW_FILE//VV/W}
    if [[ "$FILE" != "$NEW_FILE" ]]; then
        mv "$FILE" "$NEW_FILE"
    fi
    echo "$NEW_FILE"
}

function fix_contents {
    local FILE="$1"
    echo "Sed over file: $FILE"
    sleep 3
    sed -i 's/vv/w/g; s/VV/W/g' "$FILE" 
    if [[ $? -ne 0 ]]; then
        echo "ERROR processing file: $FILE ..."
        exit 1
    fi
}

function process_file {
    local FILE="$1"
    if [[ $VERBOSE ]]; then
        echo "Processing file: $FILE ..."
    fi
	FILE=$(fix_name "$FILE")
	fix_contents "$FILE"
}

function process_directory {
    local DIRECTORY="$1"
    if [[ $VERBOSE ]]; then
        echo "Processing directory: $DIRECTORY ..."
    fi
    DIRECTORY=$(fix_name "$DIRECTORY")
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
    if [[ $VERBOSE ]]; then
        echo "Processing argument: $argument ..."
    fi
    if [[ -f $argument ]]; then
        process_file "$argument"
    else
        process_directory "$argument"
    fi
done

IFS=$SAVEIFS

exit


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


##################################################################################
#
# Form here down is to be deleted
#

set -ex


OPTIONS=dfo:v
LONGOPTS=debug,force,output:,verbose

function parse_arguments {
    ! getopt --test > /dev/null 
    if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
        echo 'I’m sorry, `getopt --test` failed in this environment.'
        exit 1
    fi

    ! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
    if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
        # e.g. return value is 1
        #  then getopt has complained about wrong arguments to stdout
        exit 2
    fi

    eval set -- "$PARSED"

    d=n f=n v=n outFile=-
    # now enjoy the options in order and nicely split until we see --
    while true; do
        case "$1" in
            -d|--debug)
                d=y
                shift
                ;;
            -f|--force)
                f=y
                shift
                ;;
            -v|--verbose)
                v=y
                shift
                ;;
            -o|--output)
                outFile="$2"
                shift 2
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

    # handle non-option arguments
    if [[ $# -ne 1 ]]; then
        echo "$0: A single input file is required."
        exit 4
    fi



}


#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Comment here your function
# GLOBALS: Enumerate here the global variables that this funciton uses
#   YOUR_GLOBAL_VARIABLE
# DEPENDS ON: List here other functions that are called iniside this function
#	yourotherfunction
# ARGUMENTS:
#	$1 - Explain the argument
#	$2 - 
# OUTPUTS:
#	If the caller of the function must take the output (stdout) as result, explain here
# RETURN:
#   If the caller must get the exit code ($?) Explain here: 0 if the function finish normally, non-zero on error.
#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
function yourfunction {
    # local MYLOCALVARIABLE # Your local variables definition

	# Here goes your code...
    
	# echo $? # Returns the return code (integer) of the last command in the function
    # echo $MYLOCALVARIABLE # Returns whatever is stored inside the variable (string / integer )
}


#-----------------------------------------------------------------------------
# Load functions from the other_script.sh file
#-----------------------------------------------------------------------------
source $(dirname "$0")/other_script.sh


#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# Start of the script
#-----------------------------------------------------------------------------
VARIABLE_1="Your variable definition"
VARIABLE_2="Another variable definition"
yourfunction $VARIABLE_1 $VARIABLE_2 # call to your function and pass two arguments

if [ $? -eq 0 ]
then
    echo "Last command in your function was successful"
else
    echo "ERROR: The last command in your function failed with code: $?" >&2
fi

# Take your function output result and store it in variable
result="$(yourfunction)" 
result="$(anotherfunction $(yourfunction))" 

#Concatenation of strings
variables="$VARIABLE_1$VARIABLE_2"
variables_and_literal_text="${VARIABLE_1}My literal string ${VARIABLE_2}"
command_output_and_literal_text="The date of today is: $(date)"

#Iterate over files
for filename in `pwd`; do
    echo $filename
    echo $filename | grep -oE "[[:digit:]]{8}_[[:digit:]]{6}" #Matching dates in file names
done

#Iterate over numbers
echo "Counting sheeps..."
for ((i=0; i<=3; i++)); do
    echo "    $1"
    sleep $i #Sleeping for seconds...
done

#Read input
echo -n "Enter the name of a country: "
read COUNTRY

#Echoing in the same line...
echo -n "The official language of $COUNTRY is "

#Switch - case
case $COUNTRY in

  Lithuania)
    echo -n "Lithuanian"
    ;;

  Romania | Moldova)
    echo -n "Romanian"
    ;;

  Italy | "San Marino" | Switzerland | "Vatican City")
    echo -n "Italian"
    ;;

  *)
    echo -n "unknown"
    ;;
esac
