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
echo "Compiling C code in C37"
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

OBJECTS = big_file_C37_c.obj 

OLDOBJECTS =  sp1189.o sp1189d.o ar1199.o ar1199d.o ty1193.o ty1193d.o ty1194.o \
	ty1194d.o ty1217.o ty1217d.o it1197.o it1197d.o mm1195.o mm1195d.o \
	it1196.o it1196d.o na1215.o na1215d.o sp1190.o sp1190d.o re1211.o \
	re1211d.o ar1198.o ar1198d.o mm1216.o mm1216d.o mm1218.o mm1218d.o \
	li1207.o li1207d.o in1200.o in1200d.o to1191.o to1191d.o ge1188.o \
	ge1188d.o in1212.o in1212d.o re1213.o re1213d.o mm1219.o mm1219d.o \
	cu1209.o cu1209d.o tr1208.o tr1208d.o ta1201.o ta1201d.o fi1205.o \
	fi1205d.o ty1214.o ty1214d.o mm1220.o mm1220d.o ac1210.o ac1210d.o \
	co1204.o co1204d.o ba1202.o ba1202d.o rt1192.o rt1192d.o bo1206.o \
	bo1206d.o co1203.o co1203d.o 

all: Cobj37.o

Cobj37.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj37.o $(OBJECTS)
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

