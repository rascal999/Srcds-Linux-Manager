#!/bin/bash

#props.sh <server_name>

#This plugin requires ULX and EV

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1

#Necessary for PID file to be created
sleep 60

/usr/bin/screen -dR $SERVER_NAME -X stuff $'say SLM:Prop Spam Protection plugin loaded..\n'

#Tail file modified in last 2 mins
LogWatch=`find $LOG/$SERVER_NAME -type f -mmin -2`

tail -f --pid=`cat $DIR/scripts/pid/$SERVER_NAME.pid` $LogWatch | while read line; do
   Date=`date '+%H:%M:%S'`
   line=`echo $line | grep $Date`

   #Is instance still running?
   if [[ ! -f $DIR/scripts/pid/$SERVER_NAME.pid ]]; then
      exit
   fi

   #Yes, this is very pikey
   User=`echo $line | gawk -F '\\\[ULX\\\] ' '{ print $2 }' | gawk -F "<" '{ print $1 }'`

   #Spawn spam
   CurrentSpawnCount=`echo $line | grep -E "(spawned model|spawned NPC)" | wc -l`

   if [[ "$CurrentSpawnCount" != "0" ]]; then
      if [[ -f "$DIR/scripts/plugins/data/props/$User" ]]; then
         LastAccess=`stat -c %x "$DIR/scripts/plugins/data/props/$User" | gawk -F "[ .]" '{ print $2 }'`
         LastAccessTime=`date -d "$LastAccess" +%s`
      fi

      CurrentTime=`date +%s`
      ThreeSecondsAgo=`expr $CurrentTime - 3`

      #Spawn spam directory access times
      #LastDirAccess=`stat -c %x "$DIR/scripts/plugins/data/props/" | gawk -F "[ .]" '{ print $2 }'`
      #LastDirAccessTime=`date -d "$LastAccess" +%s`

      #Clear every 5 seconds or when last access on spawn spam directory was > 3 seconds ago
      if [[ $(( $CurrentTime % 3 )) -eq 0 || "$LastAccessTime" -lt "$ThreeSecondsAgo" ]]; then
         rm "$DIR/scripts/plugins/data/props/$User"
      fi

      echo "$line" >> "$DIR/scripts/plugins/data/props/$User"
      SpawnCount=`cat "$DIR/scripts/plugins/data/props/$User" | wc -l`
      if [[ "$SpawnCount" -gt "4" ]]; then
         /usr/bin/screen -dR $SERVER_NAME -X stuff $"ev cleanup $User\n"
         /usr/bin/screen -dR $SERVER_NAME -X stuff $"kick $User\n"
      fi
   fi
done
