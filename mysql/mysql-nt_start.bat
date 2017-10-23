@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
bin\mysqld-nt --defaults-file=mysql\bin\my.nt-cnf
goto exit

:WinNT
echo please use mysql_start.bat under NT
rem man könnte es dem user ja auch verbieten...
bin\mysqld-nt --defaults-file=mysql\bin\my.nt-cnf
goto exit

:exit
pause