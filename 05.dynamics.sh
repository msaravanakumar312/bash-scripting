#!/bin/bash

DATE="$(date +%F)"
SESSION_COUNT=$(who | wc -l)

echo "Today date is $DATE"
echo "Total number of active session count is $SESSION_COUNT"