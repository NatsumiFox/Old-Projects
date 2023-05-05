@echo off
SET fil=%~p1%~n1
G:\Disassemblies\ssrgboss\tools\KENSC\nemcmp.exe -x %fil%%~x1 %fil%.unc
G:\Disassemblies\ssrgboss\tools\KENSC\koscmp.exe -m %fil%.unc %fil%.kosM
del %fil%.unc