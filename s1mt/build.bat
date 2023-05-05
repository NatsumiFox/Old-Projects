@echo off
set month-num=%date:~6,2%
if %month-num%==01 set mo-name=Jan
if %month-num%==02 set mo-name=Feb
if %month-num%==03 set mo-name=Mar
if %month-num%==04 set mo-name=Apr
if %month-num%==05 set mo-name=May
if %month-num%==06 set mo-name=Jun
if %month-num%==07 set mo-name=Jul
if %month-num%==08 set mo-name=Aug
if %month-num%==09 set mo-name=Sep
if %month-num%==10 set mo-name=Oct
if %month-num%==11 set mo-name=Nov
if %month-num%==12 set mo-name=Dec

ECHO 	dc.b '@    %date:~3,2%.%mo-name%.%date:~9,4%'>CurrentBuild.asm

asm68k /p sonic1.asm, SonicMT.bin, , SourceListing.asm
fixheadr.exe SonicMT.bin
COPY /Y SonicMT.bin A:\NSFW\Sonic1MT.beta.bin
pause