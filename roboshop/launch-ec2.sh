#!/bin/bash

COMPONENT=$1
INSTANCE_TYPE="t3.micro"
HOSTEDZONEID="Z0475481NBO60TX4OZ6V"

if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m \n\t\t $ bash launch-ec2.sh shipping"
    exit 1
fi

#AMI_ID="ami-0c1d144c8fdd8d690"
#aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq .'SecurityGroups[].GroupID' | sed -e 's/"//g'

Create_ec2 () {
    AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')"
    SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')"

    echo -e "**** Creating \e[35m ${COMPONENT} \e[0m Server Is IN Progress ****"
    PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')
    echo -e "Private Ip Address of the $COMPONENT is $PRIVATEIP \n\n"
    echo -e "Creating DNS record of ${COMPONENT} :"

    sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json > /tmp/r53.json
    cat /tmp/r53.json

    aws route53 change-resource-record-sets --hosted-zone-id Z0475481NBO60TX4OZ6V --change-batch file:///tmp/r53.json
    cat /tmp/r53.json
    echo -e "\e[36m *** Creating DNS record for the  $COMPONENT has completed *** \e[0m \n\n"
}

if [ "$1" == "all"]; then
        for component in frontend mongodb catalogue user redis cart mysql rabbitmq shipping payment; do 
        COMPONENT=$component
        Create_ec2
    done
else 
    Create_ec2
fi



