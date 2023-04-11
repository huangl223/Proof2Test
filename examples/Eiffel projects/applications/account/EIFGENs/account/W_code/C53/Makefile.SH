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
echo "Compiling C code in C53"
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

OBJECTS = big_file_C53_c.obj 

OLDOBJECTS =  sp1730.o sp1730d.o ar1741.o ar1741d.o ty1735.o ty1735d.o ty1736.o \
	ty1736d.o it1739.o it1739d.o mm1737.o mm1737d.o it1738.o it1738d.o \
	sp1731.o sp1731d.o ar1740.o ar1740d.o si1718.o si1718d.o ar1719.o \
	ar1719d.o re1716.o re1716d.o in1742.o in1742d.o to1732.o to1732d.o \
	ce1733.o ce1733d.o dy1725.o dy1725d.o li1727.o li1727d.o ge1729.o \
	ge1729d.o se1720.o se1720d.o ar1728.o ar1728d.o dy1722.o dy1722d.o \
	bo1717.o bo1717d.o ta1743.o ta1743d.o fi1747.o fi1747d.o un1726.o \
	un1726d.o ch1724.o ch1724d.o co1746.o co1746d.o bi1721.o bi1721d.o \
	dy1723.o dy1723d.o ba1744.o ba1744d.o rt1734.o rt1734d.o bo1748.o \
	bo1748d.o co1745.o co1745d.o 

all: Cobj53.o

Cobj53.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj53.o $(OBJECTS)
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

