#!/bin/bash


USER_ID=$(id -u)
COMPONENT=$1
LOGFILE=/tmp/frontend.log

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh"
    exit 1
fi

stat() {
    if [ $? -eq 0 ] ; then
        echo -e "\e[31m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
    fi
}

echo -e "\e[31m configuring {COMPONENT}...! \e[0m \n"

echo -n "Installing {COMPONENT} :"
yum install nginx -y   &>> {LOGFIlE}
stat $?

echo -n "Starting Nginx:"
systemctl enable nginx  &>> {LOGFIlE}
systemctl start nginx   &>> {LOGFIlE}
stat $?

echo -n "Downloading the {COMPONENT} component :"
curl -s -L -o /tmp/{COMPONENT}.zip "https://github.com/stans-robot-project/{COMPONENT}/archive/main.zip"
stat $?


echo -n "Clean up of {COMPONENT}:"
cd /usr/share/nginx/html
rm -rf *   &>> {LOGFIlE}
stat $?

echo -n "Extracting {COMPONENT}:"
unzip /tmp/{COMPONENT}.zip   &>> {LOGFIlE}
stat $?

echo -n "Sorting of {COMPONENT}:"
mv {COMPONENT}-main/* .   &>> {LOGFIlE}
mv static/* .             &>> {LOGFIlE}
rm -rf {COMPONENT}-main README.md   &>> {LOGFIlE}
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting the {COMPONENT}:"
systemctl deamon-reload   &>> {LOGFIlE}
systemctl restart nginx   &>> {LOGFIlE}
stat $?



