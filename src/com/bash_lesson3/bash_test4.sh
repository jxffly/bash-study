#!/usr/bin/env bash
cd log
ls -l > files
echo $files
if [ -e test_1.txt ];then
rm test_1.txt
fi
echo "Log files cleaned up."