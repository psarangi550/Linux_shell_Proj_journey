#! /bin/bash

# Executing the Script if the user is an  administrator

err_file='error.log'

if [[ ${UID} -ne 0 ]]
then
    #redirecting the echo statement into the stderr  from stdout 
    echo "Login As Administrator " 2>${err_file} 1>&2 
    #if we really want to see whether the stdout been redirected to stderr then we can redirect the stderr to a file in there we can see stdout as well as we have redirect that before 
    #there should not be any spaces in here
    exit 1
fi 

# provide usage if the client not providing any of the following `username` and `client` parameters

if [[ ${#} -lt 1 ]]
then
    echo "Provide the command as ${0} [username] [full name] ..." >&2
    exit 1
else
    for item in ${@}
    do
        echo "${item}" > /dev/null
    done
fi


# Here  if the previous if statement successfull then this will be displayed as info

username=${1} #fetching the username from the positional parameter
shift 1 #removing the ${1} so ${#} become 1 less and ${2} will be displaced to ${1} or we can catch everything as ${*}
fullname=${*} # here capturing everything else as single string


# now here we are creating the user for those account as below 

useradd -c "${fullname}" -m  ${username} &> /dev/null

#validating the previous command being successful or not 

if [[ "${?}" -ne 0 ]]
then
    echo "Something Went Wrong While creating the User" 1>&2
    exit 1
fi

#generating the random password from the passwd command as below

random_pass=$(date +%s%N | sha256sum | head -c32 )

#now  if the previous `if` successful then command comes over here 

echo "${random_pass}" | passwd  --stdin  ${username} > /dev/null


#validating the previous command being successful or not 

if [[ "${?}" -ne 0 ]]
then
    echo "Something Went Wrong While creating the Password" 1>&2
    exit 1
fi

# now here we will expire the password nd putting info to the /dev/null

passwd -e ${username} > /dev/null

#now  we have to show all the info to the user as below 

echo
echo "username: ${username}"
echo "fullname: ${fullname}"
echo "password: ${random_pass}"
echo
#if everything goes good then  we will get the exit code of 0

exit 0



