#!/bin/bash 

# now here we are fetching the commad line args from the user based on that providing the port number

if [[ ${1} -eq -4 ]]
then
    echo "Here are the Ports belong to tcp4 and udp4"
    netstat -nutl ${1} | grep -Ev '^Active|^Proto' | awk '{print $4}' | awk -F ":" '{print $NF}'
else
    echo "Here are the Ports belong to tcp4 & tcp6 and udp4 & udp6 "
    netstat -nutl | grep -Ev '^Active|^Proto' | awk '{print $4}' | awk -F ":" '{print $NF}'
fi
