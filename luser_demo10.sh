#! /bin/bash

# log(){
#     echo "You called the Log Function Out in here"
# }

# we can also define the function as below 

# function  log { 
#     echo "You called the log function"as
# }

# # now here we are calling the log function as below 
# log


# log(){
#     local msg=${@}
#     echo "${msg}"
# }

# #calling the function with command line args as below 

# log 'Hello_World'
# log 'Good_Morning'

#usage of gloabl variable 
# verbose=true
# log(){
#     local msg=${@}
#     # verbose=true
#     # echo "the mmsgessage value is ${msg}"
#     if [[ ${verbose} == true ]]
#     then
#         echo "verbose been changes to true and value provided is ${msg}"
#         # return ${verbose}verbose
#     elif [[ ${verbose} == false ]]
#     then
#         echo "something went very wrong"
#         exit 1
#     fi   
# }

# #calling the function as belo
# # log true
# # echo "${verbose}"
# log 'rika'


#usage of global variable  but compairing the boolean value as the string

# log(){
#     local msg=${@}
#     # verbose=true
#     # echo "the mmsgessage value is ${msg}"
#     echo "verbose is ${verbose}"
#     if [[ "${verbose}" = 'true' ]]
#     then
#         echo "verbose been changes to true and value provided is ${msg}"
#         # return ${verbose}verbose
#     elif [[ "${verbose}" = 'false' ]]
#     then
#         echo "something went very wrong"
#         exit 1
#     fi   
# }

# log 'abismruta'
# verbose=true
# log 'abi'


# calling the function with multiple arguments


# log(){
#     local verbosity="${1}"
#     shift
#     #capturing the 1st argument and defining as the local variable `verbosity`
#     local msg="${*}" #capturing the rest_of the arguments as the 2nd args
#     #using the if block code in here 
#     if [[ "${verbosity}" = 'true' ]]
#     then
#         echo "${msg}" 
#     else 
#         echo "something went wrong"
#         exit 1
#     fi
# }
# #here we can all the function as below 
# log 'true' 'abismruta sarangi'
# log 'false' 'rika sarangi'
# #else we can declare the with variable as below
# # verbosity='true' # defining a global variable and use it as below
# # log "${verbosity}" 'abismruta sarangi'
# # log "${verbosity}" 'rika sarangi'ass

# log(){
#     local tag='my-script'
#     # local verbosity="${1}"
#     shift
#     #capturing the 1st argument and defining as the local variable `verbosity`
#     local msg="${*}" #capturing the rest_of the arguments as the 2nd args
#     #using the if block code in here 
#     if [[ "${verbosity}" = 'true' ]]
#     then
#         logger -t "${tag}" "${msg}" 
#         #once logger we can check whether the use have admin right if it has it can read that script
#         if [[ ${UID} -eq 0 ]]
#         then
#             tail -n1 "/var/log/messages" | xargs echo  
#         else
#             echo "does not have admin right"
#             exit 1
#         fi
#     else 
#         echo "something went wrong"
#         exit 1
#     fi
# }

# readonly verbosity='true'
# log "${verbosity}" 'Hi There'


# creating a backup file for script modification

backup_file(){
    #here we are providing the filename as the args which been captured in the positional paramter
    local file_provide="${1}"
    if [[ -f "${file_provide}" ]]
    then
        echo "File Exists"
    else
        echo "File does not exist"
        return 1
    fi
    local parent=$(dirname "${file_provide}")
    echo "${parent}"
    local file_name=$(basename "${file_provide}")
    echo "${file_name}" 
    cp "${parent}/${file_name}" "${parent}/copy_${file_name}"
    echo "${?}"
    if [[ "${?}" -eq 0 ]]
    then
        echo "file copied successfully"
    else
        echo "something went wrong"
        return 1
    fi
}

#calling  the function as below 
my_file='error.log'
backup_file "${my_file}"