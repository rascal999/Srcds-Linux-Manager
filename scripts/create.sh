#!/bin/bash

#create.sh <server_name> <server_config>

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1
SERVER_CFG=$2

#You may want to adjust this line if you wish to run something other than Gmod
/usr/bin/screen -dmS $SERVER_NAME $DIR/orangebox/srcds_run -console -game garrysmod -timeout 3 -pidfile $DIR/scripts/pid/$SERVER_NAME.pid +exec $SERVER_CFG

#Remove lock file from update procedure
if [[ -f $DIR/scripts/lock/$SERVER_NAME.update.lock ]]; then
   rm $DIR/scripts/lock/$SERVER_NAME.update.lock
fi
