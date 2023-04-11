INCLUDE_PATH =  -I"E:\es_ap\trunk\Src\library\time\spec\include"
SHELL = \bin\sh
CC = cl
CPP = cl
CFLAGS = -Od -MT -w -nologo -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_CRT_SECURE_NO_DEPRECATE -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN  -DEIF_THREADS  -DEIF_IEEE_BEHAVIOR -DWORKBENCH -I"D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\spec\win64\include" -I. $(INCLUDE_PATH)
CPPFLAGS = -Od -MT -w -nologo -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_CRT_SECURE_NO_DEPRECATE -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN  -DEIF_THREADS  -DEIF_IEEE_BEHAVIOR -DWORKBENCH -I"D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\spec\win64\include" -I. $(INCLUDE_PATH)
LDFLAGS = -STACK:5000000 -NODEFAULTLIB:libc
CCLDFLAGS = -STACK:5000000 -NODEFAULTLIB:libc  -SUBSYSTEM:CONSOLE
LDSHAREDFLAGS =  -dll -incremental:no -NODEFAULTLIB:libc
EIFLIB = "D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\spec\win64\lib\msc_vc140\mtwkbench.lib"
EIFTEMPLATES = D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\config\win64\templates
LIBS = 
MAKE = nmake -s -nologo
AR = 
LD = 
MKDEP =   --
MV = copy
CP = copy
RANLIB = echo
RM = del
FILE_EXIST = if exist
RMDIR = rd
X2C = "D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\spec\win64\bin\x2c.exe"
SHAREDLINK = link
SHAREDLIBS = USER32.lib WS2_32.lib ADVAPI32.lib GDI32.lib SHELL32.lib MSIMG32.lib \
	COMDLG32.lib UUID.lib OLE32.lib OLEAUT32.lib COMCTL32.lib MPR.LIB SHLWAPI.LIB WINSPOOL.LIB 
SHARED_SUFFIX = .dll
COMMAND_MAKEFILE = 
START_TEST = if not exist finished 
END_TEST =  
CREATE_TEST = echo "finished" >> finished 
SYSTEM_IN_DYNAMIC_LIB = account.dll 

.SUFFIXES:.cpp .obj 

.c.obj:
	$(CC) $(CFLAGS) -c $<

.cpp.obj:
	$(CPP) $(CPPFLAGS) -c $<

OBJECTS = big_file_C47_c.obj 

OLDOBJECTS =  sp1533.obj sp1533d.obj ar1544.obj ar1544d.obj ty1538.obj ty1538d.obj ty1539.obj \
	ty1539d.obj it1542.obj it1542d.obj mm1540.obj mm1540d.obj it1541.obj it1541d.obj \
	sp1534.obj sp1534d.obj ar1543.obj ar1543d.obj si1521.obj si1521d.obj ar1522.obj \
	ar1522d.obj re1519.obj re1519d.obj in1545.obj in1545d.obj to1535.obj to1535d.obj \
	dy1528.obj dy1528d.obj li1530.obj li1530d.obj ge1532.obj ge1532d.obj se1523.obj \
	se1523d.obj ar1531.obj ar1531d.obj dy1525.obj dy1525d.obj bo1520.obj bo1520d.obj \
	ta1546.obj ta1546d.obj fi1550.obj fi1550d.obj un1529.obj un1529d.obj ch1527.obj \
	ch1527d.obj co1549.obj co1549d.obj bi1524.obj bi1524d.obj dy1526.obj dy1526d.obj \
	ba1547.obj ba1547d.obj rt1536.obj rt1536d.obj rt1537.obj rt1537d.obj co1548.obj \
	co1548d.obj mm1518.obj mm1518d.obj 

all::  Cobj47.lib

Cobj47.lib: $(OBJECTS) Makefile
	if exist $@ $(RM) $@
	lib -nologo -OUT:$@ $(OBJECTS)
	$(CREATE_TEST)
	$(RM) $(OBJECTS)


clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

