#!/usr/bin/ksh
set -x
r.compile  -O 3  -src read1.c -o read1_AIX -includes ./  -librmn     -libpath ./  -libappl burp_c
