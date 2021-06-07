#!/bin/bash
# The script deploy instant changes in the embedded Tomcat instance in Spring.
#
# In order to achieve this, the script perform the following operations:
#	1-) Listen for changes in the file bundles.js and replace it with the newer version 
#       2-) Change to the aegis-webapp target directory
#	3-) Run the npm watch tool that performs a hot deploy with the latest changes.
#

AEGIS_WEBAPP_DIR=/home/francisco/git/Francisco/gitlab/aegis-aggregator/aegis-system/aegis-webapp
AEGIS_WEBAPP_TARGET_DIR=$AEGIS_WEBAPP_DIR/target

nohup aegisChangesListener.sh > /dev/null &

#Change to the directory where the file package.json is. This is the file which contains the instructions on how to build the bundle.js
cd $AEGIS_WEBAPP_DIR

#Scans the *.js files in the project for changes and builds the bundle.js file based on the information contained in package.json
npm run watch
