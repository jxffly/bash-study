#!/usr/bin/env bash
STR="HELLO WORLD"
echo $STR
pwd>>my.log

x=1999
let x=$x+1
echo $x
x="olympic"$x
echo $x

y=2001

let z=$x -eq $y
echo $z
