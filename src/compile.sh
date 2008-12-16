#!/usr/bin/ksh
set -x
mkdir -p $HOME/`uname`/burplib_c-dev/include
mkdir -p $HOME/`uname`/burplib_c-dev/lib
rm -rf ssmtempo
mkdir -p ssmtempo/lib
mkdir -p ssmtempo/include


INC_DIR=$HOME/`uname`/burplib_c-dev/include
LIB_DIR=$HOME/`uname`/burplib_c-dev/lib

rm -rf  core *.o *.a *.so 

#r.compile  -src bufr_blk.c -optc=-O3 
#r.compile  -src burp_api.c -optc=-O3 
#r.compile  -src bufr_blk.c -debug -O 0
#r.compile  -src burp_api.c -debug -O 0
r.compile  -src burp_api.c  -O 3

ls *.o

if  [ "`uname`" = "AIX" ]
then
   ar -X64 scru libburp_c.a *.o 
   ranlib libburp_c.a
elif [ "`uname`" = "IRIX64" ]
then
   ar scru libburp_c.a *.o 
else
   ar scru libburp_c.a *.o 
   ranlib  libburp_c.a
fi
cp -rf libburp_c.a  $LIB_DIR
cp -rf *.h          $INC_DIR
cp -rf libburp_c.a ssmtempo/lib
cp -rf *.h         ssmtempo/include

