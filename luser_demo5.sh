#! /bin/bash


#creating a random password of 10 character long over here
random_password=$(date +%s%N | sha256sum | head -c 10)

#we can display that to the screen as 
echo "${random_password}"
