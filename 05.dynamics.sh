#!/bin/bash

DATE="$(date +%F)"
SESSION_COUNT=$(who | wc -l)

echo "Today date is /e[32m $DATE /e[0m"
echo "Total number of active session count is /e[32m $SESSION_COUNT /e[0m"