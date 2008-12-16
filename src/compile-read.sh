#!/usr/bin/ksh
set -x
if  [ "`uname`" = "AIX" ]
then
   DEFINES=
elif [ "`uname`" = "IRIX64" ]
then
   DEFINES=
else
   DEFINES="-defines =-DLinux"
fi
rm -rf *.o
#r.compile -debug -O 0 -src bufr_blk.c  burp_api.c   wkoffit.c
r.compile -debug -O 0 -src   burp_api.c
r.compile -debug -O 0 $DEFINES -src read1.c -includes ./
#r.compile  -O 0 -debug $DEFINES -src read1.c -o read1 -includes ./  -librmn     -libpath ./  -libappl burp_c
r.build  -O 0 -debug  -obj *.o -o read1   -librmn 


