@ECHO OFF

if exist php\phpcli.exe GOTO Normal
if exist php\cli\php.exe GOTO Unnormal
if not exist php\cli\php.exe GOTO Abort

:Abort
echo Sorry ... cannot find php cli!
echo Must abort these process!
pause
GOTO END

:Unnormal
if exist php\cli\php.exe GOTO Copy
GOTO END

:Copy
copy /Y php\cli\php.exe php\phpcli.exe
GOTO Normal

:Normal
set PHP_BIN=php\phpcli.exe
set CONFIG_PHP=install\install.php
%PHP_BIN% -n -d output_buffering=0 %CONFIG_PHP%
GOTO END

:END
pause