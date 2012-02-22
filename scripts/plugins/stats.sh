#!/bin/bash

#stats.sh <server_name>

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1

#Necessary to enable new log file to appear and be able to tail it
sleep 20

tail -f $LOG/$SERVER_NAME/* | while read line; do
   Date=`date '+%H:%M:%S'`
   line=`echo $line | grep $Date`

   Stats=`echo $line | grep -Ei "say \"\!stats\"" | wc -l`
   if [[ "$Stats" != "0" ]]; then
      /usr/bin/screen -dR $SERVER_NAME -X stuff $'say Coming soon..\n'
   fi
done
