#!/usr/bin/env bash
####################################################################################################
#Script Name	: commons.sh
#Description	: This script just contains common path resolution functions and definitions used by other scripts.
#
#               In order to import the contents of this script please use the syntax:
#                 source $(dirname "$0")/relative_path_to/commons.sh
#
#Author       : Francisco Güemes
#Email        : francisco.guemes@franciscoguemes.com
#See also	  : https://stackoverflow.com/questions/10822790/can-i-call-a-function-of-a-shell-script-from-another-shell-script
#               https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
####################################################################################################

#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# This function prints the directory where the script that calls the function is located.
# i.e:
#   "/home/user1/my_scripts/script1.sh"   ---> "/home/user1/my_scripts"
#   "cd /home/user1; ./my_scripts/script1.sh"   ---> "/home/user1/my_scripts"
#
# OUTPUTS:
#   The function will print the directory where the script that calls this function is located.
#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
function get_script_directory {
#  SOURCE="${BASH_SOURCE[0]}"
  SOURCE=$0
  while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  echo $DIR
}

