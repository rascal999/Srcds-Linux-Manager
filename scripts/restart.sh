#!/bin/bash

#./restart.sh <server_name> <server_config> [server_port]

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1
SERVER_CFG=$2
SERVER_PORT=$3

#Prevent check script restarting the server during update (Deprecated)
#touch $DIR/scripts/lock/$SERVER_NAME.update.lock

#If this file doesn't exist the create script will work and the check script will not (desired)
rm $DIR/scripts/pid/$SERVER_NAME.pid

/usr/bin/screen -dR $SERVER_NAME -X stuff $'say SVN repos updated..\n'
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 5 minutes...\n'
sleep 180
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 2 minutes...\n'
sleep 60
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 1 minute...\n'
sleep 30
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 30 seconds...\n'
sleep 20
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 10 seconds..\n'
sleep 5
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 5 seconds..\n'
sleep 1
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 4 seconds..\n'
sleep 1
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 3 seconds..\n'
sleep 1
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 2 seconds..\n'
sleep 1
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server restarting in 1 second..\n'
sleep 1
/usr/bin/screen -dR $SERVER_NAME -X stuff $'exit\n'
sleep 5

$DIR/scripts/create.sh $SERVER_NAME $SERVER_CFG $SERVER_PORT
