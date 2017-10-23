  ApacheFriends XAMPP (basic package) version 1.4.6 (win32)

  + Apache 2.0.50
  + MySQL 4.0.20
  + PHP 5.0.1 + PHP 4.3.8 + PEAR
  + PHP-Switch win32 1.0 (von Apachefriends, man nehme die "php-switch.bat")   	
  + mod_php 4.3.7
  + MiniPerl 5.8.3
  + SQLite 3.0.4
  + PHPMyAdmin 2.5.7 pl1
  + ADODB 4.21
  + Mercury Mail Transport System for Win32 and NetWare Systems v4.01a
  + FileZilla FTP Server 0.9.1
  + Webalizer 2.01-10
  + Zend Optimizer 2.5.3
 
* System Vorrausetzungen:
  
  + 64 MB RAM (recommended)
  + 115 MB free Fixed Disk 
  + Windows 98, ME, XP Home
  + Windows NT, 2000, XP Professional (Recommended)


SCHNELLINSTALLATION:

[Schtitt 1: Auf die obersten Hirachie eines beliebigen Laufwerks bzw. 
auf dem Wechseldatentr�ger des USP Sticks entpacken => E:\ oder W:\. Es 
entsteht E:\xampp oder W:\xampp. F�r den USB Stick nicht die 
"setup_xampp.bat" nutzen, um ihn auch transportabel nutzen zu k�nnen!]

Schritt 1: Das Setup mit der  Datei "setup_xampp.bat" im xampp Verzeichnis 
starten.Bemerkung: xampp macht selbst keine Eintr�ge in die Windows Registry
und setzt auch keine Systemvariablen.   

Schritt 2: Apache2 mit PHP4 starten mit
=> [Laufwerk]:\xampp\apache_start.bat
Der Apache 2 wird durch einfaches schlie�en der 
Apache Kommandoforderung (CMD) heruntergefahren. 

Schritt 3: MySQL starten der mit 
=> [Laufwerk]:\xampp\mysql_start.bat
Den MySQL regul�r stoppen mit "mysql_stop.bat".

Schritt 4: �ffne deinen Internet Browser und gebe http://127.0.0.1
oder http://localhost ein. Danach gelangst du zu den zahlreichen 
ApacheFriends Beispielen auf deinem lokalen Server.

Schritt 5: Das Hauptdokumentenverzeichnis f�r HTTP (oft HTML) ist
=> [Laufwerk]:\xampp\htdocs. PHP kann die Endungen  *.php, *.php4,
*.php3, *.phtml haben, *.shtml f�r SSI, *.cgi f�r CGI (z.B. perl).

Schritt 6: xampp DEINSTALLIEREN? Einfach das "xampp" 
Verzeichnis l�schen. Vorher aber alle Server stoppen 
bzw. als Dienste  deinstallieren. 

---------------------------------------------------------------
PASSW�RTER

1) MySQL

Benutzer: root
Passwort:
(also kein Passwort)

2) FileZilla FTP

Benutzer: newuser
Passwort: wampp 

Benutzer: anonymous
Passwort: some@mail.net

3) Mercury: 
Postmaster: postmaster (postmaster@localhost) und Admin (Admin@localhost)

Testuser: newsuser  
Passwort: wampp 

4) WEBDAV: 

Benutzer: wampp
Password: xampp 

---------------------------------------------------------------
NUR F�R NT SYSTEME
(NT4 | windows 2000 | windows xp professional)

\...\xampp\apache\apache_installservice.bat =
==> Installiert des Apache 2 als Dienst

\...\xampp\apache\apache_uninstallservice.bat =   
==> Deinstalliert des Apache 2 als Dienst

\...\xampp\apache\mysql_installservice.bat =
==> Installiert MySQL als Dienst

\...\xampp\apache\mysql_uninstallservice.bat = 
==> Deinstalliert MySQL als Dienst

==> Nach allen Dienst(de)installationen, system neustarten! 
---------------------------------------------------------------

Apache Hinweise:

(1) Im Gegesatz zu dem Apache 1.x kann der Apache 2 bei 
einen manuellen Start nicht mit "apache -k shutdown" gestoppt
werden. Das funktioniert nur als Dienstinstallation unter 
NT Systemen. Also die Apache START Eingabeforderungen zum stoppen 
einfach schlie�en.


(2) F�r mod_auth_mysql experimentell. Das Modul ebenfalls einfach
in der "httpd.conf" entkomentieren. Weitere Hinweise zu diesem Modul 
findet Ihr auf der Hauptseite dieses Xampp-Pakets.   


(3) Zum laden von Web_DAV nur die Module 
mod_dav.so + mod_dav_fs.so in der httpd.conf entkommentieren 
(# entfernen). Dann f�r http://127.0.0.1:81 einrichten und testen!
(nicht f�r MS Frontpage, einzig f�r Adobe Dreamweaver)


MYSQL Hinweise:

1) Um den mysqld zu starten bitte Doppelklick auf \xampp\mysql_start.bat. 
Der MySQL Server startet dann im Konsolen-Modus. Das dazu geh�rige 
Konsolenfenster muss offen bleiben (!!) Zum Stop bitte die mysql_shutdown.bat 
benutzen!

2) Um den MySQL Daemon von diesem Paket mit "innodb" f�r bessere Performance zu
nutzen, editiert bitte die "my" bzw."my.cnf" im /xampp/mysql/bin Verzeichnis
bzw. als Dienst die C:\my.cnf unter NT/2000. Dort akiviert ihr dann die Zeile
"innodb_data_file_path=ibdata1:30M". Achtung, "innodb" kann ich derzeit nicht
f�r 95/98/ME/XP Home empfehlen, da es hier immmer wieder zu blockierenden 
Systemen kam. Also nur NT/2000/XP Professional !  

Wer MySQL als Dienst unter NT/2000/XP Professional benutzen m�chte, muss 
unebdingt (!) vorher die "my" bzw."my.cnf unter c:\ (also c:\my.cnf) 
implementieren. Danach die "mysql_installservice.bat" im mysql-Ordner 
aktivieren.  		 	


3) Der MySQL-Server startet ohne Passwort f�r MySQl-Administrator "root". 
F�r eine Zugriff in PHP s�he das also aus:  
mysql_connect("localhost","root","");
Ein Passwort f�r "root" k�nnt ihr �ber den mysqladmin in der Eingabforderung
setzen. Z.B: 
    [Laufwerk:]\xampp\mysql\bin\mysqladmin -u root password geheim
Wichtig: Nach dem einsetzen eines neuen Passwortes f�r root muss auch 
PHPMyAdmin informiert werden! Das geschieht �ber die Datei "config.inc.php"
zu finden als \xampp\phpmyadmin\config.inc.php. Dort also folgenden 
Zeilen editieren:  
   
    $cfg['Servers'][$i]['user']            = 'root';   // MySQL user
    $cfg['Servers'][$i]['auth_type']       = 'http';   // HTTP Authentifzierung

So wird zuerst das 'root' Passwort vom MySQL Server abgefragt, bevor
PHPMyAdmin zugreifen darf.  	
    
---------------------------------------------------------------	
    
Have a lot of fun! Viel Spa�! Bonne Chance!
Last revised version 16.08.2004 Kay Vogelgesang
 