@ECHO OFF

REM // make sure we can write to the file s1built.bin
REM // also make a backup to s1built.prev.bin
IF NOT EXIST s1built.bin goto LABLNOCOPY
IF EXIST s1built.prev.bin del s1built.prev.bin
IF EXIST s1built.prev.bin goto LABLNOCOPY
move /Y s1built.bin s1built.prev.bin
IF EXIST s1built.bin goto LABLERROR3
REM IF EXIST s1built.prev.bin copy /Y s1built.prev.bin s1built.bin
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST s1.p del s1.p
IF EXIST s1.p goto LABLERROR2
IF EXIST s1.h del s1.h
IF EXIST s1.h goto LABLERROR1

REM // clear the output window
cls


REM // run the assembler
REM // -xx shows the most detailed error output
REM // -c outputs a shared file (s1.h)
REM // -A gives us a small speedup
set AS_MSGPATH=win32/msg
set USEANSI=n
"win32/asw" -xx -c -A -q s1.asm

REM // combine the assembler output into a rom
IF EXIST s1.p "win32/s2p2bin" s1.p s1built.bin s1.h

REM // fix some pointers and things that are impossible to fix from the assembler without un-splitting their data
IF EXIST s1built.bin "win32/fixpointer" s1.h s1built.bin   off_3A294 MapRUnc_Sonic $2D 0 4   word_728C_user Obj5F_MapUnc_7240 2 2 1  

REM REM // fix the rom header (checksum)
IF EXIST s1built.bin "win32/fixheader" s1built.bin


REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST s1.p goto LABLPAUSE
IF EXIST s1built.bin exit /b
:LABLPAUSE
pause


exit /b

:LABLERROR1
echo Failed to build because write access to s1.h was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to s1.p was denied.
pause


exit /b

:LABLERROR3
echo Failed to build because write access to s1built.bin was denied.
pause


