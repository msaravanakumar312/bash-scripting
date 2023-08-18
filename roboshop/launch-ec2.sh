#!/bin/bash

COMPONENT=$1
if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m |$ bash launch-ec2.sh shipping"
    exit 1
fi

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq '.SecurityGroups[].GroupName' | sed -e 's/"//g')"    #b55-allow-all  security group id
INSTANCE_TYPE="t3.micro"



echo -e "*******Creating \e[35m ${COMPONENT} \e[0m server is in progress******"
PRIVATEIP="$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=lab}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')"

echo "Private ip of the $COMPONENT is $PRIVATEIP"



