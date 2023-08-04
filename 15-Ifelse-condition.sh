#!/bin/bash

echo "Demo on ifelse usage"

ACTION=$1

if [ "$ACTION" == "start" ]; then 
    echo -e "\e[32m Starting payment service \e[0m"
    exit 0

elif [ "ACTION" == "stop" ]; then

    echo -e "\e[31m stop payment service \e[0m"
    exit 1

elif [ "ACTION" == "restart" ]; then

    echo -e "\e[33m restart payment service \e[0m"
    exit 2
else

    echo -e "\e[32m Valid option are start or stop or restart \e[0m "
    echo -e "\e[32m Example usage \e[0m :/n /t bash scripting name stop"
    exit 3

fi