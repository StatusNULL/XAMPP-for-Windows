  ApacheFriends XAMPP Version 1.4 für Windows (25.03.2004)

  + Apache 2.0.49
  + MySQL 4.0.18
  + PHP 4.3.4 + PEAR
  + mod_php 4.3.4 
  + Perl 5.8.3 
  + mod_perl 1.99_13
  + mod_ssl 2.0.49
  + openssl 0.9.7d
  + SQLite 2.8.11  + mod_auth_mysql (only experimental)

  + PHPMyAdmin 2.5.6
  + Webalizer 2.01-10
  + Mercury Mail Transport System for Win32 and NetWare Systems v3.32
  + JpGraph 1.14 (only for non-commercial, open-source and educational use)
  + FileZilla FTP Server 0.8.8
  + Oswalds CD Collection v0.2 (!)
  + PHP mcrypt() 2.4
  + Turck MMCache 2.4.6 (PHP accelerator, optimizer, encoder and dynamic content cache for PHP) 
  + ADODB 4.04
  + PHPBlender 0.9 (only NT systems PHP compiler)
 
* System Vorrausetzungen:
  
  + 64 MB RAM (recommended)
  + 175 MB free Fixed Disk 
  + Windows 98, ME, XP Home
  + Windows NT, 2000, XP Professional (Recommended)

SCHNELLINSTALLATION:

Schritt 1: Das ZIP an eine beliebige Stelle entpacken. Der
Aufruf von => [Laufwerk]:\xampp\setup_xampp.bat konfiguriert danach
alle notwendigen Konfigurationsdateien mit den entsprechenden Pfadangeben.

[ODER ALTERNATIV: Auf die obersten Hirachie eines beliebigen Laufwerks 
deiner Festplatte (Partition) entpacken => C:\ oder E:\. Es 
entsteht c:\xampp oder e:\xampp.]  

Schritt 2: Apache2 mit PHP4 starten mit
=> [Laufwerk]:\xampp\apache_start.bat
Der Apache 2 wird durch einfaches schließen der 
Apache Kommandoforderung (CMD) heruntergefahren. 

Schritt 3: MySQL starten der mit 
=> [Laufwerk]:\xampp\mysql_start.bat
Den MySQL regulär stoppen mit "mysql_stop.bat".

Schritt 4: Öffne deinen Internet Browser und gebe http://127.0.0.1
oder http://localhost ein. Danach gelangst du zu den zahlreichen 
ApacheFriends Beispielen auf deinem lokalen Server. Für eine verschlüsselte 
SSL Verbindung über ein mitgeliefertes Testzertifikat https://127.0.0.1 
(https://localhost) benutzen.    

Schritt 5: Das Hauptdokumentenverzeichnis für HTTP (oft HTML) ist
=> [Laufwerk]:\xampp\htdocs. PHP kann die Endungen  *.php, *.php4,
*.php3, *.phtml haben, *.shtml für SSI, *.cgi für CGI (z.B. perl).

Schritt 6: Perl Programme über Mod_perl bitte in das Verzeichnis
=> [Laufwerk]:\xampp\htdocs\modperl
und testen über http://localhost/perl/modperl.pl

Perl:ASP kommt in das Verzeichnis 
=> [Laufwerk]:\xampp\htdocs\modperlasp
und testen über http://localhost/perlasp/loop.asp

Schritt 7: Mercury Mail Server starten mit 
=> [Laufwerk]:\xampp\mercury_start.bat

Schritt 8: FileZilla FTP Server initialisieren mit 
=> [Laufwerk]:\xampp\filezilla_setup.bat
Zuvor darauf achten, dass alle Pfade in der FileZilla Config-Datei  
=> [Laufwerk]:\xampp\FileZillaFTP\FileZilla Server.xml
in absolute Angeben (wie c:\xampp\anonymous\incoming) geändert wurden! 

Schritt 9: XAMPP DEINSTALLIEREN? Einfach das "xampp" 
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

\...\xampp\apache\apache_installservice.bat
==> Installiert des Apache 2 als Dienst

\...\xampp\apache\apache_uninstallservice.bat  
==> Deinstalliert des Apache 2 als Dienst

\...\xampp\apache\mysql_installservice.bat
==> Installiert MySQL als Dienst 
Wichtig: Zuvor die \xampp\mysql\bin\my.cnf nach c:\ (also c:\my.cnf) kopieren!

\...\xampp\apache\mysql_uninstallservice.bat
==> Deinstalliert MySQL als Dienst

\...\xampp\filezilla_setup.bat
==> Installiert und deinstalliert FileZilla FTP Server als Dienst

==> Nach allen Dienst(de)installationen, System neustarten! 
---------------------------------------------------------------

Apache Hinweise:

(1) Im Gegesatz zu dem Apache 1.x kann der Apache 2 bei 
einen manuellen Start nicht mit "apache -k shutdown" gestoppt
werden. Das funktioniert nur als Dienstinstallation unter 
NT Systemen. Also die Apache START Eingabeforderungen zum stoppen 
einfach schließen.

  
(2) Für Mod_Dav experimentell. Zum laden von Web_DAV nur die Module 
mod_dav.so + mod_dav_fs.so in der httpd.conf entkommentieren 
(# entfernen). Dann für http://127.0.0.1:81 einrichten und testen!
(nicht für MS Frontpage, einzig für Adobe Dreamweaver)


(3) Für mod_auth_mysql experimentell. Das Modul ebenfalls einfach
in der "httpd.conf" entkomentieren. Weitere Hinweise zu diesem Modul 
findet Ihr auf der Hauptseite dieses Xampp-Pakets.   


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
Last revised version 25.03.2004 Kay Vogelgesang
 