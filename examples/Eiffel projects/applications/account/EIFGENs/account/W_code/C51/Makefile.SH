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
echo "Compiling C code in C51"
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

OBJECTS = big_file_C51_c.obj 

OLDOBJECTS =  sp1681.o sp1681d.o ty1660.o ty1660d.o na1658.o na1658d.o sp1682.o \
	sp1682d.o re1654.o re1654d.o mm1659.o mm1659d.o si1669.o si1669d.o \
	mm1661.o mm1661d.o li1650.o li1650d.o ar1670.o ar1670d.o re1667.o \
	re1667d.o dy1676.o dy1676d.o li1678.o li1678d.o ge1680.o ge1680d.o \
	in1655.o in1655d.o re1656.o re1656d.o mm1662.o mm1662d.o cu1652.o \
	cu1652d.o tr1651.o tr1651d.o se1671.o se1671d.o ar1679.o ar1679d.o \
	dy1673.o dy1673d.o bo1668.o bo1668d.o un1677.o un1677d.o ch1675.o \
	ch1675d.o ty1657.o ty1657d.o mm1663.o mm1663d.o mm1664.o mm1664d.o \
	ac1653.o ac1653d.o bi1672.o bi1672d.o dy1674.o dy1674d.o mm1665.o \
	mm1665d.o mm1666.o mm1666d.o 

all: Cobj51.o

Cobj51.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj51.o $(OBJECTS)
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

