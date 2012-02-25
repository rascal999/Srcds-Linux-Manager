#!/bin/bash

#create.sh <server_name> <server_config> [server_port]

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1
SERVER_CFG=$2
SERVER_PORT=$3

#Instance already exists?
if [[ -f $DIR/scripts/pid/$SERVER_NAME.pid ]]; then
   echo "This instance already exists, not creating.."
   exit
fi

if [[ "$SERVER_PORT" == "" ]]; then
   #You may want to adjust this line if you wish to run something other than Gmod
   /usr/bin/screen -dmS $SERVER_NAME $DIR/orangebox/srcds_run -console -game garrysmod -timeout 3 -pidfile $DIR/scripts/pid/$SERVER_NAME.pid +exec $SERVER_CFG
else
   #You may want to adjust this line if you wish to run something other than Gmod
   /usr/bin/screen -dmS $SERVER_NAME $DIR/orangebox/srcds_run -console -game garrysmod -timeout 3 -port $SERVER_PORT -pidfile $DIR/scripts/pid/$SERVER_NAME.pid +exec $SERVER_CFG
fi

#Remove lock file from update procedure
if [[ -f $DIR/scripts/lock/$SERVER_NAME.update.lock ]]; then
   rm $DIR/scripts/lock/$SERVER_NAME.update.lock
fi

#Load plugins. Comment out to disable
$DIR/scripts/plugins/profanity.sh $SERVER_NAME &
$DIR/scripts/plugins/stats.sh $SERVER_NAME &
#$DIR/scripts/plugins/props.sh $SERVER_NAME &
