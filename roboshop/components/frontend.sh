#!/bin/bash

USER_ID=$(id -u)
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh frontend"
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

echo -n "Installing ${COMPONENT}:"
yum install nginx -y   &>> ${LOGFILE}
stat $?

echo -n "Starting Nginx:"
systemctl enable nginx  &>> ${LOGFILE}
systemctl start nginx   &>> ${LOGFILE}
stat $?

echo -n "Downloading the ${COMPONENT} component :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/{COMPONENT}/archive/main.zip"
stat $?


echo -n "Clean up of ${COMPONENT}:"
cd /usr/share/nginx/html
rm -rf *   &>> ${LOGFILE}
stat $?

echo -n "Extracting ${COMPONENT} :"
unzip /tmp/frontend.zip   &>> ${LOGFILE}
mv ${COMPONENT}-main/* .   
mv static/* .             
rm -rf ${COMPONENT}-main README.md   
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting the Nginx:"
systemctl deamon-reload   &>> ${LOGFILE}
systemctl restart nginx   &>> ${LOGFILE}
stat $?



