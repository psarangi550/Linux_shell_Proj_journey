#! /bin/bash

#defining the default value for the LENGTh
LENGTH=48

#using the function defined inside case as usage statement

usage(){
    echo "Usage:${0}[-v-s][-l LENGTH]"
    echo "-v option is for making the script verbose"
    echo "-s option is for adding a special character to the password"
    echo "-l LENGTH option is for generating the password of specific lengtha and expect the LENGTH"
    return 1
}

log(){
    if [[ "$verbose" = 'true' ]]
    then
        echo "${@}"
    fi
}

#fetching the command line params using `getopts`

while getopts vl:s options
do
    case ${options} in
        v) 
            verbose='true'
            log "Verbose Mode On"
        ;;
        s) 
            special_char='true'
            log "Generating password with special characters"
        ;;
        l) 
            LENGTH=${OPTARG}
            log "Generating password with Length ${OPTARG}"
        ;;
        ?) 
            usage
            # echo "invalid option" >&2
            # exit 1
        ;;
    esac
done

log "command line options starts at the index ${#}"

shift $((OPTIND-1))

#using the if statement and make it as invalid option when passed with command line args
if [[ ${#} -gt 0 ]]
then
    usage
fi

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

# handling the commandline options in this case as

# log "command line options starts at the index ${#}"

# shift $((OPTIND-1))

# for item in ${@}
# do
#     echo "${item}"
# done


