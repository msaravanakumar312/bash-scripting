#!/bin/bash


f() {
    echo "Today date is $(date +%F)"
    echo "Average CPU utilization is $(uptime | awk -F : '{print $NF}', awk -F : '{print $2}')"
    echo "Number of logged in session is $(who | wc-l)"
}
fi