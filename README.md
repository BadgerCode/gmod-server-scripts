# GMOD Server Scripts (Linux)

# Requirements
1. sudo apt-get install steamcmd

# Usage
```./server.sh start|stop|update```

## First time usage
1. ```cd /path/to/my/gmod/server```
2. ```curl https://raw.githubusercontent.com/BadgerCode/gmod-server-scripts/master/server.sh?$(date +%s) > server.sh```
3. ```chmod u+x server.sh```
4. ```./server.sh update```

### Example GMod Server Directory
*After installation*
* bin
* css-mount
* garrysmod
* platform
* server.sh
* sourceengine
* srcds_linux
* srcds_run
* steamapps



# Help
## How do I configure this?
Open up server.sh and look at the configuration section near the top.

## Is my server running?
Use the command
```screen -ls```
and look for your SERVERNAME (set in server.sh).

## I can't install the steamcmd program
1. https://developer.valvesoftware.com/wiki/SteamCMD
2. Change "STEAMCMD" in server.sh to the location of your SteamCmd (e.g. "/home/me/steamcmd/steamcmd.sh")

## How do I restart the server when the machine restarts?
1. ```crontab -e```
2. Add a new line at the bottom: ```@reboot /full/path/to/server.sh start```

## Counter-Strike: Source isn't mounted on my server!
This script just updates/installs CSS. You have to tell the GMod server to use it.

1. https://wiki.garrysmod.com/page/Mounting_Content_on_a_DS (or google "garrymod mount")
2. The location of your CSS files is in the variable CSSMOUNTPATH

**Example**
```
GMODSERVERPATH="/home/badger/gmod-test-server"
...
CSSMOUNTPATH="$GMODSERVERPATH/css-mount"

Therefore, CSS files path is /home/badger/gmod-test-server/css-mount
```

## How do I update server.sh?
1. Stop the server
2. Copy your existing server.sh
3. Perform the first 3 steps from **First time usage** (near the top of this readme)
4. Apply the config from the old server.sh to the new one