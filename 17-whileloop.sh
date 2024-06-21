#!/bin/bash
c=1
while [ $c -le 5 ]
do
	echo "Welcone $c times"
	(( c++ ))
done