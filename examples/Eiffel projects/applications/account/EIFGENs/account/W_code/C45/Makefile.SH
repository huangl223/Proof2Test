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
echo "Compiling C code in C45"
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

OBJECTS = big_file_C45_c.obj 

OLDOBJECTS =  sp1484.o sp1484d.o ty1463.o ty1463d.o na1461.o na1461d.o re1457.o \
	re1457d.o mm1462.o mm1462d.o si1472.o si1472d.o mm1464.o mm1464d.o \
	li1453.o li1453d.o ar1473.o ar1473d.o re1470.o re1470d.o dy1479.o \
	dy1479d.o li1481.o li1481d.o ge1483.o ge1483d.o in1458.o in1458d.o \
	re1459.o re1459d.o mm1465.o mm1465d.o cu1455.o cu1455d.o tr1454.o \
	tr1454d.o se1474.o se1474d.o ar1482.o ar1482d.o dy1476.o dy1476d.o \
	bo1471.o bo1471d.o un1480.o un1480d.o ch1478.o ch1478d.o ty1460.o \
	ty1460d.o mm1466.o mm1466d.o mm1467.o mm1467d.o ac1456.o ac1456d.o \
	bi1475.o bi1475d.o dy1477.o dy1477d.o bo1452.o bo1452d.o mm1468.o \
	mm1468d.o mm1469.o mm1469d.o 

all: Cobj45.o

Cobj45.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj45.o $(OBJECTS)
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

