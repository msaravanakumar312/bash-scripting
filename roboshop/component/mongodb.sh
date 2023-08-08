#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log "


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
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT} mongodb :"
yum install -y mongodb-org    &>> ${LOGFILE}
stat $?

echo -n "Enableing the ${COMPONENT} visibility :"
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl enable mongod  &>> ${LOGFILE}
systemctl start mongod   &>> ${LOGFILE}
stat $?

echo -n "Downloading the ${COMPONENT} schema :"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the ${COMPONENT} schema :"
cd /tmp
unzip -o ${COMPONENT}.zip   &>> ${LOGFILE}
stat $?

echo -n "Injecting the ${COMPONENT} schema :"
cd ${COMPONENT}-main
mongo < catalogue.js   &>> ${LOGFILE}
mongo < users.js       &>> ${LOGFILE}
stat $?











