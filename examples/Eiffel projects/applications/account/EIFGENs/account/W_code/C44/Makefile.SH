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
echo "Compiling C code in C44"
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

OBJECTS = big_file_C44_c.obj 

OLDOBJECTS =  sp1435.o sp1435d.o ar1445.o ar1445d.o ty1439.o ty1439d.o ty1440.o \
	ty1440d.o it1443.o it1443d.o mm1441.o mm1441d.o it1442.o it1442d.o \
	sp1436.o sp1436d.o ar1444.o ar1444d.o si1423.o si1423d.o ar1424.o \
	ar1424d.o re1421.o re1421d.o in1446.o in1446d.o to1437.o to1437d.o \
	dy1430.o dy1430d.o li1432.o li1432d.o ge1434.o ge1434d.o se1425.o \
	se1425d.o ar1433.o ar1433d.o dy1427.o dy1427d.o bo1422.o bo1422d.o \
	ta1447.o ta1447d.o fi1451.o fi1451d.o un1431.o un1431d.o ch1429.o \
	ch1429d.o co1450.o co1450d.o bi1426.o bi1426d.o dy1428.o dy1428d.o \
	ba1448.o ba1448d.o rt1438.o rt1438d.o co1449.o co1449d.o mm1419.o \
	mm1419d.o mm1420.o mm1420d.o 

all: Cobj44.o

Cobj44.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj44.o $(OBJECTS)
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

