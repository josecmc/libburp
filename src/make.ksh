#!/usr/bin/ksh
set -ex

SCRIPT=`readlink -f $0`
SCRIPT_PATH=`dirname $SCRIPT`
cd $SCRIPT_PATH

rm -rf  core *.o *.a *.so 

. s.ssmuse.dot devtools legacy rmnlib-dev

# load appropriate compilers for each architecture
if [ "`uname -s`" = "AIX" ]; then
    . s.ssmuse.dot Xlf13
    archive_parameter="-X64"
elif [ "`uname`" = "Linux" ]; then
    . s.ssmuse.dot pgi9xx
else
   echo "Unsupported architecture: `uname`"
   exit 1
fi

s.compile  -src burp_api.c  -O 3

ls *.o

ar $archive_parameter scru libburp_c.a *.o
ranlib libburp_c.a

cp -rf libburp_c.a ../lib
cp -rf *.h      ../include

