#!/bin/bash

#stats.sh <server_name>

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1

#Necessary for PID file to be created
sleep 60
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say SLM:Stats plugin loaded..\n'

#Tail file modified in last 2 mins
LogWatch=`find $LOG -type f -mmin -2`

tail -f --pid=`cat $DIR/scripts/pid/$SERVER_NAME.pid` $LogWatch | while read line; do
   Date=`date '+%H:%M:%S'`
   line=`echo $line | grep $Date`

   #Is instance still running?
   if [[ ! -f $DIR/scripts/pid/$SERVER_NAME.pid ]]; then
      exit
   fi

   Stats=`echo $line | grep -Ei "say \"\!stats\"" | wc -l`
   if [[ "$Stats" != "0" ]]; then
      /usr/bin/screen -dR $SERVER_NAME -X stuff $'say Coming soon..\n'
   fi
done
