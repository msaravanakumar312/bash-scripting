#!/bin/bash

COMPONENT=$1
INSTANCE_TYPE="t3.micro"
HOSTEDZONEID="Z0475481NBO60TX4OZ6V"
ENV=$2

if [ -z $1 ] || [ -z $2 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m \n \t \t"
    echo -e "\e[35m Ex Usage \e[0m |$ bash launch-ec2.sh shipping"
    exit 1
fi

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq '.SecurityGroups[].GroupName' | sed -e 's/"//g')"    #b55-allow-all  security group id



Create_ec2 () {
echo -e "*******Creating \e[35m ${COMPONENT}-${ENV} \e[0m server is in progress******"
PRIVATEIP="$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')"

echo -e "Private ip of the $COMPONENT-${ENV} is $PRIVATEIP \n\n" 
echo -e "Creating Dns record of ${COMPONENT}-${ENV} :"

sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json > /tmp/r53.json

cat /tmp/r53.json

aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/r53.json
echo -e "\e[35m *** Creating Dns Record for the $COMPONENT-${ENV} has Completed *** \e[0m"
}

if [ $1 == "all" ]; then
    for component in frontend mongodb catalogue user redis shipping payment cart mysql rabbitmq; do
    COMPONENT=$component 
    Create_ec2
done

else 
    Create_ec2
fi