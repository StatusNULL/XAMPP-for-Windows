  ApacheFriends XAMPP (basic package) version 1.4.10 (win32)

  + Apache 2.0.52
  + MySQL 4.1.7
  + PHP 5.0.2 + PHP 4.3.9 + PEAR
  + PHP-Switch win32 1.0 (von Apachefriends, man nehme die "php-switch.bat") 
  + XAMPP Security 1.0	
  + MiniPerl 5.8.3
  + SQLite 2.8.15
  + PHPMyAdmin 2.6.0 pl3
  + ADODB 4.52
  + Mercury Mail Transport System for Win32 and NetWare Systems v4.01a
  + FileZilla FTP Server 0.9.4d
  + Webalizer 2.01-10
  + Zend Optimizer 2.5.7
 
* System Requirements:
 
  + 64 MB RAM (recommended)
  + 115 MB free Fixed Disk 
  + Windows 98, ME, XP Home
  + Windows NT, 2000, XP Professional (Recommended)

QUICK INSTALLATION:

[Step 1: Unpack the package to your usb stick or a partition of your choice.
There it must be on the highest level like E:\ or W:\. It will 
build E:\xampp or W:\xampp or something like this. Please do not
use the "setup_xampp.bat" for an USB stick installation!]   

Step 1: Unpack the package into a directory of your choice. Please start the 
"setup_xampp.bat" and beginning the installation. Note: xampp makes no 
entries in the windows registry and no settings for the system variables. 

Step 2: If installation ends successfully, start the Apache 2 with 
"apache_start".bat", MySQL with "mysql_start".bat". Stop the MySQL 
Server with "mysql_stop.bat". For shutdown the Apache HTTPD, only 
close the Apache Command (CMD).  

Step 3: Start your browser and type http://127.0.0.1 or 
http://localhost in the location bar. You should see our pre-made
start page with certain examples and test screens. 

Step 4: PHP (with mod_php, as *.php, *.php4, *.php3, *.phtml), Perl
by default with *.cgi, SSI with *.shtml are all located in 
=> \...\xampp\htdocs\.
Beispiele (Examples):
=> \...\xampp\htdocs\test.php => http://localhost/test.php
=> \...\xampp\myhome\test.php => http://localhost/myhome/test.php

Step 5: XAMPP UNINSTALL? Simply remove the "xampp" Directory.
But before please shutdown the apache and mysql.  

---------------------------------------------------------------
PASSWORDS

1) MySQL

user: root
password:
(means no password!)

2) FileZilla FTP

user: newuser
password: wampp 

user: anonymous
password: some@mail.net

3) Mercury: 
Postmaster: postmaster (postmaster@localhost) und Admin (Admin@localhost)

Testuser: newsuser  
password: wampp

4) WEBDAV: 

user: wampp
password: xampp

---------------------------------------------------------------
ONLY FOR NT SYSTEMS
(NT4 | windows 2000 | windows xp professional)

\...\xampp\apache\apache_installservice.bat =
==> Install Apache 2 as service   

\...\xampp\apache\apache_uninstallservice.bat =
==> Uninstall Apache 2 as service   

\...\xampp\apache\mysql_installservice.bat =
==> Install MySQL as service   

\...\xampp\apache\mysql_uninstallservice.bat =
==> Uninstall MySQL as service   

==> After all Service (un)installations, better restart system!
----------------------------------------------------------------


Apache Notes:

(1) In contrast of apache 1.x, you can not stop the apache2
with the command "apache -k shutdown". These functions only for
an installations as service by NT systems. So, simply close
the Apache START command for shutdown. 
  
(2) To use the experimental version of mod_auth_mysql remove the # in
the httpd.conf. Detailed information about this topic can be found on 
the left menu of xampp, once you started it.

(3) To use Mod_Dav load the Modules 
mod_dav.so + mod_dav_fs.so in the httpd.conf by removing the # on 
the beginning of their lines. Then try http://127.0.0.1:81 (not 
for Frontpage, but for Dreamweaver)


MYSQL NOTES:

(1) The MySQL server can be started by double-clicking (executing)
    mysql_start.bat. This file can be found in the same folder you installed
    xampp in, most likely this will be C:\xampp\.
    The exact path to this file is X:\xampp\mysql_start.bat, where
    "X" indicates the letter of the drive you unpacked xampp into.
    This batch file starts the MySQL server in console mode. The first 
    intialization might take a few minutes.
    
    Do not close the DOS window or you'll crash the server!
    To stop the server, please use mysql_shutdown.bat, which is located in the same
    directory.

(2) To use the MySQL Daemon with "innodb" for better performance, 
    please edit the "my" (or "my.cnf") file in the /xampp/mysql/bin 
    directory or for services the c:\my.cnf for windows NT/2000. 
    In there, activate the "innodb_data_file_path=ibdata1:30M"
    statement. Attention, "innodb" is not recommended for 95/98/ME/XP Home.
    
    To use MySQL as Service for NT/2000/XP Professional, simply copy the "my" 
    / "my.cnf" file to C:\my, or C:\my.cnf. Please note that this 
    file has to be placed in C:\ (root), other locations are not permitted. Then
    execute the "mysql_installservice.bat" in the mysql folder. 	
     	

(3) MySQL starts with standard values for the user id and the password. The preset
    user id is "root", the password is "" (= no password). To access MySQL via PHP
    with the preset values, you'll have to use the following syntax:
    mysql_connect("localhost","root","");
    If you want to set a password for MySQL access, please use of mysqladmin.
    To set the passwort "secret" for the user "root", type the following:
    C:\xampp\mysql\bin\mysqladmin -u root password secret
    
    After changing the password you'll have to reconfigure PHPMyAdmin to use the
    new password, otherwise it won't be able to access the databases. To do that,
    open the file config.inc.php in \xampp\phpmyadmin\ and edit the
    following lines:    
    
    $cfg['Servers'][$i]['user']            = 'root';   // MySQL user
    $cfg['Servers'][$i]['auth_type']       = 'http';   // HTTP authentificate

    So first the 'root' password is queried by the MySQL server, before PHPMyAdmin 
    may access.
  	    	
---------------------------------------------------------------    
Have a lot of fun! Viel Spaﬂ! Bonne Chance!
Last revised version 04.12.2004 Kay Vogelgesang
     