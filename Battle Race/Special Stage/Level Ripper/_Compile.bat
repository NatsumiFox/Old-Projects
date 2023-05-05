@echo off
setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

g++.exe -static-libgcc -static-libstdc++ "%MAINDIR%\_Level Ripper.c" -o "%MAINDIR%\_Level Ripper.exe"

pause
