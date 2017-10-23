@ECHO OFF
set PHP_BIN=install\php.exe
set INSTALL_BIN=install\install.php
%PHP_BIN% -n -d output_buffering=0 -r "echo '%os%'"; > os.txt
%PHP_BIN% -n -d output_buffering=0 %INSTALL_BIN%
pause