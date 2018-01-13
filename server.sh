#!/bin/bash

# Assumes the path to the GMod server is wherever this script is located
GMODSERVERPATH="$( cd "$( dirname "$0" )" && pwd )"


#---------------------------
# CONFIG

# General config
SERVERNAME="gmod-dev-server" # Must be unique on this machine

# Server config
PORT=27015
MAXPLAYERS=15
MAP="gm_flatgrass"

# E.g. "+host_workshop_collection 12345 +gamemode terrortown"
ADDITIONALARGUMENTS=""

# Locations
CSSMOUNTPATH="$GMODSERVERPATH/css-mount"
LOGFILE="$GMODSERVERPATH/garrysmod/console.log"
ERRORLOGFILE="$GMODSERVERPATH/garrysmod/error.log"

# Programs
STEAMCMD="steamcmd"

# END OF CONFIG
#---------------------------


option=${1,,};
if [ -z $option ]; then
    echo "Pick an action: start|stop|update";
    echo "E.g. ./server.sh start";
    exit;
fi


case "$option" in

"start") echo "Starting server"
    LASTSTARTFILE="$GMODSERVERPATH/last_start"
    ARGUMENTS="-norestart -console -game garrysmod -nohltv -condebug +maxplayers $MAXPLAYERS -port $PORT +exec \"server.cfg\" +map $MAP $ADDITIONALARGUMENTS"

    # Stop the server if it's already running
    screen -S $SERVERNAME -X quit

    if [ -f $LOGFILE ]; then
        DATE=$(date +%Y-%m-%d_%H-%M-%S)
        if [ -f $LASTSTARTFILE ]; then
            DATE=$(head -n 1 $LASTSTARTFILE)
        fi

        echo $DATE;
        mv $LOGFILE "$GMODSERVERPATH/garrysmod/logs/$DATE.log"
    fi

    echo $(date +%Y-%m-%d_%H-%M-%S) > $LASTSTARTFILE

    screen -dmS $SERVERNAME "$GMODSERVERPATH/srcds_run" $ARGUMENTS >> $LOGFILE &> $ERRORLOGFILE
    ;;
"stop") echo "Stopping server"
    screen -S $SERVERNAME -X quit
    ;;
"update") echo "Updating server"
    $STEAMCMD +login anonymous +force_install_dir $GMODSERVERPATH +app_update 4020 validate +quit
    $STEAMCMD +login anonymous +force_install_dir $CSSMOUNTPATH +app_update 232330 validate +quit
    # Add other games you want to mount here
    ;;

esac