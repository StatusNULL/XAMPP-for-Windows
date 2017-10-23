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
auf dem Wechseldatenträger des USP Sticks entpacken => E:\ oder W:\. Es 
entsteht E:\xampp oder W:\xampp. Für den USB Stick nicht die 
"setup_xampp.bat" nutzen, um ihn auch transportabel nutzen zu können!]

Schritt 1: Das Setup mit der  Datei "setup_xampp.bat" im xampp Verzeichnis 
starten.Bemerkung: xampp macht selbst keine Einträge in die Windows Registry
und setzt auch keine Systemvariablen.   

Schritt 2: Apache2 mit PHP4 starten mit
=> [Laufwerk]:\xampp\apache_start.bat
Der Apache 2 wird durch einfaches schließen der 
Apache Kommandoforderung (CMD) heruntergefahren. 

Schritt 3: MySQL starten der mit 
=> [Laufwerk]:\xampp\mysql_start.bat
Den MySQL regulär stoppen mit "mysql_stop.bat".

Schritt 4: Öffne deinen Internet Browser und gebe http://127.0.0.1
oder http://localhost ein. Danach gelangst du zu den zahlreichen 
ApacheFriends Beispielen auf deinem lokalen Server.

Schritt 5: Das Hauptdokumentenverzeichnis für HTTP (oft HTML) ist
=> [Laufwerk]:\xampp\htdocs. PHP kann die Endungen  *.php, *.php4,
*.php3, *.phtml haben, *.shtml für SSI, *.cgi für CGI (z.B. perl).

Schritt 6: xampp DEINSTALLIEREN? Einfach das "xampp" 
Verzeichnis löschen. Vorher aber alle Server stoppen 
bzw. als Dienste  deinstallieren. 

---------------------------------------------------------------
PASSWÖRTER

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
NUR FÜR NT SYSTEME
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
einfach schließen.


(2) Für mod_auth_mysql experimentell. Das Modul ebenfalls einfach
in der "httpd.conf" entkomentieren. Weitere Hinweise zu diesem Modul 
findet Ihr auf der Hauptseite dieses Xampp-Pakets.   


(3) Zum laden von Web_DAV nur die Module 
mod_dav.so + mod_dav_fs.so in der httpd.conf entkommentieren 
(# entfernen). Dann für http://127.0.0.1:81 einrichten und testen!
(nicht für MS Frontpage, einzig für Adobe Dreamweaver)


MYSQL Hinweise:

1) Um den mysqld zu starten bitte Doppelklick auf \xampp\mysql_start.bat. 
Der MySQL Server startet dann im Konsolen-Modus. Das dazu gehörige 
Konsolenfenster muss offen bleiben (!!) Zum Stop bitte die mysql_shutdown.bat 
benutzen!

2) Um den MySQL Daemon von diesem Paket mit "innodb" für bessere Performance zu
nutzen, editiert bitte die "my" bzw."my.cnf" im /xampp/mysql/bin Verzeichnis
bzw. als Dienst die C:\my.cnf unter NT/2000. Dort akiviert ihr dann die Zeile
"innodb_data_file_path=ibdata1:30M". Achtung, "innodb" kann ich derzeit nicht
für 95/98/ME/XP Home empfehlen, da es hier immmer wieder zu blockierenden 
Systemen kam. Also nur NT/2000/XP Professional !  

Wer MySQL als Dienst unter NT/2000/XP Professional benutzen möchte, muss 
unebdingt (!) vorher die "my" bzw."my.cnf unter c:\ (also c:\my.cnf) 
implementieren. Danach die "mysql_installservice.bat" im mysql-Ordner 
aktivieren.  		 	


3) Der MySQL-Server startet ohne Passwort für MySQl-Administrator "root". 
Für eine Zugriff in PHP sähe das also aus:  
mysql_connect("localhost","root","");
Ein Passwort für "root" könnt ihr über den mysqladmin in der Eingabforderung
setzen. Z.B: 
    [Laufwerk:]\xampp\mysql\bin\mysqladmin -u root password geheim
Wichtig: Nach dem einsetzen eines neuen Passwortes für root muss auch 
PHPMyAdmin informiert werden! Das geschieht über die Datei "config.inc.php"
zu finden als \xampp\phpmyadmin\config.inc.php. Dort also folgenden 
Zeilen editieren:  
   
    $cfg['Servers'][$i]['user']            = 'root';   // MySQL user
    $cfg['Servers'][$i]['auth_type']       = 'http';   // HTTP Authentifzierung

So wird zuerst das 'root' Passwort vom MySQL Server abgefragt, bevor
PHPMyAdmin zugreifen darf.  	
    
---------------------------------------------------------------	
    
Have a lot of fun! Viel Spaß! Bonne Chance!
Last revised version 16.08.2004 Kay Vogelgesang
 