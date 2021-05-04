#!/usr/bin/env bash
####################################################################################################
#Script Name	: yourscriptname.sh                                                                                             
#Description	: Here it goes your description
#                                                                                 
#Args           :                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco.gueemes@uniscon.com                                           
####################################################################################################

set -ex



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


