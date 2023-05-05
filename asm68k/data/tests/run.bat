@echo off
pushd %~dp0
cd ..
%2 -q %3 --trace tests/%1/test.log --lst tests/%1/test.lst tests/%1/main.asm tests/%1/test.dat
if %ERRORLEVEL% NEQ 0 exit 1
%4 --uprint tests/%1/main.dat tests/%1/test.lst tests/%1/test.dat
if %ERRORLEVEL% NEQ 0 exit 1
fc tests\%1\main.log tests\%1\test.log
if %ERRORLEVEL% NEQ 0 exit 1
exit 0
