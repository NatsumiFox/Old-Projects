@echo off
call build.bat
tools\KENSC\koscmp.exe boss\wall\.bin boss\wall\.kos
REM copy /Y boss\mecha\.bin boss\mecha\.kos
tools\KENSC\koscmp.exe boss\mecha\.bin boss\mecha\.kos
call build.bat