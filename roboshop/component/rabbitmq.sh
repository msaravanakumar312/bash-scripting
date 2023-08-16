
   #!/bin/bash

USER_ID=$(id -u)
COMPONENT=rabbitmq
LOGFILE="/tmp/${COMPONENT}.log "


source component/common.sh

 
echo -e "\e[35m Configuring ${COMPONENT} \e[0m"

echo -n "Configuring the ${COMPONENT} repositories :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> {LOGFILE}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> {LOGFILE}
stat $?


echo -n "Installing the ${COMPONENT} :"
yum install rabbitmq-server -y   &>> {LOGFILE}
stat $?

echo -n "starting nginx :"
systemctl enable ${COMPONENT}-server  &>> {LOGFILE}
systemctl start ${COMPONENT}-server   &>> {LOGFILE}
stat $?

echo -n "Creating ${COMPONENT} user account :"
rabbitmqctl add_user roboshop roboshop123  &>> {LOGFILE}
stat $?

echo -n "Configuring ${COMPONENT} permissions :"
rabbitmqctl set_user_tags roboshop administrator         &>> {LOGFILE}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> {LOGFILE} 
stat $?

echo -e "\n \e[32m ${COMPONENT} Installation Is Completed \e[0m \n"