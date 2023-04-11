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

OBJECTS = big_file_C52_c.obj 

OLDOBJECTS =  ar1691.obj ar1691d.obj ty1685.obj ty1685d.obj ty1686.obj ty1686d.obj ty1709.obj \
	ty1709d.obj it1689.obj it1689d.obj mm1687.obj mm1687d.obj it1688.obj it1688d.obj \
	na1707.obj na1707d.obj re1703.obj re1703d.obj ar1690.obj ar1690d.obj mm1708.obj \
	mm1708d.obj mm1710.obj mm1710d.obj li1699.obj li1699d.obj in1692.obj in1692d.obj \
	to1683.obj to1683d.obj in1704.obj in1704d.obj re1705.obj re1705d.obj mm1711.obj \
	mm1711d.obj cu1701.obj cu1701d.obj tr1700.obj tr1700d.obj ta1693.obj ta1693d.obj \
	fi1697.obj fi1697d.obj ty1706.obj ty1706d.obj mm1712.obj mm1712d.obj mm1713.obj \
	mm1713d.obj ac1702.obj ac1702d.obj co1696.obj co1696d.obj ba1694.obj ba1694d.obj \
	rt1684.obj rt1684d.obj bo1698.obj bo1698d.obj co1695.obj co1695d.obj mm1714.obj \
	mm1714d.obj mm1715.obj mm1715d.obj 

all::  Cobj52.lib

Cobj52.lib: $(OBJECTS) Makefile
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

