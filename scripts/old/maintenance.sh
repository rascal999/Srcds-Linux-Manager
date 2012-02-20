#!/bin/bash

DIR='/home/gmod/srcds/'
SERVER_CFG="${!#}"
#DIR='/home/gmod/'$1

#MOUNTDIR=$DIR'/mount/'

#if [[ ! -d $MOUNTDIR ]]; then
#   echo "User does not exist!"
#   exit
#fi

#Arguments must be a valid map
if [[ $1 == "update" ]]; then
   for SERVER in "$@"
   do
      #Prevent check script restarting the server during update
      touch $DIR/$SERVER.update.lock

      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then
         /usr/bin/screen -dR $SERVER -X stuff $'say Updating SVN repos. This server will be restarting soon...\n'
         $DIR/orangebox/svn_update.sh
         /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 5 minutes...\n'
      fi
   done
   #sleep 180
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 2 minutes...\n'; fi
   done
   #sleep 60
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 1 minute...\n'; fi
   done
   #sleep 30
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 30 seconds...\n'; fi
   done
   #sleep 20
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 10 seconds..\n'; fi
   done
   #sleep 5
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 5 seconds..\n'; fi
   done
   #sleep 1
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 4 seconds..\n'; fi
   done
   #sleep 1
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 3 seconds..\n'; fi
   done
   #sleep 1
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 2 seconds..\n'; fi
   done
   #sleep 1
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'say Server restarting in 1 second..\n'; fi
   done
   sleep 1
   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dR $SERVER -X stuff $'exit\n'; fi
   done
   sleep 5

   for SERVER in "$@"
   do
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then /usr/bin/screen -dmS $SERVER $DIR/orangebox/srcds_run -console -game garrysmod +hostname \"Rascal999.co.uk :. $SERVER/phx/wire/svn\" +maxplayers 16 +map $SERVER -timeout 3 -pidfile $DIR/pid/$SERVER.pid +exec $SERVER_CFG; fi
   done

   #Kill servers specific to user
   #PIDFILES=`ls -Al $DIR/pid/* | wc -l`
   #if [ $PIDFILES != "1" ] ; then
   #   kill `cat $DIR/pid/*`
   #fi
fi

#Check instance is alive
if [[ $1 == "check" ]]; then
   for SERVER in "$@"
   do
      #Update?
      if [[ $SERVER != "update" && $SERVER != "$1" ]]; then
         if [[ -f $DIR/$SERVER.update.lock || ! -f $DIR/pid/$SERVER.pid ]]; then exit; fi

         Pid=`cat $DIR/pid/$SERVER.pid`
         Instance_Alive=`ps -A | grep $Pid | wc -l`
         if [[ $Instance_Alive != "1" ]]; then
            $DIR/orangebox/maintenance.sh $SERVER
         fi
      fi
   done
fi

for SERVER in "$@"
do
   if [[ "$SERVER" != "$0" && "$1" != "update" && "$1" != "check" ]]; then
      /usr/bin/screen -dmS $SERVER $DIR/orangebox/srcds_run -console -game garrysmod +hostname \"Rascal999.co.uk :. $SERVER/phx/wire/svn\" +maxplayers 16 +map $SERVER -timeout 3 -pidfile $DIR/pid/$SERVER.pid +exec $SERVER_CFG; fi
      #/usr/bin/screen -dmS $SERVER $MOUNTDIR/orangebox/srcds_run -console -game garrysmod +hostname \"Rascal999.co.uk :. $SERVER/phx/wire/svn\" +maxplayers 16 +map $SERVER -timeout 3 -pidfile $DIR/pid/$SERVER.pid; fi
   if [[ -f $DIR/$SERVER.update.lock ]]; then rm $DIR/$SERVER.update.lock; fi
done
