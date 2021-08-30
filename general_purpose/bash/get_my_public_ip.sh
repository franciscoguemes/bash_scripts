#!/usr/bin/env bash
####################################################################################################
#Script Name	: get_my_public_ip.sh                                                                                             
#Description	: Script that gets my public IP.
#                 The script makes a request to a website and scrapes my IP address from the body of
#                 the response (HTML).
#                                                                                 
#Args           :                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : https://devhints.io/bash
#                 https://linuxhint.com/30_bash_script_examples/
#                 https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash  
####################################################################################################

#set -eux

#-----------------------------------------------------------------------------
# Site variable definition.
#-----------------------------------------------------------------------------
SITE=http://ip4.me/

curl -s $SITE | grep -Eo "([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}"

# The exact same functionality as before but with a PCRE regex. Note the -P argument in grep.
#curl -s $SITE | grep -Po "(\d{1,3}\.){3}\d{1,3}"


