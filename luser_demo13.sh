#! /bin/bash

#here we are checking the user is root user or not

if [[ ${UID} -ne 0 ]]
then
    echo "You need the root access to delete an user" >&2
    exit 1 
fi

log(){
    message=${@}
    if [[ "$verbose" = 'true' ]]
    then
        echo "$message"
    fi
}

#now here we need to delete the user with removing the home directory if the -m option provided 

while getopts ru:v options 
do
    case ${options} in 
        v)
            verbose='true'
            log "verbose being On"
            ;;
        r)
            del_home='true'
            #defining the `del_home` as true which will decide whether we want to remove the home directory of the user
            ;;
        u)
            user=${OPTARG}
            #slecting the user as option provided 
            ;;
        ?)
            echo "invalid options" >&2
            exit 1
            ;;
    esac

done


#now as we have the `user` we can delete the user as 

if [[ "${del_home}" = 'true' ]]
then
    userdel -r "${user}" 
    echo "user ${user} deleted with home folder"
elif [[ "${del_home}" != 'true' ]]
then
    userdel -r "${user}" 
    log " only user ${user} deleted"
fi

if [[ ${?} -ne 0 ]]
then
    echo "something went wrong while deleting the user or user with home directory"
else
    echo "user deleted successfully"
fi

#now we can exit the script as 
exit 0