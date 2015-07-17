#!/bin/bash
###
##create 2 files
set -e
username=$USER
if [ -a file"*".txt ]
	then rm file"*".txt
fi
touch file1.txt file2.txt
echo "$username" >> file1.txt


