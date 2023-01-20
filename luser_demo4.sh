#! /bin/bash

### <ins> How to Create Account in linux system

# - step:-1: To Ask the User to Provide Username
# - step:-2: To Ask the User to Provide real name
# - step:-3: To Ask the User to provide password
# - step:-4: To create the User with the Username from input value and set he password for the user from the input value
# - step:-5: force the user to change his/her password for the first time they login


### <ins> How to Take input from the User 

# reading the username over here
read -p 'provide username: ' usernm
read -p 'providee realname: ' realnm
read -p 'provide password: ' usrpasswd


#now displaying the value as 
echo "your input value is ${usernm}"
echo "your input value is ${realnm}"
echo "your input value is ${usrpasswd}"

# now here we are creating the user using the useradd command and getting the username and realname and passeord from the sure

if [[ "$UID" -eq 0 ]]
then
    useradd -c "${realnm}" ${usernm}
    echo ${usrpasswd} | passwd -e --stdin  ${usernm}
    passwd -e ${usernm}
    # su - "${usernm}"
else
    echo "You dont have admin rights"
fi

# now here we can also loggin in the user by saying as below 


exit 0