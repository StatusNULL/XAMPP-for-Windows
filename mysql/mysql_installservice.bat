@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
echo Don't be stupid! Win9x don't know Services
echo Please use mysql_start.bat instead
goto exit

:WinNT
echo Note: We need a c:\my.cnf for an installation as service!
echo Just i have copy bin\my.nt-cnf as c:\my.cnf.
copy bin\my.nt-cnf /-y c:\my.cnf
echo You should control the c:\my.cnf for absolute paths!
echo Installing MySQL as an Service
bin\mysqld-nt --install
echo MySQL is starting as service ... 

:exit
pause