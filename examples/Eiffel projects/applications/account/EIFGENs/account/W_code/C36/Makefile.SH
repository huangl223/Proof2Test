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
echo "Compiling C code in C36"
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

OBJECTS = big_file_C36_c.obj 

OLDOBJECTS =  ty1168.o ty1168d.o na1166.o na1166d.o re1162.o re1162d.o mm1167.o \
	mm1167d.o si1177.o si1177d.o mm1169.o mm1169d.o li1158.o li1158d.o \
	ar1178.o ar1178d.o re1175.o re1175d.o dy1184.o dy1184d.o li1186.o \
	li1186d.o in1163.o in1163d.o re1164.o re1164d.o mm1170.o mm1170d.o \
	cu1160.o cu1160d.o tr1159.o tr1159d.o se1179.o se1179d.o ar1187.o \
	ar1187d.o dy1181.o dy1181d.o bo1176.o bo1176d.o fi1156.o fi1156d.o \
	un1185.o un1185d.o ch1183.o ch1183d.o ty1165.o ty1165d.o mm1171.o \
	mm1171d.o mm1172.o mm1172d.o ac1161.o ac1161d.o co1155.o co1155d.o \
	bi1180.o bi1180d.o dy1182.o dy1182d.o bo1157.o bo1157d.o mm1173.o \
	mm1173d.o mm1174.o mm1174d.o 

all: Cobj36.o

Cobj36.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj36.o $(OBJECTS)
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

