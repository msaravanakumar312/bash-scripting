#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER=roboshop

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[35m Script is expected to excuted by the root user or sudo previllage \e[0m \n \t Example: sudo bash wrapper.sh ${COMPONENT}"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[32m Failure \e[0m"
    fi
}

echo -e "\e[33m configuring ${COMPONENT} ...! \e[0m \n"

echo -n "Configuring ${COMPONENT} repo :"   
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> ${LOGFILE}
stat $?

echo -n "Installing NodeJS :"
yum install nodejs -y     &>> ${LOGFILE}
stat $?

id ${APPUSER}   &>> ${LOGFILE}
if [ $? -ne 0 ] ; then 
    echo -n "Creating the application user Account :"
    useradd roboshop
    stat $?
fi


echo -n "Downloading the ${COMPONENT} file :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the ${COMPONENT} to ${APPUSER} home directory :"
cd /home/${APPUSER}/
unzip -o /tmp/${COMPONENT}.zip   &>> ${LOGFILE}
stat $?

echo -n "Changing the ownership :"
mv ${COMPONENT}-main ${COMPONENT}  &>> ${LOGFILE}
chown -R ${APPUSER}:${APPUSER}  /home/${APPUSER}/${COMPONENT}
stat $?

echo -n "Generating the ${COMPONENT} artifacts :"
mv ${COMPONENT}-main ${COMPONENT}  &>> ${LOGFILE}
cd /home/${APPUSER}/${COMPONENT}
npm install    &>> ${LOGFILE}
stat $?

echo -n "Configuring the ${COMPONENT} system file :"
sed -ie 's/MONGO_DNSNAME/54.81.218.120/' /home/${APPUSER}/${COMPONENT}/systemd.servce
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon-reload        &>> ${LOGFILE}
systemctl restart ${COMPONENT} &>> ${LOGFILE}
stat $?

echo -e "\e[35m ${COMPONENT} Installation Is completed \e[0m \n"









