#!/bin/bash

#special variables gives special propeities to your variables.

#Here are few of the special variables : $0 to $9 , $? , $#, $$ , $@

a=10
b=20
c=30

echo $0        ## $0 prints the script name you're excuting
echo "Excuted script name is : $0"

echo "Name of recently launched rocket in india is $1"
echo "Popular EV vechicle in state is $2"
echo "Current topic is $3"


# bash arg1 arg2 arg3 arg4 arg5 arg6 arg7 arg8 arg9 arg10
#bash.scriptname.sh 100 200 300 (like this you can supply maximum of 9 variables from the command line)

# $* : is going to print the used variables
# $@ : is going to print the used variables
# $$ : is going to print the PID of the current process
# $# : is going to print the number of argument
# $? : is going to print the exit code of the last command

echo $0
echo $@
echo $$
echo $#
echo $?