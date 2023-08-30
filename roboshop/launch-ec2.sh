#!/bin/bash

COMPONENT=$1

if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m \n\t\t | $ bash launch-ec2.sh shipping"
    exit 1
fi

AMI_ID="ami-0c1d144c8fdd8d690"
INSTANCE_TYPE="t3.micro"
SG_ID="sg-014f2d8e59de1c638"

#HOSTEDZONEID="Z0475481NBO60TX4OZ6V"


aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}]"
aws ec2 run-instances --image-id ami-0c1d144c8fdd8d690 --instance-type t3.micro --security-group-ids sg-014f2d8e59de1c638 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=lab]"


