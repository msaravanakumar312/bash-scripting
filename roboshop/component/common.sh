##All the common functions will be declared here, rest of the components will be sourcing the funtion from this file:

LOGFILE="/tmp/${COMPONENT}.log "
APPUSER=roboshop

USER_ID=$(id -u)

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

CONFIG_SVC () {
    echo -n "Configuring ${COMPONENT} system file :"
    sed -i -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service 
    mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    stat $?

    echo -n "Starting the ${COMPONENT} service :"
    systemctl daemon-reload               &>> ${LOGFILE}
    systemctl start ${COMPONENT}          &>> ${LOGFILE}
    systemctl enable ${COMPONENT}         &>> ${LOGFILE}
    stat $?
}

DOWNLOAD_AND_EXTRACT () {

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
}

# Funtion to create a user account:
CREAT_USER () {
    id ${APPUSER}    &>> ${LOGFILE}
    if [ $? -ne 0 ] ; then
    echo -n "Creating Appuser account :"
    useradd roboshop
    stat $?
    fi
}

# Declaring a NODEJS Funtions:
NODEJS () {
    echo -e "\e[35m Configuring ${COMPONENT} .....! \e[0m"
    echo -n "Configuring ${COMPONENT} repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${LOGFILE}
    stat $?

    echo -n "Installing the nodejs :"
    yum install -y nodejs    &>> ${LOGFILE}
    stat $?

CREAT_USER              #calls CREATE_USER funtion that create user account

DOWNLOAD_AND_EXTRACT  #Downloads and extract the components.

    echo -n "Generating the ${COMPONENT} artifacts :"
    cd /home/${APPUSER}/${COMPONENT}/
    npm install    &>> ${LOGFILE}
    stat $?

}

MVN_PACKAGE() {

    echo -n "Generating the ${COMPONENT} artifacts :"
    cd /home/${APPUSER}/${COMPONENT}/
    mvn clean package   &>> ${LOGFILE}
    mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar
    stat $?
}

JAVA() {

    echo -e "\e[32m Configuring ${COMPONENT}.......! \e[0m"

    echo -n "Installing maven :"
    yum install maven -y &>> ${LOGFILE}
    stat $?

CREAT_USER              #calls CREATE_USER funtion that create user account

DOWNLOAD_AND_EXTRACT  #Downloads and extract the components

MVN_PACKAGE

CONFIG_SVC

}

PYTHON() {
    echo -e "\e[32m Configuring ${COMPONENT}.......! \e[0m"

    echo -n "Installing  python:"
    yum install python36 gcc python3-devel -y &>> ${LOGFILE}
    stat $?

    CREAT_USER              #calls CREATE_USER funtion that create user account

    DOWNLOAD_AND_EXTRACT  #Downloads and extract the components

    echo -n "Generating the ${COMPONENT} artifacts :"
    cd /home/${APPUSER}/${COMPONENT}/ 
    pip3 install -r requirements.txt &>> ${LOGFILE}
    stat $?

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)

    echo -n "Updating the uid and gid in the ${COMPONENT}.ini file :"
    sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid c gid=${GROUPID}" /home/${APPUSER}/${COMPONENT}/${COMPONENT}.ini 
    stat $?

CONFIG_SVC

}





