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
echo "Compiling C code in C46"
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

OBJECTS = big_file_C46_c.obj 

OLDOBJECTS =  ar1494.o ar1494d.o ty1488.o ty1488d.o ty1489.o ty1489d.o ty1512.o \
	ty1512d.o it1492.o it1492d.o mm1490.o mm1490d.o it1491.o it1491d.o \
	na1510.o na1510d.o sp1485.o sp1485d.o re1506.o re1506d.o ar1493.o \
	ar1493d.o mm1511.o mm1511d.o mm1513.o mm1513d.o li1502.o li1502d.o \
	in1495.o in1495d.o to1486.o to1486d.o in1507.o in1507d.o re1508.o \
	re1508d.o mm1514.o mm1514d.o cu1504.o cu1504d.o tr1503.o tr1503d.o \
	ta1496.o ta1496d.o fi1500.o fi1500d.o ty1509.o ty1509d.o mm1515.o \
	mm1515d.o mm1516.o mm1516d.o ac1505.o ac1505d.o co1499.o co1499d.o \
	ba1497.o ba1497d.o rt1487.o rt1487d.o bo1501.o bo1501d.o co1498.o \
	co1498d.o mm1517.o mm1517d.o 

all: Cobj46.o

Cobj46.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj46.o $(OBJECTS)
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

