#!/bin/bash
##
##  Update Olympus Mincraft server
##
#############################################################

#UID validation
if [ $USER != "root" ] && [ $USER != "minecraft" ]; then
  echo "Err: script must be run as minecraft or root"
  exit 1
fi

#parse script arguments
case $# in
    1)
        SERVER_NAME="$1"
        BRANCH="master"
        ;;
    2)
        SERVER_NAME="$1"
        BRANCH="$2"
        ;;
    *)
        echo "Err: invalid arguments"
        echo "  usage: run.sh <server> [branch]"
        exit 1
        ;;
esac

#insert timestamp
echo "[`date`]"

#environment configuration
SERVER_POS="/opt/msm/servers/"$SERVER_NAME""
GIT_POS=""$SERVER_POS"/git"

#minecraft server manager
MINECRAFT_CMD="/usr/local/bin/msm "$SERVER_NAME""

#location of blacklist
BLACKLIST=""$GIT_POS"/util/blacklist.dat"

#stop the server
"$MINECRAFT_CMD" stop

#run update scripts
"$GIT_POS"/util/gitupdate.sh "$GIT_POS" "$BRANCH"
"$GIT_POS"/util/linkupdate.sh "$SERVER_POS"/mods "$GIT_POS"/minecraft/mods "$BLACKLIST"

#ensure proper file ownership
if [ $USER == "root" ]; then
    chown -R minecraft:minecraft "$SERVER_POS"
    chown -R minecraft:minecraft "$GIT_POS"
fi

#start the server
"$MINECRAFT_CMD" start
