#
# IN CONSTRUCTION ... There is a Python version of this script in this directory
#

#!/bin/bash

# https://stackoverflow.com/questions/3124556/clean-way-to-launch-the-web-browser-from-shell-script

$BACKOFFICE_COMMONS='"https://gitlab.uniscon-rnd.de/idgard-backend/backoffice-commons/merge_requests"'
$EXPORT_JOB='"https://gitlab.uniscon-rnd.de/idgard-backend/export-job/merge_requests"'
$VC_DASHBOARD='"https://gitlab.uniscon-rnd.de/idgard-backend/vc-dashboard/merge_requests"'

function openInXdg {
	xdg-open $1
	xdg-open $2
	xdg-open $3	
}

function openInGnome {
	gnome-open $1
	gnome-open $2
	gnome-open $3
}

if which xdg-open > /dev/null
then
  openInXdg $BACKOFFICE_COMMONS $EXPORT_JOB $VC_DASHBOARD
elif which gnome-open > /dev/null
then
  openInGnome $BACKOFFICE_COMMONS $EXPORT_JOB $VC_DASHBOARD
fi
