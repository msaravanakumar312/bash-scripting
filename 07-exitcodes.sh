#!/bin/bash

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
