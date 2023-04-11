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
echo "Compiling C code in C41"
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

OBJECTS = big_file_C41_c.obj 

OLDOBJECTS =  sp1336.o sp1336d.o ar1347.o ar1347d.o ty1341.o ty1341d.o ty1342.o \
	ty1342d.o it1345.o it1345d.o mm1343.o mm1343d.o it1344.o it1344d.o \
	sp1337.o sp1337d.o ar1346.o ar1346d.o si1324.o si1324d.o ar1325.o \
	ar1325d.o re1322.o re1322d.o in1348.o in1348d.o to1338.o to1338d.o \
	dy1331.o dy1331d.o li1333.o li1333d.o ge1335.o ge1335d.o se1326.o \
	se1326d.o ar1334.o ar1334d.o dy1328.o dy1328d.o bo1323.o bo1323d.o \
	ta1349.o ta1349d.o un1332.o un1332d.o ch1330.o ch1330d.o co1352.o \
	co1352d.o bi1327.o bi1327d.o dy1329.o dy1329d.o ba1350.o ba1350d.o \
	rt1339.o rt1339d.o rt1340.o rt1340d.o co1351.o co1351d.o mm1320.o \
	mm1320d.o mm1321.o mm1321d.o 

all: Cobj41.o

Cobj41.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj41.o $(OBJECTS)
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

