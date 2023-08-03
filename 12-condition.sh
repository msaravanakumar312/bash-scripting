#!/bin/bash


ACTION=$1

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
*)
    echo "valid options are start or stop or restart"
    echo "Example usage : bash scriptname stop"
    ;;
esac