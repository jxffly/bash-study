#!/usr/bin/env bash

sum(){
local i=0
local total=$#
local sum=0
echo total params is ${total}
for var in $@
do
    ((i++))
    echo $var
    echo "${i} --val=$val"
    let sum = $val + $sum
done
    echo the result is ${sum}
return ${sum}
}
sum 1 23 3
