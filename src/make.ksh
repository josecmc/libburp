#!/usr/bin/ksh
set -e

# make sure we are compiling locally
SCRIPT=`readlink -f $0`
SCRIPT_PATH=`dirname $SCRIPT`
cd $SCRIPT_PATH

rm -rf core *.o *.a *.so libburp_c.a 

# load appropriate compilers for each architecture
if [[ -z ${COMP_ARCH} ]]; then
    if [[ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]]; then
        . ssmuse-sh -d hpcs/201402/01/base -d hpcs/ext/xlf_13.1.0.10
    elif [[ "${ORDENV_PLAT}" = "ubuntu-10.04-amd64-64" || "${ORDENV_PLAT}" = "ubuntu-12.04-amd64-64" ]]; then
        . ssmuse-sh -d hpcs/201402/01/base -d hpcs/201402/01/intel13sp1u2
    else
       echo "Unsupported architecture: ${ORDENV_PLAT}"
       exit 1
    fi
fi
# for rmnlib.h
. ssmuse-sh -d rpn/libs/15.2

set -ex

if [ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]; then
    archive_parameter="-X64"
fi

s.compile -src burp_api.c -debug -O 3

ar $archive_parameter scru libburp_c.a *.o
ranlib libburp_c.a

cp -rf libburp_c.a ../lib
cp -rf *.h      ../include

