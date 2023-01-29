#! /bin/bash

#Enforces that it be executed with superuser (root) privileges or else exit the script 

if [[ ${UID} -ne 0 ]]
then
    echo "Login with Sudo Access ..."
    exit 1
fi

# here iterating trough the command args variable and capturing in the positional paramters and performing the action

while [[ "${#}" -gt 0 ]]
do
    username="${1}" #fetching the first command line args value 
    shift  #using the shift to capture the command line args
    relanm="${1}" #fetching the seconds command line args value 
    echo "$username"
    echo "$realnm"
    useradd -c "${realnm}" -m  ${username} #creating the user with default value and relaname also mentioned over here
    if [[ "${?}" -eq 0 ]]
    then
        passw=$(date +%s%N | sha1sum | head -c32 )
        echo ${passw} | passwd --stdin ${username}
        if [[ "${?}" -eq 0 ]]
        then 
            passwd -e ${username}
            echo 
            echo "password created successfully"
            echo
            echo "username is ${username}"
            echo "full name is ${relanm}"
            echo "password is ${passw}"
            echo 
        else
            echo "Something went wrong while creating the password "
            exit 1
        fi
    else
        echo "Something went Wrong while creating the user "
        exit 1
    fi
done

#if everything goes fine then user creayed successfully

exit 0
