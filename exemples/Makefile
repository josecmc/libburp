SHELL    = /bin/sh
# COMPILER = r.compile -debug -optc=-g -src
#COMPILER = r.compile -debug -O 0  -src
COMPILER = r.compile  -O 3  -src
BUILDER  = r.build -O 3 -obj
OPTIMIZE = -O 3
DIRLIB=/software/cmc/burplib_c-1.0
DIRLIB=$(HOME)/`uname`/burplib_c-dev
# DIRLIB=$(HOME)/`uname`/burplib_c-1.2
DSSM=/home/cmss/afsm/adm/ssm_access_points/cmda
PKGN=burplib-c
VERN=1.3


ifeq ($(ARCH),AIX)
   OS=aix51-ppc-64
   CCP=xlC
   LIBRMNSHARED=rmnshared
   LD_FLAGS=
endif

ifeq ($(ARCH),Linux_pgi611)
   OS=linux26-i386
   CCP=g++
   LIBRMNSHARED=rmn_shared
   DEFINES= -defines =-DLinux
   LD_FLAGS= -Wl,--allow-shlib-undefined  -Wl,-rpath,$(ARMNLIB)/lib/$(ARCH)
endif
ifeq ($(ARCH),IRIX64)
   OS=irix65-mips-n32
   CCP=CC
   LIBRMNSHARED=rmnshared
   LD_FLAGS= -Wl,-rpath,$(ARMNLIB)/lib/$(ARCH)
endif

UDS=_
  DIRLIB=$(DSSM)/$(PKGN)$(UDS)$(VERN)$(UDS)$(OS)


all:read1 readburp write1 write2 alain obs

read1:read1.c
	$(COMPILER) read1.c -o $@_$(ARCH) -includes $(DIRLIB)/include  -librmn  $(DEFINES)   -libpath $(DIRLIB)/lib  -libappl burp_c 

readcc: readcc.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

readburp:readburp.c
	$(COMPILER) $@.c  -o $@_$(ARCH) -includes $(DIRLIB)/include  -librmn  $(DEFINES)    -libpath $(DIRLIB)/lib  -libappl burp_c 

readfloat:readfloat.c
	$(COMPILER) $@.c  -o $@_$(ARCH) -includes $(DIRLIB)/include  -librmn  $(DEFINES)    -libpath $(DIRLIB)/lib  -libappl burp_c 



write1: write1.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c  -l$(LIBRMNSHARED) 

write2: write2.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

real: real.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

write2f: write2f.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

alain: alain.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

maxlen: maxlen.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  
obs: obs.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  
val: val.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  
elements: elements.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  
test: test.cpp
	$(CCP) $@.cpp -I$(DIRLIB)/include -I$(ARMNLIB)/include -L$(ARMNLIB)/lib/$(ARCH) -L$(DIRLIB)/lib  -O3  $(LD_FLAGS)  -o $@_$(ARCH) -lburp_c -l$(LIBRMNSHARED)  

clean:
	-rm -rf read1_* obs_* elements_* readburp_* \
        write1_* write2_* write2f_* write2d_* readfloat_* test_* core ii_files *.o\
        alain_* obs_* readfloat_*

