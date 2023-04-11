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
echo "Compiling C code in C47"
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

OBJECTS = big_file_C47_c.obj 

OLDOBJECTS =  sp1533.o sp1533d.o ar1544.o ar1544d.o ty1538.o ty1538d.o ty1539.o \
	ty1539d.o it1542.o it1542d.o mm1540.o mm1540d.o it1541.o it1541d.o \
	sp1534.o sp1534d.o ar1543.o ar1543d.o si1521.o si1521d.o ar1522.o \
	ar1522d.o re1519.o re1519d.o in1545.o in1545d.o to1535.o to1535d.o \
	dy1528.o dy1528d.o li1530.o li1530d.o ge1532.o ge1532d.o se1523.o \
	se1523d.o ar1531.o ar1531d.o dy1525.o dy1525d.o bo1520.o bo1520d.o \
	ta1546.o ta1546d.o fi1550.o fi1550d.o un1529.o un1529d.o ch1527.o \
	ch1527d.o co1549.o co1549d.o bi1524.o bi1524d.o dy1526.o dy1526d.o \
	ba1547.o ba1547d.o rt1536.o rt1536d.o rt1537.o rt1537d.o co1548.o \
	co1548d.o mm1518.o mm1518d.o 

all: Cobj47.o

Cobj47.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj47.o $(OBJECTS)
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

