#! /bin/bash

work=" "
name=" "
age=" "
echo "Your name is:"
read name

echo "How old are you? "
read age

if [ $age -lt 18 ]
	then
		echo "Hello $name, you are still $age years old, you are not yet eligible to work"
else
		echo "Where do you work?"
read work
		echo "Hello $name, your are $age years old, eligible to work, and working at $work "

fi
