#!/bin/bash

USER_ID=$(id -u)
COMPONENT=user
LOGFILE="/tmp/${COMPONENT}.log "
APPUSER=roboshop

if [ $? -ne 0 ] ; then
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

echo -e "\e[35m Configuring ${COMPONENT}  \e[0m"
echo -n "Configuring ${COMPONENT} repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${LOGFILE}
stat $?

echo -n "Installing the nodejs :"
yum install -y nodejs    &>> ${LOGFILE}
stat $?

id ${APPUSER}    &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
    echo -n "Creating Appuser account :"
    useradd roboshop
    stat $?
fi

echo -n "Downloading the ${COMPONENT} :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the ${COMPONENT} to ${APPUSER} home directory :"
cd /home/${APPUSER}/
rm -rf ${COMPONENT}             &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip  &>> ${LOGFILE}
stat $?

echo -n "Changing the ownership :"
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/
stat $?

echo -n "Generating the ${COMPONENT} artifacts :"
cd /home/${APPUSER}/${COMPONENT}/
npm install    &>> ${LOGFILE}
stat $?

echo -n "Configuring ${COMPONENT} system file :"
sed -ie 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service &>> ${LOGFILE}
sed -ie 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service &>> ${LOGFILE}
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon-reload               &>> ${LOGFILE}
systemctl start ${COMPONENT}          &>> ${LOGFILE}
systemctl enable ${COMPONENT}         &>> ${LOGFILE}
stat $?

echo -e "\n \e[35m ${COMPONENT} Installing is completed \e[0m \n"

