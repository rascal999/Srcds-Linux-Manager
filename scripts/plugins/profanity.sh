#!/bin/bash

#profanity.sh <server_name>

#This plugin has only been tested on Gmod with ULX

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1

#Necessary for PID file to be created
sleep 60
/usr/bin/screen -dR $SERVER_NAME -X stuff $'say SLM:Profanity plugin loaded..\n'

#Tail file modified in last 2 mins
LogWatch=`find $LOG -type f -mmin -3`

tail -f --pid=`cat $DIR/scripts/pid/$SERVER_NAME.pid` $LogWatch | while read line; do
   Date=`date '+%H:%M:%S'`
   line=`echo $line | grep $Date`

   #Is instance still running?
   if [[ ! -f $DIR/scripts/pid/$SERVER_NAME.pid ]]; then
      exit
   fi

   #Yes, this is very pikey
   User=`echo $line | gawk -F "<" '{ print $1 }' | gawk -F '"' '{ print $2 }'`

   #Profanity
   while read word; do
      Swear=`echo $line | grep -Ei "$word" | wc -l`
      if [[ "$Swear" != "0" ]]; then
         #/usr/bin/screen -dR $SERVER_NAME -X stuff $'say Please do not swear..\n'
         /usr/bin/screen -dR $SERVER_NAME -X stuff $"ulx ignite $User\n"
         break
      fi
   done < $DIR/scripts/plugins/data/profanity/profanity_words
done
