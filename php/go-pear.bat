@ECHO OFF
set PHP_BIN=cli\php.exe
%PHP_BIN% -n -d output_buffering=0 pear\go-pear.php
pause
