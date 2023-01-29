#! /bin/bash

LIMIT=10

echo "count,ip,loc" > final.csv

#here reading the first command line args if provided then proceed else throw an error
if [[ ${#} -lt 1 ]]
then
    echo "Usage:${0} FILE" >&2
    exit 1
fi
#here the first command line args provided so need to check if it  is a valid file and readble or not 
if [[ ! -r "${1}" ]]
then
    echo "provided file is not readable try accessing through sudo or root priviledges" >&2
    exit 1
fi
#at this point the file provided and readble 

#here we need to fetch the ip address and number of times the ip address being repeated  as below 

count_val=$(cat syslog-sample | grep Failed | awk '{print $(NF -3)}'| sort -n | uniq -c | sort -nr )

#displaying the results 
# echo "${count_val}"

#here we need to disoplay the ip address for count which are greater than 10 

#here the Count and Ip are the variable we get  after the while loop read the stdin which contains each field value

echo "${count_val}" | while read COUNT IP
do
    if [[ $COUNT -gt ${LIMIT} ]] 
    then
        LOCATION=$(echo "$IP"| xargs geoiplookup | awk -F', ' '{print $NF}')
        #now we need to append that to the csv file as below
        echo "$COUNT,$IP,$LOCATION" >> final.csv
    fi
done

#here the script will be executed properly and show th value 
exit 0