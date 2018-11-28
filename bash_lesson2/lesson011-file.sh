#!/usr/bin/env bash

file=my.log
if [ -e $file ] ;then
echo the file $file exsit
exec cat $file>>text
echo text
fi