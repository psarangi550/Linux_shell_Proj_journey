#! /bin/bash

if [[ ${UID} -ne 0 ]]
then
    echo "${0} Need Super user or root Access" 1>&2
    exit 1
fi


# creating a function named log over here

log()
{
    echo "usage:${0}[-dra ][-u username]"
    echo  "-d Deletes accounts instead of disabling them."
    echo  "-r Removes the home directory associated with the account(s)."
    echo  "-a Creates an archive of the home directory associated with the accounts(s) "
    exit 1
}

log_verbose(){
    message=${@}
    echo "${message}"
}

archive_user(){
    if [[  "$archive_usr"  = 'true' ]]
    then
        if [[ -d  "/vagrant/localuser/archive" ]]
        then
            tar -zcf  "${username}.tgz" "/home/${username}"
            log_verbose "archieve successful"
        else
            #create the archive folder
            mkdir  /vagrant/localuser/archive
            tar -zcf  "${username}.tgz" "/home/${username}"
            log_verbose "archieve successful"
        fi
    fi
}

# provide the usage statement if the user  does not provide an account name in the command line args as value 

if [[ ${#} -eq 0 ]]
then
    log 
fi

#using the while loop to get all the options out there

del_user='false'

while getopts aru:d options
do
    case "${options}" in
        u)
            username=${OPTARG}
            ;;
        d)
            del_user='true'
            ;;
        r)
            del_home='true'
            ;;
        a)
            archive_usr='true'
            ;;
        ?)
            log_verbose "invalid option"
            ;;
    esac
done


# Disables (expires/locks) accounts by default.
if [[ "${del_user}" = 'false' ]]
then
    archive_user
    chage -E 0 ${username}
    log_verbose "${username} been disabled"
elif [[ "${del_user}" = 'true' ]]
then
    if [[ "${del_home}" = 'true' ]]
    then
        archive_user
        userdel -r ${username}
        log_verbose "${username} been remove with home directory"
    elif [[ "${del_home}" = 'false' ]]
    then
        archive_user
        userdel ${username}
        log_verbose "${username} been remove without home directory"
    else
        echo "something went wrong while deleting ${username}"
    fi
else
    echo "something went wrong while disabling the user account"
fi


# now here  we have to check the user provide any additional command line args to nullify the same 

extra_args_loc=${OPTIND}

# echo "Additional ${OPTIND} arguments provided "

shift $((OPTIND-1))

if [[ ${#} -gt 0 ]]
then
    log
fi

#all process happend successfully 

exit 0

