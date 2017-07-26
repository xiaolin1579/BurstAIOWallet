@echo off
echo Checking Path only
for %%f in (java.exe) do if exist %%~$path:f (
echo Java found at: %%~$path:f
start "BURST" "%%~$path:f" -Xmx8G -Xms2G -cp burst.jar;lib\*;conf nxt.Nxt
goto done
) else (
echo Java Not found in Path, Searching C drive
for /F "tokens=*" %%f in ('where /F /R C:\ java.exe') do (
echo Java found at: %%f
start "BURST" %%f -Xmx6G -Xms2G -cp burst.jar;lib\*;conf nxt.Nxt
goto startup
)
)
echo No Java Found on this Computer!
@pause
goto done
:startup
start http://localhost:8125/index.html
REM Check for Burst jar
:loop
if exist burst.jar(
start /wait %launch%
) else (
  for /F "tokens=*" %%f in ('%systemroot%\system32\where /F /R C:\ burst.jar') do (
   echo Burst.Jar found at: %%f
   cd %%~pf
   start /wait %launch%
   goto loop
   )
)
goto loop
:done
echo burst.jar Successfully Started!
