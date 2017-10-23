@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
echo Don't be stupid! Win9x don't know Services
echo Please use mysql_start.bat instead
goto exit

:WinNT
echo Installing MySQL as an Service
bin\mysqld-nt --install
echo Creating an example config ...
copy bin\my.nt-cnf .\my_example.cnf
echo Before we can run MySQL you must copy the my_example.cnf as c:\my.cnf

:exit
pause