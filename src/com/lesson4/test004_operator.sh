#!/usr/bin/env bash
: > data.log   # File "data.xxx" now empty.

# Same effect as   cat /dev/null >data.xxx
# However, this does not fork a new process, since ":" is a builtin.
cd  ../example/
javac TestClass.java
pwd

java  com.example.TestClass
java -version
echo $string