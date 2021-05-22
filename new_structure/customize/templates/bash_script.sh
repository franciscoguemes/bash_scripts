#!/usr/bin/env bash
####################################################################################################
#Script Name	: yourscriptname.sh                                                                                             
#Description	: Here it goes your description
#                                                                                 
#Args           :                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : https://devhints.io/bash
#                 https://linuxhint.com/30_bash_script_examples/
#                 https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash  
####################################################################################################

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
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# Start of the script
#-----------------------------------------------------------------------------
VARIABLE_1="Your variable definition"
VARIABLE_2="Another variable definition"
yourfunction $VARIABLE_1 $VARIABLE_2 # call to your function and pass two arguments

RESULT="$(yourfunction)" # Take yourfunction output result and store it in variable


