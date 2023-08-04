#!/bin/bash

If condition is ideally available in 3 types:

simple if   # for example if the condition is true i want this to be excuted, this is called as simple if.
If else     # If the condition is false if i want something else to be excuted.
Else if     # if the suituation is multipul choice e.g: a=10 do this, b=20 do this so that if i want to anything else in this something else to be excuted.


Simple If:

if [ expression ]; then 
    commands

fi    

#command are going to be excuted only if the expression is true.
#What will happen if the expression is falls, the simple if won't be excuted.


<<COMMENT
If else :

if [ expression ]; then 

    command 1

else

    command 2
fi

#If the expression is true the command 1 wil be excuted, if the expression is not true the command 2 will be excuted.

Else If :

if [ epression ]; then 
    command 1

elif [ expression ]; then
    command 2

elif [ expression 3]; then 
    command 3

else
    command 4
fi 
COMMENT

#what is an expression? //whenever you're using operators to perform something, that's reffered as an expression.

