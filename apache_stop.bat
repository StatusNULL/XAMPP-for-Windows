@echo off
apache\bin\kill.exe /f apache.exe
if not exist apache\logs\httpd.pid GOTO exit
del apache\logs\httpd.pid

:exit
