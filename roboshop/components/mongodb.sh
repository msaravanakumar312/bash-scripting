#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh mongodb"
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

echo -n "Installing ${COMPONENT} repo :"    
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT} :"
yum install -y mongodb-org     &>> ${LOGFILE}
stat $?

echo -n "Enabling the ${COMPONENT} Visibility :"
sed -ie 's/127.0.0.0/0.0.0.0.0/g' /etc/mongod.conf  &>> ${LOGFILE}
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "Downloading the ${COMPONENT} schema :"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the ${COMPONENT} schema :"
cd /tmp
unzip mongodb.zip     &>> ${LOGFILE}
stat $?

echo -n "Injecting the ${COMPONENT} schema :"
cd mongodb-main
mongo < catalogue.js   &>> ${LOGFILE}
mongo < users.js       &>> ${LOGFILE}
stat $?

echo -n "Restarting the ${COMPONENT} :"
systemctl daemon-reload
systemctl restart mongodb
stat $?

echo -e "\e[33m ${COMPONENT} Installation Is completed \e[0m \n"


