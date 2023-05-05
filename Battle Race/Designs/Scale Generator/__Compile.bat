@echo off
setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

g++.exe -static-libgcc -static-libstdc++ "%MAINDIR%\_ImGen.c" -o "%MAINDIR%\_ImGen.exe"
g++.exe -static-libgcc -static-libstdc++ "%MAINDIR%\_ScaleGen.c" -o "%MAINDIR%\_ScaleGen.exe"

pause
