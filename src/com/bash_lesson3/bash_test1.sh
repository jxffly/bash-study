#!/bin/bash
cd ./
file_name=shell_tut
if [ -e ${file_name} ] ;then
    echo the file ${file_name} already exist
else
    mkdir shell_tut
fi

cd shell_tut

for ((i=0; i<10; i++)); do
	touch test_$i.txt
done