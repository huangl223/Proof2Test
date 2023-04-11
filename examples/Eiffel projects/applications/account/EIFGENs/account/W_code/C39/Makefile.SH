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
echo "Compiling C code in C39"
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

OBJECTS = big_file_C39_c.obj 

OLDOBJECTS =  ty1266.o ty1266d.o na1264.o na1264d.o re1260.o re1260d.o mm1265.o \
	mm1265d.o si1275.o si1275d.o mm1267.o mm1267d.o li1256.o li1256d.o \
	ar1276.o ar1276d.o re1273.o re1273d.o dy1282.o dy1282d.o li1284.o \
	li1284d.o ge1286.o ge1286d.o in1261.o in1261d.o re1262.o re1262d.o \
	mm1268.o mm1268d.o cu1258.o cu1258d.o tr1257.o tr1257d.o se1277.o \
	se1277d.o ar1285.o ar1285d.o dy1279.o dy1279d.o bo1274.o bo1274d.o \
	fi1254.o fi1254d.o un1283.o un1283d.o ch1281.o ch1281d.o ty1263.o \
	ty1263d.o mm1269.o mm1269d.o mm1270.o mm1270d.o ac1259.o ac1259d.o \
	bi1278.o bi1278d.o dy1280.o dy1280d.o bo1255.o bo1255d.o mm1271.o \
	mm1271d.o mm1272.o mm1272d.o 

all: Cobj39.o

Cobj39.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj39.o $(OBJECTS)
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

