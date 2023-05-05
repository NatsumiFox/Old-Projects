@echo off

REM === This setup is different, because the path contains the & symbol ===

setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

g++.exe "%MAINDIR%\_MaskGen.c" -o "%MAINDIR%\_MaskGen.exe"

pause
