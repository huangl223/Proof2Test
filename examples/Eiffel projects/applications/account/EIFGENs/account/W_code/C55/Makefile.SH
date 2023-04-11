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
echo "Compiling C code in C55"
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

OBJECTS = big_file_C55_c.obj 

OLDOBJECTS =  to1782.o to1782d.o ce1791.o ce1791d.o ce1798.o ce1798d.o ce1799.o \
	ce1799d.o ce1800.o ce1800d.o li1805.o li1805d.o ar1802.o ar1802d.o \
	se1809.o se1809d.o li1806.o li1806d.o li1808.o li1808d.o li1807.o \
	li1807d.o rt1811.o rt1811d.o rt1812.o rt1812d.o rt1813.o rt1813d.o \
	rt1814.o rt1814d.o rt1783.o rt1783d.o rt1784.o rt1784d.o rt1785.o \
	rt1785d.o rt1786.o rt1786d.o rt1787.o rt1787d.o rt1788.o rt1788d.o \
	rt1789.o rt1789d.o rt1790.o rt1790d.o rt1792.o rt1792d.o rt1793.o \
	rt1793d.o rt1794.o rt1794d.o rt1795.o rt1795d.o rt1796.o rt1796d.o \
	rt1797.o rt1797d.o rt1801.o rt1801d.o rt1810.o rt1810d.o ar1803.o \
	ar1803d.o qu1804.o qu1804d.o 

all: Cobj55.o

Cobj55.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj55.o $(OBJECTS)
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

