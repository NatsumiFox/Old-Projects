@echo off
REM set MAINDIR=%CD%
REM set COMPDIR="C:\MinGW\mingw64\bin"
REM cd /d %COMPDIR%

setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

g++.exe -static-libgcc -static-libstdc++ "%MAINDIR%\IncGen.c" -o "%MAINDIR%\IncGen.exe"

windres "%MAINDIR%\Mundi.rc" -o "%MAINDIR%\Mundi.o"
g++.exe -mwindows -O3 "%MAINDIR%\Mundi.c" "%MAINDIR%\Mundi.o" -o "%MAINDIR%\Mundi.exe"
del "%MAINDIR%\Mundi.o"

"%MAINDIR%\IncGen.exe" "%MAINDIR%\Mundi.exe"
"%MAINDIR%\Mundi.exe"

windres "%MAINDIR%\Installer.rc" -o "%MAINDIR%\Installer.o"
g++.exe -mwindows -O3 "%MAINDIR%\Installer.c" "%MAINDIR%\Installer.o" -o "%MAINDIR%\Installer.exe"
del "%MAINDIR%\Installer.o"

pause
