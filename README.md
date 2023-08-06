######
#Color	Foreground Code	Background Code
#Red	31	41
#Green	32	42
#Yellow	33	43
#Blue	34	44
#####

#there is no concept of data types in linux or shell scripting
#By default every thing is string.

#If you input or variables are having special charecters,  enclose thses always in double coudes.

#How can I print the value of the variables?

#owing special charecters, we are going to print the value of variables.
# $ : special charecter is used to print the value of variables.
#echo $0
############

# bash arg1 arg2 arg3 arg4 arg5 arg6 arg7 arg8 arg9 arg10
#bash.scriptname.sh 100 200 300 (like this you can supply maximum of 9 variables from the command line)

# $* : is going to print the used variables
# $@ : is going to print the used variables
# $$ : is going to print the PID of the current process
# $# : is going to print the number of argument
# $? : is going to print the exit code of the last command

# Each and every action in linux will have a exit code
# 0 to 255  is the range of codes
# Among all, 0 represents action completed successfully
# Anything in between 1 to 255 represents either partial success, partial failiure, compute failuare.

#0         :Global success
#1 -125    :some failure from the command
#125+      :syntex failure


#exit codes also plays a key role in debugging big scripts.
#ex: if you're having a big script and if your script falls it's really challenging to figure out the mistakes as it makes us to watch over the entire script.
#Instead,we can use exit codes everywhere to find out where our script failure.

#single quotes : will suppress the power of a special variables(whenever you want to kill the property of the special variables use this single quotes.)
#Double quotes whenever you have any special variables, prefer to avoid single quotes and go with double quotes.


#There are four types of command available :

# 1> Binary    : /bin , /sbin
# 2> Aliases   : Aliases are shortcuts , alias netstat-tulpn*
# 3> Shell built in commands 
# 4> Functions  : Funtions is nothing but a set of command that can be written in a sequence and can be called n number of per


#Redirectors are 2 types
#1.Input redirector  (Means take input from the files) :  < (e.g) sudo mysql </tmp/studentapp.txt
#2.output redirector   > or 1  >> (>> append the latest output to the extent content.)

#outputs
#Standard output    > or 1>
#Standard Error     2> or 2>>
#Standard Output and Standard Error  &>  or &>>


#ls -ltr  > output.txt    :Redirects output to the output.txt
#ls -ltr >> output.txt    :Redirects and append the outputs to the output.txt
#ls -ltr 2> output.txt    :Redirects the errors only to the output.txt
#ls -ltr &> output.txt    :Redirects the error and output to the output.txt


#what is an expression? //whenever you're using operators to perform something, that's reffered as an expression.


#loop are used to excuted something for certain number of times

#They are two major types of loops:

#1) for loop : when you know something to be excuted n number of times, we use for loops

#2)while loop: when you don't know something to be excuted n number times, we use while loop.
