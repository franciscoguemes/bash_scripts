#!/bin/bash
# This listens for changes in a file and then perform the defined action.
# See: https://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes
# The scripts uses inotify: https://github.com/rvoicilas/inotify-tools/wiki

DASHBOARD_DIR=~/git/Uniscon/backoffice-aggregator/backoffice-sealed-cloud/backoffice-dashboard
DASHBOARD_TARGET_DIR=$DASHBOARD_DIR/target

while inotifywait -e close_write $DASHBOARD_DIR/src/main/resources/static/built/bundle.js; do 
	cp $DASHBOARD_DIR/src/main/resources/static/built/bundle.js $DASHBOARD_TARGET_DIR/classes/static/built/bundle.js ;
	sleep .5
	cp $DASHBOARD_DIR/src/main/resources/static/built/bundle.js.map $DASHBOARD_TARGET_DIR/classes/static/built/bundle.js.map ; 
	echo copying bundle.js on `date +"%H:%M:%S.%s"` 
done


