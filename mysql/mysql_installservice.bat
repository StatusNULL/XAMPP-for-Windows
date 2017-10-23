@echo off

if "%OS%" == "Windows_NT" goto WinNT

:Win9X
echo Don't be stupid! Win9x don't know Services
echo Please use mysql_start.bat instead
goto exit

:WinNT
echo Note: We need a %windir%\my.ini for an installation as service!
echo Just i will copy bin\my.ini as %windir%\my.ini.
copy bin\my.ini /-y %windir%\my.ini
echo You should control the %windir%\my.ini for absolute paths!
echo Installing MySQL as an Service
bin\mysqld-nt --install
echo Try to start the MySQL deamon as service ...
net start mysql 
:exit
pause