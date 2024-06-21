#!/bin/bash

#DATE="$(date +%F)"
#SESSION_COUNT=$(who | wc -l)

#echo -e "Today date is \e[32m $DATE \e[0m"
#echo -e "Today time is \e[32m $TIME \e[0m"
#echo -e "Total number of active session count is \e[32m $SESSION_COUNT \e[0m"


DATE="$(date +%F)"
SESSION_COUNT="$(who | wc-l)"

echo  -e "Today date is \e[32m $DATE \e[0m"
echo -e "The total number of session count is \e[35m $SESSION_COUNT \e[0m"

