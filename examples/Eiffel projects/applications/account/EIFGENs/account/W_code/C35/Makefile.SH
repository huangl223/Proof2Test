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
echo "Compiling C code in C35"
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

OBJECTS = big_file_C35_c.obj 

OLDOBJECTS =  sp1126.o sp1126d.o ar1150.o ar1150d.o fu1140.o fu1140d.o ty1144.o \
	ty1144d.o ty1145.o ty1145d.o it1148.o it1148d.o mm1146.o mm1146d.o \
	it1147.o it1147d.o sp1127.o sp1127d.o ar1149.o ar1149d.o in1151.o \
	in1151d.o to1128.o to1128d.o dy1132.o dy1132d.o ha1130.o ha1130d.o \
	ha1136.o ha1136d.o li1123.o li1123d.o ge1125.o ge1125d.o ar1124.o \
	ar1124d.o ta1133.o ta1133d.o ta1152.o ta1152d.o ha1131.o ha1131d.o \
	ha1137.o ha1137d.o un1122.o un1122d.o ta1134.o ta1134d.o ta1138.o \
	ta1138d.o ba1153.o ba1153d.o ta1135.o ta1135d.o ta1139.o ta1139d.o \
	in1129.o in1129d.o di1143.o di1143d.o ar1141.o ar1141d.o co1154.o \
	co1154d.o st1142.o st1142d.o 

all: Cobj35.o

Cobj35.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj35.o $(OBJECTS)
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

