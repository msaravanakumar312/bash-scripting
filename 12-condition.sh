#!/bin/bash


ACTION=$1

case $ACTIoN in
start) 
    echo "Starting payment service"
    exit 0
    ;;

stop)
    echo "Stopping payment service"
    exit 1
    ;;

restart)
    echo "Restarting payment service"
    echo 2
    ;;

esac