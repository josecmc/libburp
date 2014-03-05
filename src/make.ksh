#!/usr/bin/ksh
set -ex

# make sure we are compiling locally
SCRIPT=`readlink -f $0`
SCRIPT_PATH=`dirname $SCRIPT`
cd $SCRIPT_PATH

rm -rf  core *.o *.a *.so 

. s.ssmuse.dot devtools legacy rmnlib-dev

# load appropriate compilers for each architecture
if [ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]; then
    . s.ssmuse.dot Xlf13
    archive_parameter="-X64"
elif [ "${ORDENV_PLAT}" = "ubuntu-10.04-amd64-64" ]; then
    . s.ssmuse.dot pgi9xx
else
   echo "Unsupported architecture: ${ORDENV_PLAT}"
   exit 1
fi

s.compile  -src burp_api.c  -O 3

ls *.o

ar $archive_parameter scru libburp_c.a *.o
ranlib libburp_c.a

cp -rf libburp_c.a ../lib
cp -rf *.h      ../include

