#! /bin/bash

### Generating the random password as 

#creating the variables for the same 

password=${RANDOM}

#displaying the variable to the stdout

echo "${password}"

# Similarly creating more convulated password by using the random thrice as 

hard_pass=${RANDOM}${RANDOM}${RANDOM}

#display also that to the screen as 

echo "${hard_pass}"

#using the date as the possible password value with time elapsed

password=$(date +%s) #here assigning the date with format to the variable name
echo "${password}" #displaying the password variable to the stdout


# using the standalone `sha1sum` command o

passw=$(sha1sum ./luser_demo4.sh | cut -d " " -f 1)
#displaying the results as below 
echo "${passw}"


