@echo off
echo Diese Eingabeforderung nicht waehrend des Running beenden
echo Please dont close Window while MySQL is running
echo MySQL is trying to start
echo Please wait  ...
echo MySQL is starting with mysql\bin\my.cnf (console)
mysql\bin\mysqld --defaults-file=mysql\bin\my.cnf --standalone
if errorlevel 1 (
	echo.
	echo MySQL konnte nicht gestartet werden
	echo MySQL could not be started
	pause
)

