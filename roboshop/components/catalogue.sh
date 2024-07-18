#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh ${COMPONENT}"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[32m Failure \e[0m"
    fi
}

echo -e "\e[33m configuring ${COMPONENT}...! \e[0m \n"

echo -n "Configuring ${COMPONENT} repo :"   
curl --silent --location https://rpm.nodesource.com/pub_16.x
stat $?

echo -n "Installing NodeJS :"
yum install nodejs -y     &>> ${LOGFILE}
stat $?



