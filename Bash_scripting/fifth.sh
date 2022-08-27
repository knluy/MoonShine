#!/bin/bash

guess=" "
value=10

echo "try to guess me: "

read guess  

if [ "$guess" = "$value" ]
	then
		echo "guess is true"

else 
		echo "guess is false"

fi

