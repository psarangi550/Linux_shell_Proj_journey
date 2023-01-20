#! /bin/bash


# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then 
    echo "You don't Have Rights to Execute the Script"
    exit 1
else
    # Get the username (login).
    # Get the real name (contents for the description field).
    # Get the password.
    #asking for user input to the user and storing to the variable over here 
    read -p 'Enter Your Username: ' username
    read -p 'Enter the Fullname: ' realnm
    read -p 'Enter Password: ' passw
    # Create the user with the password.
    #here we need to create the user with `useradd` command as below 
    useradd -c "${realnm}" -m ${username} #using the ${useradd} cvommand to use the -c i.e the realname as comment and -m means using the skeleton direcotory mapping here
    # Check to see if the useradd command succeeded.
    if [[ ${?} -eq 0 ]]
    then
        # Set the password.
        echo ${passw} | passwd --stdin ${username} #here setting the password for the user for the first time
        # Check to see if the passwd command succeeded.
        if [[ ${?} -eq 0 ]] 
        then
            # Force password change on first login.
            passwd -e ${username} #forcing to expire the password for the iuser after first login
            #echoing the info to the user
            #Display the username, password, and the host where the user was created.
            echo "username is :- ${username}"
            echo "password is :- ${passw}"
            echo "Hostname of the user is :- ${realnm}"
        else
            echo "Not able to Expire the Password and exit code is ${?}"
            exit 1
        fi
    else
        echo "Something went wrong and exit code retuned as ${?} for useradd command"
        exit 1
    fi
fi   

#echoing the message ON SUCCESSFUL completion    
echo "User Account Created Successfully"
#exiting as 0 which means the success stage
exit 0 
