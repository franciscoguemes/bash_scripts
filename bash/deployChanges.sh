#!/bin/bash
# The script deploy instant changes in the embedded Tomcat instance in Spring.
#
# In order to achieve this, the script perform the following operations:
#	1-) Listen for changes in the file bundles.js and replace it with the newer version 
#       2-) Change to the vc-dasboard target directory
#	3-) Run the npm watch tool that performs a hot deploy with the latest changes.
#

DASHBOARD_DIR=/home/francisco/git/Uniscon/backoffice-aggregator/backoffice-sealed-cloud/backoffice-dashboard
DASHBOARD_TARGET_DIR=$DASHBOARD_DIR/target

nohup changesListener.sh > /dev/null &

cd $DASHBOARD_TARGET_DIR

npm run watch
