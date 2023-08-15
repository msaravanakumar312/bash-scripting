#!/bin/bash

USER_ID=$(id -u)
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log "


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

echo -e "\e[35m Configuring ${COMPONENT} \e[0m
echo -n "Installing frontend :"
yum install nginx -y   &>> LOGFILE
stat $?

echo -n "starting nginx :"
systemctl enable nginx    &>> LOGFILE
systemctl start nginx     &>> LOGFILE
stat $?


echo -n "Downloading the ${COMPONENT} component :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Clean up the frontend :"
cd /usr/share/nginx/html
rm -rf *      &>> LOGFILE
stat $?

echo -n "Extracting the ${COMPONENT} :"
unzip /tmp/${COMPONENT}.zip    &>> LOGFILE
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md     &>> LOGFILE 
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting ${COMPONENT} :"
systemctl daemon-reload      &>> LOGFILE  
systemctl restart nginx      &>> LOGFILE
stat $?


