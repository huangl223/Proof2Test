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
echo "Compiling C code in C42"
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

OBJECTS = big_file_C42_c.obj 

OLDOBJECTS =  ty1365.o ty1365d.o na1363.o na1363d.o re1359.o re1359d.o mm1364.o \
	mm1364d.o si1374.o si1374d.o mm1366.o mm1366d.o li1355.o li1355d.o \
	ar1375.o ar1375d.o re1372.o re1372d.o dy1381.o dy1381d.o li1383.o \
	li1383d.o ge1385.o ge1385d.o in1360.o in1360d.o re1361.o re1361d.o \
	mm1367.o mm1367d.o cu1357.o cu1357d.o tr1356.o tr1356d.o se1376.o \
	se1376d.o ar1384.o ar1384d.o dy1378.o dy1378d.o bo1373.o bo1373d.o \
	fi1353.o fi1353d.o un1382.o un1382d.o ch1380.o ch1380d.o ty1362.o \
	ty1362d.o mm1368.o mm1368d.o mm1369.o mm1369d.o ac1358.o ac1358d.o \
	bi1377.o bi1377d.o dy1379.o dy1379d.o bo1354.o bo1354d.o mm1370.o \
	mm1370d.o mm1371.o mm1371d.o 

all: Cobj42.o

Cobj42.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj42.o $(OBJECTS)
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

