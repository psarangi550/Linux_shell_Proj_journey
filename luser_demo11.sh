#! /bin/bash

#fetching different option from the user and implementing it accordingly using the `getopts` command

LENGTH=48

# creating a function rather for providing invalid option 

usgae(){
    echo "Usage:${0} [-v-s] [-l LENGTH]"
    echo "-v option is for making the script verbose"
    echo "-s option is for adding a special character to the password"
    echo "-l option is for generating the password of specific length"
    return 1
}

#creating a function for the verbose mode to log info to stderr

log(){
    if [[ "${verbose}" = 'true' ]]
    then
        echo "${@}"
    fi
}

#using the `getopts` inside the while loop
while getopts vl:s options 
do
    case $options in
        v) 
            verbose='true'
            log "Verbose Being On"
        ;;
        s) 
            special_char='true'
            log "generating password with special character"
        ;;
        l) 
            LENGTH=${OPTARG} # when the mandetory option provided it store its value to ${OPTARG} variable
            log  "Lenght Being of ${LENGTH} characters"
        ;;
        ?)
            # echo "Invalid Option" >&2
            # exit 1
            usgae
    esac
    
done

#as here the variable are not declared with the `local` keyword to create `local` variable hence we can use it outside as well
#now here we can declare if wlse to generate a random password
password=$(date +%s%N | sha256sum | head -c ${LENGTH} )
if [[ "${special_char}" != 'true' ]]
then
    log "Generating Password without Special Character Added"
    echo "${password}"
else
    log "Generating Password with Special Character Added"
    #Arithmetic substitution is spelled $(( )) and expands to the result.
    password=$(date +%s%N | sha256sum | head -c $((LENGTH-1)))
    random_symbol=$(echo "><?:;!" | fold -w1 | shuf | head -c1)
    password="${password}${random_symbol}"
    echo "${password}"
fi
