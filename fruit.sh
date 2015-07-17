#!/bin/bash
read -p "please enter a type of fruit: " fruit
if [ $fruit = mango ]
	then echo "good, I like mangos"
elif [ $fruit = banana ]
	then echo "good i like $fruit"
elif [ $fruit = orange ]
	then echo "i like $fruit"
	else echo "oh no, I hate $fruit"
fi

