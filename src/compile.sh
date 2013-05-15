#!/usr/bin/ksh
set -x

rm -rf  core *.o *.a *.so 

#r.compile  -src bufr_blk.c -optc=-O3 
#r.compile  -src burp_api.c -optc=-O3 
#r.compile  -src bufr_blk.c -debug -O 0
#r.compile  -src burp_api.c -debug -O 0
r.compile  -src burp_api.c  -O 3

ls *.o

if  [ "`uname`" = "AIX" ]
then
   OS="aix71-ppc7-64"
   ar -X64 scru libburp_c.a *.o 
   ranlib libburp_c.a
elif [ "`uname`" = "Linux" ]
then
   OS="linux26-i386"
   ar scru libburp_c.a *.o 
   ranlib  libburp_c.a
else
   echo "Unsupported architecture: `uname`"
   exit 1
fi

mkdir -p ../lib/$OS
mkdir -p ../include

cp -rf libburp_c.a ../lib
mv libburp_c.a  ../lib/$OS
ln -s ../lib/$OS/libburp_c.a
cp -rf *.h      ../include

