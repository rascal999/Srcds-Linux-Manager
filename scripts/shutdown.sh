#!/bin/bash

#shutdown.sh <server_name>

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1
SERVER_CFG=$2

rm $DIR/scripts/pid/$SERVER_NAME.pid 2>/dev/null
if [[ "$?" != "0" ]]; then
   echo "PID file for this instance did not exist, not shutting down. Use screen -R to shutdown.."
   exit
fi

/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Server shutting down in 5 seconds..\n'
echo "Shutting down $SERVER_NAME in 5 seconds.."
sleep 5

/usr/bin/screen -dR $SERVER_NAME -X stuff $'Exit\n'
echo "$SERVER_NAME was shutdown."
echo
echo "Don't forget to remove the check script for this instance from crontab"
echo "if you don't plan on booting this instance again.."
echo
