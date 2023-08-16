echo "show databases;" | mysql -uroot -pRoboshop@1  &>> ${LOGFILE}
if [ $? -ne 0 ]; then
    echo -n "Performing default password reset of root account:"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD &>> ${LOGFILE}
    stat $?
fi
    
    echo "show plugins;" | mysql -uroot -pRoboshop@1 | grep validate_password  &>> ${LOGFILE}
if [ $? -ne 0 ]; then 
    echo -n "Uninstalling Password-validate plugin :"
    echo "uninstall plugin validate_password" | mysql -uroot -pRoboshop@1  &>> ${LOGFILE}
    stat $?
fi

    echo -n "Downloading the ${COMPONENT} schema :"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
    stat $?

    echo -n "Extracting the ${COMPONENT} schema :"
    cd /tmp
    unzip -o ${COMPONENT}.zip  &>> ${LOGFILE}
    stat $?

    echo -n "Injecting the ${COMPONENT} schema :" 
    cd ${COMPONENT}-main    
    mysql -u root -pRoboshop@1 <shipping.sql    &>> ${LOGFILE}
    stat $?

    echo -e "\n \e[32m ${COMPONENT} Installation Is Completed \e[0m \n"



