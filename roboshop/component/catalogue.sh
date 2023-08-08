#!/bin/bash

USER_ID=$(id -u)
COMPONENT=nodejs
LOGFILE="/tmp/${COMPONENT}.log "
APPUSER=roboshop

if [ $1 -ne 0 ] ; then
    echo -e "\e[32m script is executed by the root user or with a sudo previllages \e[0m \n \t Example : sudo bash wrapper.sh frontend"
    exit 1
fi

stat () {
if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31 Failure \e[0m"
fi
}

echo -e "\e[35m Configuring ${COMPONENT}  \e[0m"
echo -n "Configuring ${COMPONENT} repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${LOGFILE}
stat $?

echo -n "Installing nodejs :"
yum install -y nodejs    &>> ${LOGFILE}
stat $?

id ${APPUSER}    &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
echo -n "Creating Appuser account :"
useradd roboshop
stat $?

fi

