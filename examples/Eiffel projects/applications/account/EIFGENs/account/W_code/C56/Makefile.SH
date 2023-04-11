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
echo "Compiling C code in C56"
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

OBJECTS = big_file_C56_c.obj 

OLDOBJECTS =  eq1827.o eq1827d.o dy1820.o dy1820d.o dy1839.o dy1839d.o ha1817.o \
	ha1817d.o ha1837.o ha1837d.o st1835.o st1835d.o st1836.o st1836d.o \
	ta1821.o ta1821d.o ta1840.o ta1840d.o co1828.o co1828d.o li1829.o \
	li1829d.o ha1818.o ha1818d.o ha1838.o ha1838d.o ta1822.o ta1822d.o \
	ta1841.o ta1841d.o co1833.o co1833d.o li1830.o li1830d.o li1832.o \
	li1832d.o li1831.o li1831d.o rt1815.o rt1815d.o rt1816.o rt1816d.o \
	rt1823.o rt1823d.o rt1824.o rt1824d.o rt1825.o rt1825d.o rt1826.o \
	rt1826d.o rt1843.o rt1843d.o rt1844.o rt1844d.o rt1845.o rt1845d.o \
	rt1846.o rt1846d.o rt1847.o rt1847d.o ta1819.o ta1819d.o ta1842.o \
	ta1842d.o in1834.o in1834d.o 

all: Cobj56.o

Cobj56.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj56.o $(OBJECTS)
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

