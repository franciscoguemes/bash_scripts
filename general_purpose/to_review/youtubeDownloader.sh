#!/bin/bash

#############################################################################################
#
# Description:
# 	The script shows a dialog that enquires the user on the purpose of the started session. 
# 	Whether the user wants to:
#		1-) Setup the working environment for Uniscon
#		2-) Setup the working environment for personal projects
#		3-) Other (No setup of any working environment)
#
# Referenced by:
#	referencing file: ~/.config/autostar/environmentChoice.desktop
#
# See:
# 	Zenit manual (version 3.24): https://help.gnome.org/users/zenity/3.24/
# 	Zenit Text Entry Dialog: https://help.gnome.org/users/zenity/3.22/entry.html.en
#	Check empty string in bash: https://timmurphy.org/2010/05/19/checking-for-empty-string-in-bash/
#	Funcitons in bash: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-8.html
#	
#	
#
#############################################################################################

OUTPUT_DIR=~/Videos

function downloadVideo {
	youtube-dl --output $OUTPUT_DIR $1
}


URL=$(zenity --entry \
        --title="Youtube Downloader" \
        --text="Enter the youtube URL:" \
      )

if [ -n "$URL" ]; then 
	echo "Downloading $?"
	downloadVideo $URL
else 
	echo "No URL entered"
fi
