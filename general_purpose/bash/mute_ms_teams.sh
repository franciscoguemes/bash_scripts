#!/usr/bin/env bash

###################################################################
#
#
# See:
#	https://askubuntu.com/questions/53781/application-which-will-display-the-current-coordinates-of-the-mouse-cursor
# 	https://stackoverflow.com/questions/20595716/control-mouse-by-writing-to-dev-input-mice
#	https://unix.stackexchange.com/questions/321079/how-to-get-window-id-from-process-id
#	https://stackoverflow.com/questions/2250757/is-there-a-linux-command-to-determine-the-window-ids-associated-with-a-given-pro
#
##################################################################
#
# TODO: Get the screen position or the WindowId of the window where
#	MS teams is being executed.
#
#	https://stackoverflow.com/questions/49660403/how-to-get-all-opened-chromium-tabs-list-for-linux-in-cli
#
##################################################################

# This is the ID of the Chrome window where MS teams is executed
WINDOW=67108966

# The screen variable is always 0, the three screens are combined into a continuous one
NOTEBOOK_SCREEN=0

# In order to get the coordinates in the screen:
# 	xdotool getmouselocation
X=936
Y=921

LEFT_CLICK=1
MIDDLE_CLICK=2
RIGHT_CLICK=3

#xdotool mousemove --screen=$NOTEBOOK_SCREEN --window=$WINDOW $X $Y
xdotool mousemove --screen=$NOTEBOOK_SCREEN $X $Y

xdotool click $LEFT_CLICK
