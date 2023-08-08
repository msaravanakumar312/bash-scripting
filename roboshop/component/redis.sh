#!/bin/bash

USER_ID=$(id -u)
COMPONENT=redis
LOGFILE="/tmp/${COMPONENT}.log"


if [ $USER_ID -ne 0 ] ; then
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

echo -e "\e[35m Configuring ${COMPONENT} redis \e[0m"

echo -n "Configuring ${COMPONENT} repo :"
curl -s -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/redis.repo -o /etc/yum.repos.d/${COMPONENT}.repo  &>> ${LOGFILE}
stat $?

echo -n "Installing the ${COMPONENT} redis :"
yum install redis-6.2.12 -y  &>> ${LOGFILE}
stat $?

echo -n "Enableing the ${COMPONENT} redis :"
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${COMPONENT}.conf  &>> ${LOGFILE}
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${COMPONENT}/${COMPONENT}.conf  &>> ${LOGFILE}
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload        &>> ${LOGFILE}
systemctl enable ${COMPONENT}  &>> ${LOGFILE}
systemctl start ${COMPONENT}   &>> ${LOGFILE}
stat $?




