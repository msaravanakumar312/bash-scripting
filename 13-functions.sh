#!/bin/bash


stat() {
    echo "Today date is $(date +%F)"
    echo "Average CPU utilization in last 5 minutes $(uptime | awk -F : '{print $NF}' | awk -F , '{print $2}')"
    echo "Number of logged in session is $(who | wc -l)"
}
stat