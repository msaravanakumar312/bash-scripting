#!/bin/bash


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
