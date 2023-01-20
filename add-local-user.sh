#! /bin/bash

if [[ ${UID} -ne 0 ]]
then 
    echo "You don't Have Rights to Execute the Script"
    exit 1
else
    #asking for user input to the user and storing to the variable over here 
    read -p 'Enter Your Username: ' username
    read -p 'Enter the Fillname: ' realnm
    read -p 'Enter Password: ' passw

    #here we need to create the user with `useradd` command as below 
    useradd -c "${realnm}" -m ${username} #using the ${useradd} cvommand to use the -c i.e the realname as comment and -m means using the skeleton direcotory mapping here
    echo ${passw} | passwd --stdin ${username} #here setting the password for the user for the first time
    passwd -e ${username} #forcing to expire the password for the iuser after first login

    #echoing the info to the user
    echo "username is :- ${username}"
    echo "password is :- ${passw}"
    echo "Hostname of the user is :- ${realnm}"
fi    

#echoing the message ON SUCCESSFUL completion    
echo "User Account Created Successfully"
#exiting as 0 which means the success stage
exit 0 


