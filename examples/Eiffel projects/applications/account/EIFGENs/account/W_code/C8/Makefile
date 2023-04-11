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

OBJECTS = big_file_C8_c.obj 

OLDOBJECTS =  po262.obj po262d.obj po263.obj po263d.obj re250.obj re250d.obj re251.obj re251d.obj \
	re247.obj re247d.obj re248.obj re248d.obj na244.obj na244d.obj na245.obj na245d.obj \
	na241.obj na241d.obj na242.obj na242d.obj na238.obj na238d.obj na239.obj na239d.obj \
	na235.obj na235d.obj na236.obj na236d.obj in232.obj in232d.obj in233.obj in233d.obj \
	ch256.obj ch256d.obj ch257.obj ch257d.obj ch253.obj ch253d.obj ch254.obj ch254d.obj \
	bo259.obj bo259d.obj bo260.obj bo260d.obj po261.obj po261d.obj bo258.obj bo258d.obj \
	ch255.obj ch255d.obj ch252.obj ch252d.obj re249.obj re249d.obj re246.obj re246d.obj \
	na243.obj na243d.obj na240.obj na240d.obj na237.obj na237d.obj na234.obj na234d.obj \
	in231.obj in231d.obj 

all::  Cobj8.lib

Cobj8.lib: $(OBJECTS) Makefile
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

