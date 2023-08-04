#!/bin/bash

echo "Demo on ifelse usage"

ACTION=$1

if [ "$ACTION" == "start" ]; then 
    echo -e "\e[32m Starting payment service \e[0m"
    exit 0

fi