#!/bin/bash
#conditions in bash scripting
# [ means test [[ means new test using [ is same as
using the command "test" to evaluate.
file=myscript.sh
if test -f $file
then
 echo "is a a file too"
fi
[ -f $file ] && echo "$file is a file"
#single bracket if statements refered to as "test"
brackets oldest and most compatibal "test"
#basic syntax have to quote strings cannot do file
globbing
emptystring=""
if [ -z "$emptystring" ]
then
echo "string is empty"
fi
if [ "$emptystring" == "" ]
then
echo "with single test brackets you must quote
your strings at all times"
fi
#flag conditions
#-gt = greater than
#-lt = less than
#-ge = greater than equal to
#-le = less than or equal to
#-eq = equal to
#-ne = not equalto
#-f = is file
#-d = is directory
#-l = is symlink
if [ 2 -gt 1 ]
then
echo "yes 2 is greater than 1"
fi
#double test brackets [[ ]]
#[[ allows shell globbing which means an * will expand
to literally anything
#word splitting is prevented so you can omit placing
quotes around string variables but it's not best
practice
mystring=sammy
if [[ "$mystring" == *mmy* ]]
then
echo "This determines if the string contains mmy
anywhere in it"
fi
if [[ $mystring == *[sS]a* ]]
then
echo " (notice no quotes) this determines if the
string contains sa or Sa anywhere in it"
fi
#expanding files names using [[]]
if [ -a *.txt ] #returns true if there is one single
file in the current working directory that has .txt in
it
then
echo "* with single test brackets expands to the
entire current working directory so it will error if
more than 1 file exists"
echo "there is at least one file that ends with
.txt in the dir"
fi
if [[ -a *.txt ]] #with double brackets the * is taken
literally'
then
echo "returns true only if there is a file name
*.txt (literally name"
fi
##double brackets allow for && and ||
## double brackets allow for regular expressions using
=~ not to be covered in this course
#&& is and for [[ but single test -a also works
#|| is for or and -o for single bracket also works
#double parenthesis (( )) used primarly for number
based condiations and allows use of >= operators
#Does not let you use flag condiations
#allows the use of && and || but not -a -o
#same as using the let command
