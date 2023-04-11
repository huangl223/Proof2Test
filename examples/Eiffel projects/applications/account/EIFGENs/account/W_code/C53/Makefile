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

OBJECTS = big_file_C53_c.obj 

OLDOBJECTS =  sp1730.obj sp1730d.obj ar1741.obj ar1741d.obj ty1735.obj ty1735d.obj ty1736.obj \
	ty1736d.obj it1739.obj it1739d.obj mm1737.obj mm1737d.obj it1738.obj it1738d.obj \
	sp1731.obj sp1731d.obj ar1740.obj ar1740d.obj si1718.obj si1718d.obj ar1719.obj \
	ar1719d.obj re1716.obj re1716d.obj in1742.obj in1742d.obj to1732.obj to1732d.obj \
	ce1733.obj ce1733d.obj dy1725.obj dy1725d.obj li1727.obj li1727d.obj ge1729.obj \
	ge1729d.obj se1720.obj se1720d.obj ar1728.obj ar1728d.obj dy1722.obj dy1722d.obj \
	bo1717.obj bo1717d.obj ta1743.obj ta1743d.obj fi1747.obj fi1747d.obj un1726.obj \
	un1726d.obj ch1724.obj ch1724d.obj co1746.obj co1746d.obj bi1721.obj bi1721d.obj \
	dy1723.obj dy1723d.obj ba1744.obj ba1744d.obj rt1734.obj rt1734d.obj bo1748.obj \
	bo1748d.obj co1745.obj co1745d.obj 

all::  Cobj53.lib

Cobj53.lib: $(OBJECTS) Makefile
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

