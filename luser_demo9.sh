
#echo something if the first command line args passed have the name as start else echo as failed 

# for item in "$@" 
# do
#     if [[ "${1}" = 'start' ]] 
#     then
#         echo "passed"
#     else
#         echo "failed"
#     fi
# done

#using the elif statement out in here

# if [[ "${1}" = 'start' ]] 
# then
#     echo "start"
# elif [[ "${1}" = 'stop' ]]
# then 
#     echo "stopped"
# else
#     echo "failed"
# fi


#using the case statement instead of the if statement for the same reason

# case "${1}" in #start the line with the case with the variable we want to match agaist the pattern  and end line with `in`
# start) #matching up againsta the start
#     echo "start"
#     ;; #to close the command statement
# stop) #stop the command
#     echo "stop"
#     ;;
# *) #anything else then 
#     echo "not a valid match " >&2
#     exit 1
# esac #spell revese so that case command can be stopped


#using multiple pattern using the `or` or `|` command

case "${1}" in #start the line with the case with the variable we want to match agaist the  pattern and end line with `in`
start|restart) #matching up againsta the start or restart
    echo "start/restart"
    ;; # close the command statement
stop) #stop the command
    echo "stop"
    ;; # close the command statement
*) #anything else then 
    echo "not a valid match " 2>/dev/null >&2 
esac #spell revese so that case command can be stopped