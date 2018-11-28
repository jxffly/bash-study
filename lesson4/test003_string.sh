#!/usr/bin/env bash
path=$PWD

for file in {$path,$path/log}/*txt
#             ^    Find all executable files ending in "calc"
#+                 in /bin and /usr/bin directories.
do
    echo $file
        if [ -x "$file" ]
        then
          echo $file
        fi
done

# /bin/ipcalc
# /usr/bin/kcalc
# /usr/bin/oidcalc
# /usr/bin/oocalc


# Thank you, Rory Winston, for pointing this out.