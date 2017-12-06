#!/usr/bin/env bash
cd .
pwd

variable=abc
case "$variable" in
  abc)  echo "\$variable = abc" ;;
  xyz)  echo "\$variable = xyz" ;;
esac
var1=55
(( var0 = var1<98 ? 9 : 21 ))
#                ^ ^

 if [ "$var1" -lt 98 ]
 then
   var0=9
 else
   var0=21
 fi
echo $var0

echo $$