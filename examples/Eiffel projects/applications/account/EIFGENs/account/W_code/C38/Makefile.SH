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
echo "Compiling C code in C38"
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

OBJECTS = big_file_C38_c.obj 

OLDOBJECTS =  sp1238.o sp1238d.o ar1248.o ar1248d.o ty1242.o ty1242d.o ty1243.o \
	ty1243d.o it1246.o it1246d.o mm1244.o mm1244d.o it1245.o it1245d.o \
	sp1239.o sp1239d.o ar1247.o ar1247d.o si1226.o si1226d.o ar1227.o \
	ar1227d.o re1224.o re1224d.o in1249.o in1249d.o to1240.o to1240d.o \
	dy1233.o dy1233d.o li1235.o li1235d.o ge1237.o ge1237d.o se1228.o \
	se1228d.o ar1236.o ar1236d.o dy1230.o dy1230d.o bo1225.o bo1225d.o \
	ta1250.o ta1250d.o un1234.o un1234d.o ch1232.o ch1232d.o mm1221.o \
	mm1221d.o co1253.o co1253d.o bi1229.o bi1229d.o dy1231.o dy1231d.o \
	ba1251.o ba1251d.o rt1241.o rt1241d.o co1252.o co1252d.o mm1222.o \
	mm1222d.o mm1223.o mm1223d.o 

all: Cobj38.o

Cobj38.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj38.o $(OBJECTS)
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

