echo %CD% > "D:\Eiffel Projects\projects\proof2test\EIFGENs\proof2test-v1\W_code\dir.txt"
cd..\..\..
echo %CD% >> "D:\Eiffel Projects\projects\proof2test\EIFGENs\proof2test-v1\W_code\dir.txt"
@echo off
set "$=%temp%\Spring"
>%$% Echo WScript.Echo((new Date()).getTime())
for /f %%a in ('cscript -nologo -e:jscript %$%') do set timestamp1=%%a
del /f /q %$%
proof2test-v1.exe > "D:\Eiffel Projects\projects\proof2test\result.txt"
@echo off
set "$=%temp%\Spring"
>%$% Echo WScript.Echo((new Date()).getTime())
for /f %%a in ('cscript -nologo -e:jscript %$%') do set timestamp2=%%a
del /f /q %$%
echo %timestamp1% >>"D:\Eiffel Projects\projects\proof2test\result.txt"
echo %timestamp2% >>"D:\Eiffel Projects\projects\proof2test\result.txt"
type nul> tests.e
ec.exe -pretty test_set.e > tests.e
del test_set.e

