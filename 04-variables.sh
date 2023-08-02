#!/bin/bash
#######
#there is no concept of data types in linux or shell scripting
#By default every thing is string.

#If you input or variables are having special charecters,  enclose thses always in double coudes.

#How can I print the value of the variables?

#owing special charecters, we are going to print the value of variables.
# $ : special charecter is used to print the value of variables.
#echo $0
############


a=10
b=05
c=a+b

echo -e "print hte value of a : $a"
echo -e "print the value of b : {b}"
echo -e "print the value of x : $x"

# x is not declared and we are attempting to print and it's not any going to report anything and it just shows null.

# [] : square bracket
# () : paranthesis
# {} : Flower brackets

#export x=150  :here export is to store the cpu memory on the system, all scripts memory is stored in a heap memory.

#DATA_DIR=robot

#rm -rf /data/$DATA_DIR/  #rm -rf /data   #rm -rf /data/robot
