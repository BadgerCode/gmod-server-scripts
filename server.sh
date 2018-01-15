#!/bin/bash

# Assumes the path to the GMod server is wherever this script is located
GMODSERVERPATH="$( cd "$( dirname "$0" )" && pwd )"

source "config.sh"

option=${1,,};
if [ -z $option ]; then
    echo "Pick an action: start|stop|update|generate-config";
    echo "E.g. ./server.sh start";
    exit;
fi

SCREENNAME="$SERVERNAME-$PORT-$MAXPLAYERS"


case "$option" in
"generate-config") echo "Creating fresh configuration file"
    curl https://raw.githubusercontent.com/BadgerCode/gmod-server-scripts/master/config.sh?$(date +%s) > "$GMODSERVERPATH/config.sh"
    ;;
"start") echo "Starting server"
    LASTSTARTFILE="$GMODSERVERPATH/last_start"
    ARGUMENTS="-norestart -console -game garrysmod -nohltv -condebug +maxplayers $MAXPLAYERS -port $PORT +exec \"server.cfg\" +map $MAP $ADDITIONALARGUMENTS"

    # Stop the server if it's already running
    screen -S $SCREENNAME -X quit

    if [ -f $LOGFILE ]; then
        DATE=$(date +%Y-%m-%d_%H-%M-%S)
        if [ -f $LASTSTARTFILE ]; then
            DATE=$(head -n 1 $LASTSTARTFILE)
        fi

        echo $DATE;
        LOGDIR="$GMODSERVERPATH/garrysmod/logs";

        mkdir -p "$LOGDIR"
        mv $LOGFILE "$LOGDIR/$DATE.log"
    fi

    echo $(date +%Y-%m-%d_%H-%M-%S) > $LASTSTARTFILE

    screen -dmS $SCREENNAME "$GMODSERVERPATH/srcds_run" $ARGUMENTS >> $LOGFILE &> $ERRORLOGFILE
    ;;
"stop") echo "Stopping server"
    screen -S $SCREENNAME -X quit
    ;;
"update") echo "Updating server"
    $STEAMCMD +login anonymous +force_install_dir $GMODSERVERPATH +app_update 4020 validate +quit
    $STEAMCMD +login anonymous +force_install_dir $CSSMOUNTPATH +app_update 232330 validate +quit
    # Add other games you want to mount here
    ;;

esac