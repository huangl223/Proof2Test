case $CONFIG in
'')
	if test ! -f ../config.sh; then
		(echo "Can't find ../config.sh."; exit 1)
	fi 2>/dev/null
	. ../config.sh
	;;
esac
case "$O" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Compiling C code in C43"
$spitshell >Makefile <<!GROK!THIS!
INCLUDE_PATH =  -I"\$(ISE_LIBRARY)\library\time\spec\include"
SHELL = /bin/sh
CC = $cc
CPP = $cpp
CFLAGS = $wkoptimize $mtccflags $large -DEIF_IEEE_BEHAVIOR -DWORKBENCH -I"$rt_include" -I. \$(INCLUDE_PATH)
CPPFLAGS = $wkoptimize $mtcppflags $large -DEIF_IEEE_BEHAVIOR -DWORKBENCH -I"$rt_include" -I. \$(INCLUDE_PATH)
LDFLAGS = $ldflags
CCLDFLAGS = $ccldflags  $console_flags
LDSHAREDFLAGS =  $mtldsharedflags
EIFLIB = "$rt_lib/$prefix$mt_prefix$wkeiflib$suffix"
EIFTEMPLATES = $rt_templates
LIBS = $mtlibs
MAKE = $make
AR = $ar
LD = $ld
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
CP = $cp
RANLIB = $ranlib
RM = $rm -f
FILE_EXIST = $file_exist
RMDIR = $rmdir
X2C = "$x2c"
SHAREDLINK = $sharedlink
SHAREDLIBS = $sharedlibs
SHARED_SUFFIX = $shared_suffix
COMMAND_MAKEFILE = 
START_TEST = $start_test 
END_TEST = $end_test 
CREATE_TEST = $create_test 
SYSTEM_IN_DYNAMIC_LIB = account$shared_suffix 
!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'

.SUFFIXES:.cpp .o

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $<

OBJECTS = big_file_C43_c.obj 

OLDOBJECTS =  sp1386.o sp1386d.o ar1396.o ar1396d.o ty1390.o ty1390d.o ty1391.o \
	ty1391d.o ty1414.o ty1414d.o it1394.o it1394d.o mm1392.o mm1392d.o \
	it1393.o it1393d.o na1412.o na1412d.o sp1387.o sp1387d.o re1408.o \
	re1408d.o ar1395.o ar1395d.o mm1413.o mm1413d.o mm1415.o mm1415d.o \
	li1404.o li1404d.o in1397.o in1397d.o to1388.o to1388d.o in1409.o \
	in1409d.o re1410.o re1410d.o mm1416.o mm1416d.o cu1406.o cu1406d.o \
	tr1405.o tr1405d.o ta1398.o ta1398d.o fi1402.o fi1402d.o ty1411.o \
	ty1411d.o mm1417.o mm1417d.o mm1418.o mm1418d.o ac1407.o ac1407d.o \
	co1401.o co1401d.o ba1399.o ba1399d.o rt1389.o rt1389d.o bo1403.o \
	bo1403d.o co1400.o co1400d.o 

all: Cobj43.o

Cobj43.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj43.o $(OBJECTS)
	$(RM) $(OBJECTS)
	$(CREATE_TEST)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

