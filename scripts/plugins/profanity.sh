#!/bin/bash

#profanity.sh <server_name>

#This plugin has only been tested on Gmod with ULX

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1

#Necessary to enable new log file to appear and be able to tail it
sleep 20

tail -f $LOG/$SERVER_NAME/* | while read line; do
   Date=`date '+%H:%M:%S'`
   line=`echo $line | grep $Date`

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
