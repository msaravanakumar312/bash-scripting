#!/bin/bash

COMPONENT=mysql

source component/common.sh

echo -e "\e[35m Configuring ${COMPONENT}.....! \e[0m"

echo -n "Configuring the ${COMPONENT} repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo  
stat $?

echo -n "Installing ${COMPONENT} :"
yum install mysql-community-server -y   &>> ${LOGFILE}
stat $?

echo -n "starting ${COMPONENT} :"
systemctl enable mysqld     &>> ${LOGFILE}
systemctl start mysqld      &>> ${LOGFILE}
stat $?

echo -n "Extracting the mysql default root password :"
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?

echo "show databases;" | mysql -uroot -pRoboshop@1  &>> ${LOGFILE}
if [ $? -ne 0 ]; then
    echo -n "Performing default password reset of root account:"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql  --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD  &>> ${LOGFILE}
    stat $?
fi

echo "show plugins;" | mysql -uroot -pRoboshop@1 | grep validate_password &>> ${LOGFILE}
if [ $? -ne 0 ]; then 
echo -n "Uninstalling password-validate plugin :"
echo "uninstall plugin validate_password" | mysql -uroot -pRoboshop@1 &>> ${LOGFILE}
stat $?
fi


#This sholud happen only once and that too for the first time,when it runs for the second time,jobs failure.
#We need ensure that runs only one.










