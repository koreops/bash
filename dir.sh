#!/bin/bash
####
for db in `echo show databases | mysql -uroot -psqrt21.4`
do
	echo $db > dblist.txt
done
