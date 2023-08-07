#!/bin/bash


USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m script is executed by the root user or with a sudo previllages \e[0m \n \t Example : sudo bash wrapper.sh frontend"
    exit 1
fi

echo -e "\e[35m Configuring frontend \e[0m"
echo -n "Installing frontend :"
yum install nginx -y   &>> /tmp/frontend.log


stat () {
if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31 Failure \e[0m"
fi
}

echo -n "starting nginx :"

systemctl enable nginx    &>> /tmp/frontend.log
systemctl start nginx     &>> /tmp/frontend.log
stat $?


echo -n "Downloading the frontend component :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Clean up the frontend :"
cd /usr/share/nginx/html
rm -rf *      &>> /tmp/frontend.log
stat $?

echo -n "Extracting the frontend :"
unzip /tmp/frontend.zip    &>> /tmp/frontend.log
stat $?


# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx
# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf