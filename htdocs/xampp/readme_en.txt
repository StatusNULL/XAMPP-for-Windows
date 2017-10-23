  ApacheFriends XAMPP for windows Version 1.3 (09.02.2004) 

  + Apache 2.0.48
  + MySQL 4.0.17
  + PHP 4.3.4 + PEAR
  + mod_php 4.3.4 
  + Perl 5.8.2 
  + mod_perl 1.99_12
  + mod_ssl 2.0.48
  + openssl 0.9.7c
  + SQLite 2.8.11  + mod_auth_mysql (only experimental)

  + PHPMyAdmin 2.5.5 pl1
  + Webalizer 2.01-10
  + Mercury Mail Transport System for Win32 and NetWare Systems v3.32
  + JpGraph 1.14 (only for non-commercial, open-source and educational use)
  + FileZilla FTP Server 0.8.8
  + Oswalds CD Collection v0.2 (!)
  + PHP mcrypt() 2.4
  + Turck MMCache 2.4.6 (PHP accelerator, optimizer, encoder and dynamic content cache for PHP) 
  + ADODB 4.04
  + PHPBlender 0.9 (only NT systems PHP compiler)
 
* System Requirements:
  
  + 64 MB RAM (recommended)
  + 175 MB free Fixed Disk 
  + Windows 98, ME, XP Home
  + Windows NT, 2000, XP Professional (Recommended)

QUICK INSTALLATION:

Step 1: Unpack the package into a directory of your choice.

Step 2: Please start "setup_xampp.bat". Enter the number 1 to 
beginning the installation with MOD_PERL. Without MOD_PERL use 
number2. MOD_PERL in this Configuration delaying START and STOP
of the Apache Server.

[or alternatve: Unpack the package to a partition of your choice.
There it must be on the highest level like C:\ or E:\. It will 
build c:\xampp or e:\xampp or something like
this.]  

Step 3: If installation ends successfully, start the Apache 2 with 
"apache_start".bat", MySQL with "mysql_start".bat". Stop the MySQL 
Server with "mysql_stop.bat". For shutdown the Apache HTTPD, only 
close the Apache Command (CMD).  

Step 4: Start your browser and type http://127.0.0.1 or 
http://localhost in the location bar. You should see our pre-made
start page with certain examples and test screens. 

Step 5: PHP (with mod_php, as *.php, *.php4, *.php3, *.phtml), Perl
by default with *.cgi, SSI with *.shtml are all located in 
=> \...\xampp\htdocs\.
Beispiele (Examples):
=> \...\xampp\htdocs\test.php => http://localhost/test.php
=> \...\xampp\myhome\test.php => http://localhost/myhome/test.php

Step 6: Perl with mod_perl will execute in 
=> \...\xampp\htdocs\modperl
Test ist with http://localhost/perl/modperl.pl
Perl:ASP will execute in 
=> \...\xampp\htdocs\modperlasp
Test ist with http://localhost/perlasp/loop.asp

Step 7: Start Mercury Mail Server with
=> \...\xampp\mercury_start.bat

Step 8: Configure FileZilla FTP Server with 
=> \...\xampp\filezilla_setup.bat
In the "FileZilla Server.xml", please change all relative paths into absolute paths  
=> \...\xampp\FileZillaFTP\FileZilla Server.xml

Step 9: XAMPP UNINSTALL? Simply remove the "xampp" Directory.
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

\...\xampp\apache\apache_installservice.bat
==> Install Apache 2 as service   

\...\xampp\apache\apache_uninstallservice.bat
==> Uninstall Apache 2 as service   

\...\xampp\apache\mysql_installservice.bat
==> Install MySQL as service 
Before, please copy the my.cnf with absolute paths to c:\ (c:\my.cnf)!    

\...\xampp\apache\mysql_uninstallservice.bat
==> Uninstall MySQL as service   

\...\xampp\filezilla_setup.bat
==> Install or uninstall FileZilla FTP Server as service 

==> After all Service (un)installations, better restart system!
---------------------------------------------------------------

Apache Notes:

(1) In contrast of apache 1.x, you can not stop the apache2
with the command "apache -k shutdown". These functions only for
an installations as service by NT systems. So, simply close
the Apache START command for shutdown. 
  
(2) To use the experimental version of Mod_Dav load the Modules 
mod_dav.so + mod_dav_fs.so in the httpd.conf by removing the # on 
the beginning of their lines. Then try http://127.0.0.1:81 (not 
for Frontpage, but for Dreamweaver)


(3) To use the experimental version of mod_auth_mysql remove the # in
the httpd.conf. Detailed information about this topic can be found on 
the left menu of xampp, once you started it.


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
Last revised version 09.02.2004 Kay Vogelgesang
     