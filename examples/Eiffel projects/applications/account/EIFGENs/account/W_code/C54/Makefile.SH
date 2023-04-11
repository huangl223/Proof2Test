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
echo "Compiling C code in C54"
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

OBJECTS = big_file_C54_c.obj 

OLDOBJECTS =  sp1780.o sp1780d.o ty1759.o ty1759d.o na1757.o na1757d.o sp1781.o \
	sp1781d.o re1753.o re1753d.o mm1758.o mm1758d.o si1768.o si1768d.o \
	mm1760.o mm1760d.o li1749.o li1749d.o ar1769.o ar1769d.o re1766.o \
	re1766d.o dy1775.o dy1775d.o li1777.o li1777d.o ge1779.o ge1779d.o \
	in1754.o in1754d.o re1755.o re1755d.o mm1761.o mm1761d.o cu1751.o \
	cu1751d.o tr1750.o tr1750d.o se1770.o se1770d.o ar1778.o ar1778d.o \
	dy1772.o dy1772d.o bo1767.o bo1767d.o un1776.o un1776d.o ch1774.o \
	ch1774d.o ty1756.o ty1756d.o mm1762.o mm1762d.o mm1763.o mm1763d.o \
	ac1752.o ac1752d.o bi1771.o bi1771d.o dy1773.o dy1773d.o mm1764.o \
	mm1764d.o mm1765.o mm1765d.o 

all: Cobj54.o

Cobj54.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj54.o $(OBJECTS)
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

