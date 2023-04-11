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
echo "Compiling C code in C40"
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

OBJECTS = big_file_C40_c.obj 

OLDOBJECTS =  sp1287.o sp1287d.o ar1297.o ar1297d.o ty1291.o ty1291d.o ty1292.o \
	ty1292d.o ty1315.o ty1315d.o it1295.o it1295d.o mm1293.o mm1293d.o \
	it1294.o it1294d.o na1313.o na1313d.o sp1288.o sp1288d.o re1309.o \
	re1309d.o ar1296.o ar1296d.o mm1314.o mm1314d.o mm1316.o mm1316d.o \
	li1305.o li1305d.o in1298.o in1298d.o to1289.o to1289d.o in1310.o \
	in1310d.o re1311.o re1311d.o mm1317.o mm1317d.o cu1307.o cu1307d.o \
	tr1306.o tr1306d.o ta1299.o ta1299d.o fi1303.o fi1303d.o ty1312.o \
	ty1312d.o mm1318.o mm1318d.o mm1319.o mm1319d.o ac1308.o ac1308d.o \
	co1302.o co1302d.o ba1300.o ba1300d.o rt1290.o rt1290d.o bo1304.o \
	bo1304d.o co1301.o co1301d.o 

all: Cobj40.o

Cobj40.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj40.o $(OBJECTS)
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

