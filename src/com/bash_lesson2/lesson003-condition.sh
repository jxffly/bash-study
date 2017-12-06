#!/usr/bin/env bash
x=70

if [ $x -gt 90 ]
then
echo good,$x
elif [ $x -gt 75 ]
then
echo ok,$x
else
echo bad,$x
fi

y=60

echo "please enter word"
read key
case $key in
[a-z]) echo "lower case letter";;
[A-Z]) echo "upper case lette";;
[0-9]) echo "Digit";;
*) echo "Punctuation ,whitespace ,or other";;
esac