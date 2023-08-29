#!/bin/bash

COMPONENT=$1
INSTANCE_TYPE="t3.micro"
HOSTEDZONEID="Z0475481NBO60TX4OZ6V"

if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m $ bash launch-ec2.sh shipping"
    exit 1
fi
##aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-903004f8 --subnet-id subnet-6e7f829e
##--tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=production}]' 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq '.SecurityGroups[].GroupName' | sed -e 's/"//g')"    #b55-allow-all  security group id

Create_ec2 () {
    echo -e "******* Creating \e[35m ${COMPONENT} \e[0m server is in progress ******"
    PRIVATEIP="$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')"

    echo -e "Private Ip Address of the $COMPONENT is $PRIVATEIP \n\n" 
    echo -e "Creating DNS record of ${COMPONENT}: "

    sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json > /tmp/r53.json

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/r53.json
    echo -e "\e[35m *** Creating Dns Record for the $COMPONENT has Completed *** \e[0m \n\n"
    echo -e "Private Ip Address of the $COMPONENT is created and ready to use on ${COMPONENT}.roboshop.internal"
}

if [ "$1" == "all" ]; then
    for component in frontend mongodb catalogue user redis shipping payment cart mysql rabbitmq; do
    COMPONENT=$component 
    Create_ec2
done

else 
    Create_ec2
fi