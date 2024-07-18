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
        echo -e "\e[31m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
    fi
}

echo -e "\e[31m configuring ${COMPONENT}...! \e[0m \n"

echo -n "\e[31m Installing ${COMPONENT} repo :"     &>> ${LOGFILE}
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

#echo -n "\e[31m Enabling the ${COMPONENT} Visibility :"


# systemctl enable mongod
# systemctl start mongod
# systemctl restart mongod
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js