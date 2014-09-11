#!/bin/bash
##
##  Update Olympus Mincraft server
##
#############################################################

#environment configuration
SERVER_NAME="olympus"

SERVER_POS="/opt/msm/servers/"$SERVER_NAME""
MINECRAFT_CMD="/usr/local/bin/msm "$SERVER_NAME""
GIT_POS=""$SERVER_POS"/git"

#location of blacklist
BLACKLIST=""$GIT_POS"/util/blacklist.dat"

#stop the server
$MINECRAFT_CMD stop

#run update scripts
"$GIT_POS"/util/gitupdate.sh "$GIT_POS"
"$GIT_POS"/util/linkupdate.sh "$SERVER_POS"/mods "$GIT_POS"/minecraft/mods "$BLACKLIST"

#ensure proper file ownership
if [ $USER == "root" ]; then
  chown -R minecraft:minecraft /opt/msm
fi

#start the server
$MINECRAFT_CMD start
