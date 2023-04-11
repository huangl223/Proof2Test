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
echo "Compiling C code in C50"
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

OBJECTS = big_file_C50_c.obj 

OLDOBJECTS =  sp1632.o sp1632d.o ar1642.o ar1642d.o ty1636.o ty1636d.o ty1637.o \
	ty1637d.o it1640.o it1640d.o mm1638.o mm1638d.o it1639.o it1639d.o \
	sp1633.o sp1633d.o ar1641.o ar1641d.o si1620.o si1620d.o ar1621.o \
	ar1621d.o re1618.o re1618d.o in1643.o in1643d.o to1634.o to1634d.o \
	dy1627.o dy1627d.o li1629.o li1629d.o ge1631.o ge1631d.o se1622.o \
	se1622d.o ar1630.o ar1630d.o dy1624.o dy1624d.o bo1619.o bo1619d.o \
	ta1644.o ta1644d.o fi1648.o fi1648d.o un1628.o un1628d.o ch1626.o \
	ch1626d.o co1647.o co1647d.o bi1623.o bi1623d.o dy1625.o dy1625d.o \
	ba1645.o ba1645d.o rt1635.o rt1635d.o bo1649.o bo1649d.o co1646.o \
	co1646d.o mm1617.o mm1617d.o 

all: Cobj50.o

Cobj50.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj50.o $(OBJECTS)
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

