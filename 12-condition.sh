#!/bin/bash


ACTION=start

case $ACTION in
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