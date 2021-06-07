#!/bin/bash

#############################################################################################
#
# Description:
#	The script supplies the base URL of a Youtube video (The video ID is missing), that part
#	is supposed to be supplied by the user later on. This script works in coordination with
#	the script pasteText.sh so the base URL supplied is expected to be pasted where the cursor
#	is.
#	
#	This script is expected of act as an anchor for a keyboard combination in the OS.
#	
# Referenced by:
#
#
# Depends on:
#	pasteText.sh
#
# See:
#	https://askubuntu.com/questions/280604/assign-hotkeys-to-paste-predefined-text
#	
#
#############################################################################################

YOUTUBE_BASE_URL="https://www.youtube.com/watch?v="

pasteText.sh $YOUTUBE_BASE_URL



