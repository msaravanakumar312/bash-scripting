#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh"
    exit 1
fi

echo -e "\e[31m configuring frontend...! \e[0m \n"

echo -e "Installing frontend :"
yum install nginx -y   &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo -e "\e[31m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "\e[31m Strating Nginx: \e[0m"

systemctl enable nginx
systemctl start nginx

if [ $? -eq 0 ] ; then
    echo -e "\e[31m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "\e[31m Downloading the frontend component: \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

if [ $? -eq 0 ] ; then
    echo -e "\e[31m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf