#!/bin/bash

#############################################################################################
#
# Description: The script takes a unique argument and copy it into the clipboard. Then it reproduces
#	the key combination ctrl+v to paste the text wherever the cursor is.
#
#	This script by itself makes no sense, but it can be used in combination with other scripts
#	from where the text is supplied to this script. The other scripts can be assigned to specific
#	keyboard combinations in the OS i.e. Ctrl+Shift+Y .
#
# Usage:
#	$>pasteText.sh "This is a sentence to paste!!!"
#
#
# Referenced by:
#	youtube_URL_base_paste.sh
#
# See:
#	https://stackoverflow.com/questions/18568706/check-number-of-arguments-passed-to-a-bash-script
#	https://stackoverflow.com/questions/749544/pipe-to-from-the-clipboard-in-bash-script?rq=1
#	https://askubuntu.com/a/653393
#	
#
#############################################################################################


if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 2
fi


echo $1 | xclip -selection clipboard
sleep 0.5
xdotool key ctrl+v


#echo $1 | xclip -selection clipboard
#sleep 0.5
#xdotool key ctrl+v


# This option needs rework. See option --window, probably you need to send the events to the right window
#xdotool type "https://www.youtube.com/watch?v="


# Only works in the command line...
#echo "You can simulate on-screen typing just like in the movies" | pv -qL 10


# Only works in the command line...
#echo "https://www.youtube.com/watch?v=" | xclip -selection clipboard
#xclip -selection clipboard -o


# echo "https://www.youtube.com/watch?v="
