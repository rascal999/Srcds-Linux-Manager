#!/bin/bash

#./check.sh <server_name> <server_config> [server_port]

source /home/gmod/srcds/scripts/globals.sh

SERVER_NAME=$1
SERVER_CFG=$2
SERVER_PORT=$3

#Check instance is alive
#Update?
if [[ -f $DIR/scripts/lock/$SERVER_NAME.update.lock || ! -f $DIR/scripts/pid/$SERVER_NAME.pid ]]; then exit; fi

Pid=`cat $DIR/scripts/pid/$SERVER_NAME.pid`
Instance_Alive=`ps -A | grep $Pid | wc -l`
if [[ $Instance_Alive != "1" ]]; then
   $DIR/scripts/create.sh $SERVER_NAME $SERVER_CFG $SERVER_PORT
fi
