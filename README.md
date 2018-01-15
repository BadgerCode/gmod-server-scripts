# GMOD Server Scripts (Linux)

# Requirements
1. sudo apt-get install steamcmd

# Usage
```./server.sh start|stop|update|generate-config```

## First time usage
```bash
cd /path/to/my/gmod/server
curl https://raw.githubusercontent.com/BadgerCode/gmod-server-scripts/master/server.sh?$(date +%s) > server.sh
chmod u+x server.sh
./server.sh generate-config
./server.sh update
./server.sh start
```

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
Open up config.sh and look at the configuration section near the top.

**Important**: Make sure to stop your server before changing config.sh.

## Is my server running?
Use the command
```screen -ls```
and look for your SERVERNAME (set in config.sh).

## I can't install the steamcmd program
1. https://developer.valvesoftware.com/wiki/SteamCMD
2. Change "STEAMCMD" in config.sh to the location of your SteamCmd (e.g. "/home/me/steamcmd/steamcmd.sh")

## How do I restart the server when the machine restarts?
1. ```crontab -e```
2. Add a new line at the bottom: ```@reboot /full/path/to/server.sh start```

## Counter-Strike: Source isn't mounted on my server!
This script just updates/installs CSS. You have to tell the GMod server to use it.

1. https://wiki.garrysmod.com/page/Mounting_Content_on_a_DS (or google "garrymod mount")
2. The location of your CSS files is in the variable CSSMOUNTPATH

**Example**
```
Server location: "/home/badger/gmod-test-server"
...
CSSMOUNTPATH="$GMODSERVERPATH/css-mount"

Therefore, CSS files path is /home/badger/gmod-test-server/css-mount
```

## How do I update server.sh?
Stop the server during this.
```bash
cd /path/to/my/gmod/server
curl https://raw.githubusercontent.com/BadgerCode/gmod-server-scripts/master/server.sh?$(date +%s) > server.sh
chmod u+x server.sh
```
