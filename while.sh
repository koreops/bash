#!/bin/bash
###########
count=0
while [ $count -lt 10 ]
do
	echo "we are counting to 10"
	let count=count+1
	echo "our current number is $count"
done
