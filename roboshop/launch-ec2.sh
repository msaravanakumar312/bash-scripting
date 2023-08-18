#!/bin/bash

COMPONENT=$1
if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m |$ bash launch-ec2.sh shipping"
    exit 1
fi

AMI_ID="ami-0c1d144c8fdd8d690"
INSTANCE_TYPE="t3.micro"
SG_ID="sg-014f2d8e59de1c638"            #b55-allow-all  security group id

echo "*******Creating $COMPONENT server is in progress******"
PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=lab}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo "Private ip of the $COMPONENT is $PRIVATEIP"