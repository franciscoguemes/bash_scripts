#!/bin/bash

#############################################################################################
#
# Description:
# 	This script simply goes to vmdev01 and download the latest Serenity report in the 
#	current working directory 
#
# Referenced by:
#	
#	
#############################################################################################

scp -r uniscon@vmdev01:/var/lib/jenkins/workspace/builds/uniscon/backoffice-aggregator/backoffice-tests/dashboard-tests/target/site/serenity .
