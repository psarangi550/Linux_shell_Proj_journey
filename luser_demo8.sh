#! /bin/bash

if [[ ${UID} -ne 0 ]]
then
    # echo "You Need to have Sudo or Root Priviledges for this command" >&2 | exit 1
    #   or we can put the full command as below for the same
    echo "You Need to have Sudo or Root Priviledges for this command" 1>&2 | exit 1
fi #closing the id statement   