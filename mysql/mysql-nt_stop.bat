@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
mysql_stop.bat
goto exit

:WinNT
set mysql-nt=run
mysql_stop.bat
goto exit

:exit
rem no pause :)