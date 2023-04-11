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
echo "Compiling C code in C48"
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

OBJECTS = big_file_C48_c.obj 

OLDOBJECTS =  sp1583.o sp1583d.o ty1562.o ty1562d.o na1560.o na1560d.o re1556.o \
	re1556d.o mm1561.o mm1561d.o si1571.o si1571d.o mm1563.o mm1563d.o \
	li1552.o li1552d.o ar1572.o ar1572d.o re1569.o re1569d.o dy1578.o \
	dy1578d.o li1580.o li1580d.o ge1582.o ge1582d.o in1557.o in1557d.o \
	re1558.o re1558d.o mm1564.o mm1564d.o cu1554.o cu1554d.o tr1553.o \
	tr1553d.o se1573.o se1573d.o ar1581.o ar1581d.o dy1575.o dy1575d.o \
	bo1570.o bo1570d.o un1579.o un1579d.o ch1577.o ch1577d.o ty1559.o \
	ty1559d.o mm1565.o mm1565d.o mm1566.o mm1566d.o ac1555.o ac1555d.o \
	bi1574.o bi1574d.o dy1576.o dy1576d.o bo1551.o bo1551d.o mm1567.o \
	mm1567d.o mm1568.o mm1568d.o 

all: Cobj48.o

Cobj48.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj48.o $(OBJECTS)
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

