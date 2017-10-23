@echo off
REM PHP Version 5
REM
REM Copyright (c) 2002-2005, Sebastian Bergmann <sb@sebastian-bergmann.de>.
REM All rights reserved.
REM
REM Redistribution and use in source and binary forms, with or without
REM modification, are permitted provided that the following conditions
REM are met:
REM
REM   * Redistributions of source code must retain the above copyright
REM     notice, this list of conditions and the following disclaimer.
REM 
REM   * Redistributions in binary form must reproduce the above copyright
REM     notice, this list of conditions and the following disclaimer in
REM     the documentation and/or other materials provided with the
REM     distribution.
REM
REM   * Neither the name of Sebastian Bergmann nor the names of his
REM     contributors may be used to endorse or promote products derived
REM     from this software without specific prior written permission.
REM
REM THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
REM "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
REM LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
REM FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
REM COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
REM INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
REM BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
REM LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
REM CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRIC
REM LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
REM ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
REM POSSIBILITY OF SUCH DAMAGE.
REM
REM $Id: pear-phpunit.bat,v 1.3.2.1 2005/11/02 10:54:53 sebastian Exp $
REM

::----------------------------------------------------------------------------------
:: Please set following to PHP's CLI
:: NOTE: In PHP 4.2.x the PHP-CLI used to be named php-cli.exe. 
::       PHP 4.3.x names it php.exe but stores it in a subdir called /cli/php.exe
::       E.g. for PHP 4.2 C:\phpdev\php-4.2-Win32\php-cli.exe
::            for PHP 4.3 C:\phpdev\php-4.3-Win32\cli\php.exe
  
:: Check PEAR global ENV, set them if they do not exist
IF "%PHP_PEAR_INSTALL_DIR%"=="" SET "PHP_PEAR_INSTALL_DIR=%PHP_PEAR_BIN_DIR%\pear"
IF "%PHP_PEAR_BIN_DIR%"=="" SET "PHP_PEAR_BIN_DIR=\xampp\php"
IF "%PHP_PEAR_PHP_BIN%"=="" SET "PHP_PEAR_PHP_BIN=%PHP_PEAR_BIN_DIR%\php.exe"
IF "%PHP_PEAR_SYSCONF_DIR%"=="" SET "PHP_PEAR_SYSCONF_DIR=%PHP_PEAR_BIN_DIR%"
IF "%PHP_PEAR_EXTENSION_DIR%"=="" SET "PHP_PEAR_EXTENSION_DIR=%PHP_PEAR_BIN_DIR%\ext"
IF "%PHP_PEAR_DOC_DIR%"=="" SET "PHP_PEAR_DOC_DIR=%PHP_PEAR_INSTALL_DIR%\docs"
IF "%PHP_PEAR_DATA_DIR%"=="" SET "PHP_PEAR_DATA_DIR=%PHP_PEAR_INSTALL_DIR%\data"
IF "%PHP_PEAR_TEST_DIR%"=="" SET "PHP_PEAR_TEST_DIR=%PHP_PEAR_INSTALL_DIR%\tests"
IF "%PHP_PEAR_CACHE_DIR%"=="" SET "PHP_PEAR_CACHE_DIR=\xampp\tmp"

SET phpCli=%PHP_PEAR_PHP_BIN%

"%phpCli%" "%PHP_PEAR_INSTALL_DIR%\PHPUnit2\TextUI\TestRunner.php" %*
