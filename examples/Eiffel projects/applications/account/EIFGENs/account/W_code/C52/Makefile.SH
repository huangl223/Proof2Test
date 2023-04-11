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
echo "Compiling C code in C52"
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

OBJECTS = big_file_C52_c.obj 

OLDOBJECTS =  ar1691.o ar1691d.o ty1685.o ty1685d.o ty1686.o ty1686d.o ty1709.o \
	ty1709d.o it1689.o it1689d.o mm1687.o mm1687d.o it1688.o it1688d.o \
	na1707.o na1707d.o re1703.o re1703d.o ar1690.o ar1690d.o mm1708.o \
	mm1708d.o mm1710.o mm1710d.o li1699.o li1699d.o in1692.o in1692d.o \
	to1683.o to1683d.o in1704.o in1704d.o re1705.o re1705d.o mm1711.o \
	mm1711d.o cu1701.o cu1701d.o tr1700.o tr1700d.o ta1693.o ta1693d.o \
	fi1697.o fi1697d.o ty1706.o ty1706d.o mm1712.o mm1712d.o mm1713.o \
	mm1713d.o ac1702.o ac1702d.o co1696.o co1696d.o ba1694.o ba1694d.o \
	rt1684.o rt1684d.o bo1698.o bo1698d.o co1695.o co1695d.o mm1714.o \
	mm1714d.o mm1715.o mm1715d.o 

all: Cobj52.o

Cobj52.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj52.o $(OBJECTS)
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

