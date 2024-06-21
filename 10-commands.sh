#!/bin/bash

#There are four types of command available :

# 1> Binary    : /bin , /sbin
# 2> Aliases   : Aliases are shortcuts , alias netstat-tulpn*
# 3> Shell built in commands 
# 4> Functions  : Funtions is nothing but a set of command that can be written in a sequence and can be called n number of per


sample() {
    echo hai from the sample function
    echo sample funtion is completed
}

sample

hai() {
    echo "This is the function hai"
    echo "Hai function ompleted"
}

hai

Stat() {
    echo "Number of session opened are $(who | wc -l)"
    echo "Today date is $(date +%F)"
    echo "Average CPU utilizations in last 5 minutes $(uptime | awk -F : '{print $NF}' | awk  -F , '{print $2}')"
    
}

Stat



