#!/usr/bin/ksh
set -ex

# make sure we are compiling locally
SCRIPT=`readlink -f $0`
SCRIPT_PATH=`dirname $SCRIPT`
cd $SCRIPT_PATH

rm -rf core *.o *.a *.so 

# load appropriate compilers for each architecture
if [[ -z ${COMP_ARCH} ]]; then
    if [[ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]]; then
        . s.ssmuse.dot devtools
        . ssmuse-sh -d rpn/libs/4.0
        . s.ssmuse.dot Xlf13
    elif [[ "${ORDENV_PLAT}" = "ubuntu-10.04-amd64-64" || "${ORDENV_PLAT}" = "ubuntu-12.04-amd64-64" ]]; then
        . s.ssmuse.dot devtools
        . ssmuse-sh -d rpn/libs/4.0
        . ssmuse-sh -d hpcs/201402/00/base -d hpcs/201402/00/intel13sp1
    else
       echo "Unsupported architecture: ${ORDENV_PLAT}"
       exit 1
    fi
fi

if [ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]; then
    archive_parameter="-X64"
fi

s.compile -src burp_api.c  -O 3

ls *.o

ar $archive_parameter scru libburp_c.a *.o
ranlib libburp_c.a

cp -rf libburp_c.a ../lib
cp -rf *.h      ../include

