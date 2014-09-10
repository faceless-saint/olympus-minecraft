#!/bin/bash
##
##  Script to pull down changes from GitHub
##
############################################
cd /tmp/olypmus-minecraft

# pull down latest version from GitHub and discard local changes
git fetch origin master
git reset --hard

# restart Olympus server
msm olympus restart
