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
echo "Compiling C code in C49"
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

OBJECTS = big_file_C49_c.obj 

OLDOBJECTS =  ar1593.o ar1593d.o ty1587.o ty1587d.o ty1588.o ty1588d.o ty1611.o \
	ty1611d.o it1591.o it1591d.o mm1589.o mm1589d.o it1590.o it1590d.o \
	na1609.o na1609d.o sp1584.o sp1584d.o re1605.o re1605d.o ar1592.o \
	ar1592d.o mm1610.o mm1610d.o mm1612.o mm1612d.o li1601.o li1601d.o \
	in1594.o in1594d.o to1585.o to1585d.o in1606.o in1606d.o re1607.o \
	re1607d.o mm1613.o mm1613d.o cu1603.o cu1603d.o tr1602.o tr1602d.o \
	ta1595.o ta1595d.o fi1599.o fi1599d.o ty1608.o ty1608d.o mm1614.o \
	mm1614d.o mm1615.o mm1615d.o ac1604.o ac1604d.o co1598.o co1598d.o \
	ba1596.o ba1596d.o rt1586.o rt1586d.o bo1600.o bo1600d.o co1597.o \
	co1597d.o mm1616.o mm1616d.o 

all: Cobj49.o

Cobj49.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj49.o $(OBJECTS)
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

