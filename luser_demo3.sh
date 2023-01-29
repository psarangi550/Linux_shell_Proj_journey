#!/bin/bash

#Displaying the UID and username for the current user

echo "${UID}"

USER_TEST=$(id -nu)

echo "${USER_TEST}"

#Display Only if the ${UID} is not Equal to  1000 then it will match else it will not match

if [[ "${UID}" -ne 1000 ]]
then
    echo "Not a VagranT User"
    exit 1 # Here we are providing the Exit Status TO EXIT  the shell
fi
