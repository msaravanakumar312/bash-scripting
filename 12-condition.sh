#!/bin/bash


ACTION=$1

case $ACTION in
start) 
    echo -e "\e[32m Starting payment service \e[0m"
    exit 0
    ;;

stop)
    echo -e "\e[35m Stopping payment service \e[0m"
    exit 1
    ;;

restart)
    echo -e "\e[33m Restarting payment service \e[0m"
    exit 2
    ;;
*)
    echo -e "\e[34m valid options are start or stop or restart \e[0m]"
    echo -e "\e[32m Example usage : bash scriptname stop "
    exit 3
    ;;
esac