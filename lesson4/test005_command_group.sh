#!/usr/bin/env bash

(a=hello; echo ${a})

a=123
( a=321; )

echo "a = $a"   # a = 123
# "a" within parentheses acts like a local variable.

echo \"{These,words,are,quoted}\"   # " prefix and suffix
# "These" "words" "are" "quoted"


cat {data.log,my.text} > combined_file.log
# Concatenates the files file1, file2, and file3 into combined_file.

cp test001_case.{sh,backup}
# Copies "file22.txt" to "file22.backup"

