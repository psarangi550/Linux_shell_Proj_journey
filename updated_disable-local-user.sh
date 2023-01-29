#! /bin/bash

#defining the archive_home directory

archieve_dir="/vagrant/archive"


# here we are checking that user is a superuser or not 

if [[ ${UID} -ne 0 ]] 
then
    echo "Please login as a superuser"
    exit 1
fi

#defining the usage function which will be called by the case statement 

usage(){
    echo "Usage:${0}[-dra]USER[USERNAME]..." >&2
    echo "-d delete the user instead of disabling them" >&2
    echo "-r remove the home directory of specified user" >&2
    echo "-a archive the home directory of specified user" >&2
    exit 1
}

# then we need to instruct the user to provide proper option with getopts
while getopts dra OPTION
do
    case "${OPTION}" in
        d)delete_user='true';;
        r)remove_home="-r";;
        a)archieve_home='true';;
        ?) usage ;;
    esac
done

#now we have to check how many command line arguments provided by the user and if it less than 1 throuw them an error as usage

#first we need to skip to the commad line option ignoring all the option for that we have to use the `${OPTIND}` as option

all_commands=$((OPTIND - 1))

#here we need to shift those option to get to the command 
shift $all_commands

#now  here we need to check if the command line args is greater than 1 or not 

if [[ "${#}" -lt 1 ]]
then
    usage #sending the usage message out in here and exit code of 1 which come from usage
fi

#now we need to loop through all the command line args provided using the positional paramter as below

for username  in "${@}"
do
    #checking the user must have ${UID} which shoul be less than 1000 as we don't want to delete sysadmin user
    echo "processing user ${username}"
    user_uid=$(id -u $username)
    echo "${user_uid}"
    if [[ "${user_uid}"  -lt 1000 ]] 
    then
        echo "user ${username} is a sysuser and refusing to disable or delete the user"  >&2
        exit 1
    fi
    #here till this point means the user is not a sysuser
    #now we need archived users home forlder if set the `archieve_home` as true
    if [[ "${archieve_home}" = 'true' ]]
    then
        home_dir="/home/${username}"
        if [[ ! -d "$home_dir" ]]
        then
            echo "Could not find the home directory ${home_dir} for ${username}"
            exit 1
        fi
        #here in this point we are able to get the home directory
        mkdir -p "${archieve_dir}"
        #creating the archive directory creation code 
        if [[ ${?} -ne 0 ]]
        then
            echo "can't create ${archiver_dir} for the user ${username}"
            exit 1
        fi
        archive_file="${archive_dir}/${username}.tgz"
        #here now we are able to see the $home_dir annd $archiver_dir hence now we can archive the home directory
        tar -zcf "${archive_file}" "${home_dir}"  1>/dev/null
        #supressing the output to the /dev/null folder
        if [[ ${?} -ne 0 ]]
        then
            echo "can't create ${archive_file} for the user ${username}"
            exit 1
        fi
        echo "archive ${archive_file} created successfully"
    fi

    # now here we need to disable and delete the user over here in the loop
    if [[ "$delete_user" = 'true' ]]
    then
        userdel ${remove_home} ${username}
        #removing the user if -r provided then it will remove the  home folder else not
        if [[ ${?} -ne 0 ]]
        then
            echo "can't delete  ${username} "
            exit 1
        fi
        #here means the user been deleted
        echo "${username} been deleted"
    else
        # now here just need to disable the user which will act accordingly
        chage -E 0 ${username}
        #here we are disabling the user over here 
        if [[ ${?} -ne 0 ]]
        then
            echo "can't diable ${username} "
            exit 1
        fi
        echo "user disabled successfully"
    fi
done











