@echo off
echo Diese Eingabeforderung nicht waehrend des Running beenden
echo Please dont close Window while MySQL is running
echo MySQL is trying to start
echo Please wait  ...
echo MySQL is starting with bin\my.cnf (console)
bin\mysqld --defaults-file=bin\my.cnf --standalone