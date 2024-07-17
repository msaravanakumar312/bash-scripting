#!/bin/bash

USER_ID=$(id -u)

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

echo -e "\e[31m configuring frontend...! \e[0m \n"

echo -n "Installing frontend :"
yum install nginx -y   &>> /tmp/frontend.log
stat $?

echo -n "Starting Nginx:"
systemctl enable nginx  &>> /tmp/frontend.log
systemctl start nginx   &>> /tmp/frontend.log
stat $?

echo -n "Downloading the frontend component :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?


echo -n "Clean up of frontend:"
cd /usr/share/nginx/html
rm -rf *   &>> /tmp/frontend.log
stat $?

echo -n "Extracting frontend:"
unzip /tmp/frontend.zip   &>> /tmp/frontend.log
stat $?


# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf