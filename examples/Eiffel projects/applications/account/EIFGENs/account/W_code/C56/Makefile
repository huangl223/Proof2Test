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

OBJECTS = big_file_C56_c.obj 

OLDOBJECTS =  eq1827.obj eq1827d.obj dy1820.obj dy1820d.obj dy1839.obj dy1839d.obj ha1817.obj \
	ha1817d.obj ha1837.obj ha1837d.obj st1835.obj st1835d.obj st1836.obj st1836d.obj \
	ta1821.obj ta1821d.obj ta1840.obj ta1840d.obj co1828.obj co1828d.obj li1829.obj \
	li1829d.obj ha1818.obj ha1818d.obj ha1838.obj ha1838d.obj ta1822.obj ta1822d.obj \
	ta1841.obj ta1841d.obj co1833.obj co1833d.obj li1830.obj li1830d.obj li1832.obj \
	li1832d.obj li1831.obj li1831d.obj rt1815.obj rt1815d.obj rt1816.obj rt1816d.obj \
	rt1823.obj rt1823d.obj rt1824.obj rt1824d.obj rt1825.obj rt1825d.obj rt1826.obj \
	rt1826d.obj rt1843.obj rt1843d.obj rt1844.obj rt1844d.obj rt1845.obj rt1845d.obj \
	rt1846.obj rt1846d.obj rt1847.obj rt1847d.obj ta1819.obj ta1819d.obj ta1842.obj \
	ta1842d.obj in1834.obj in1834d.obj 

all::  Cobj56.lib

Cobj56.lib: $(OBJECTS) Makefile
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

