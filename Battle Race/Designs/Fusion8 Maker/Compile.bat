@echo off
setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

g++.exe -static-libgcc -static-libstdc++ "%MAINDIR%\F8 Maker.c" -o "%MAINDIR%\F8 Maker.exe"

pause
