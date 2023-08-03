#!/bin/bash


ACTION=start

case $ACTIoN in
start) 
    echo "Starting payment service"
    ;;

stop)
    echo "Stopping payment service"
    ;;

restart)
    echo "Restarting payment service"
    ;;

esac