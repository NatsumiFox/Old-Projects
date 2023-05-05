@echo off
setlocal enableDelayedExpansion
set "MAINDIR=%CD%"
set "COMPDIR=C:\MinGW\mingw64\bin"
cd /d !COMPDIR!

windres "%MAINDIR%\_Resources\Resource.rc" "%MAINDIR%\_Resources\Resource.o"
echo Normal
g++ -O3 -DMUSEUM=FALSE "%MAINDIR%\_BitmapMD.c" "%MAINDIR%\_Resources\Resource.o" -static-libgcc -static-libstdc++ -lcomdlg32 -lgdi32 -o "%MAINDIR%\_BitmapMD.exe"
echo Museum
g++ -O3 -DMUSEUM=TRUE "%MAINDIR%\_BitmapMD.c" "%MAINDIR%\_Resources\Resource.o" -static-libgcc -static-libstdc++ -lcomdlg32 -lgdi32 -o "%MAINDIR%\_BitmapMD (Museum).exe"
del "%MAINDIR%\_Resources\Resource.o"

pause
