@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
echo please use mysql_start.bat under Win98
bin\mysqld --defaults-file=bin\my.cnf --standalone
goto exit

:WinNT
bin\mysqld-nt --defaults-file=bin\my.nt-cnf
goto exit

:exit
pause