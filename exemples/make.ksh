#!/usr/bin/ksh
set -ex

rm -rf *.mod core *.o arjen.db toto titi *.a \
       read1_* obs_* elements_* readburp_* \
       write1_* write2_* write2f_* write2d_* readfloat_* test_* ii_files \
       alain_* obs_* readfloat_*

. s.ssmuse.dot devtools legacy rmnlib-dev

# use compilers that are compatible with latest rmnlib: rmnlib_013
if [ "${ORDENV_PLAT}" = "aix-7.1-ppc7-64" ]; then
    . s.ssmuse.dot Xlf13
    platform_parameters="-libsys C"
elif [ "${ORDENV_PLAT}" = "ubuntu-10.04-amd64-64" ]; then
    . s.ssmuse.dot pgi9xx
    platform_parameters="-defines=-DLinux -libsys stdc++"
else
   echo "Unsupported architecture: ${ORDENV_PLAT}"
   exit 1
fi

# alain.cpp: on AIX produces the obscure message: 1586-494 (U) INTERNAL COMPILER ERROR: Wcode stack is not empty at beginning of basic block.
# test.cpp : same message as above on AIX
set -A files read1.c readcc.cpp readburp.c readfloat.c write1.cpp write2.cpp write2f.cpp maxlen.cpp obs.cpp val.cpp elements.cpp
for file in ${files[@]}; do
    echo $file
    binary=`echo $file | cut -f1 -d"."`
    s.compile -o $binary -src $file -includes ../include -libpath ../lib -libappl burp_c -librmn rmn_013 $platform_parameters -O 3
done

