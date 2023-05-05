@echo off

if [%1]==[] goto Message

setlocal enableDelayedExpansion
set InputArg=%1
set OutputArg=%InputArg:.c=.exe%
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"

cd /d "%COMPDIR%"

g++.exe %InputArg% -o %OutputArg%
goto End

:Message
echo Drag and drop the source code onto this batch file to compile it

:End
pause