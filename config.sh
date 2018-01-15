#!/bin/bash

# General config
SERVERNAME="gmod-dev-server" # Must be unique on this machine


# Server config
PORT=27015
MAXPLAYERS=15
MAP="gm_flatgrass"

# E.g. "+host_workshop_collection 12345 +gamemode terrortown"
ADDITIONALARGUMENTS=""


# Locations
# GMODSERVERPATH represents your server's location
CSSMOUNTPATH="$GMODSERVERPATH/css-mount"
LOGFILE="$GMODSERVERPATH/garrysmod/console.log"
ERRORLOGFILE="$GMODSERVERPATH/garrysmod/error.log"


# Programs
STEAMCMD="steamcmd"
