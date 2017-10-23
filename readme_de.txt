  ApacheFriends XAMPP (basic package) version 1.5.2

  + Apache 2.2.0
  + MySQL 5.0.20
  + PHP 5.1.2 + PHP 4.4.2-pl1 + PEAR
  + eAccelerator 0.9.4-rc1 (nicht stabil with PHP 5.1.2)
  + PHP-Switch win32 1.0 (von Apachefriends, man nehme die "php-switch.bat") 
  + XAMPP Control Version 2.2 from www.nat32.com	
  + XAMPP Security 1.0	
  + SQLite 2.8.15
  + OpenSSL 0.9.8a
  + phpMyAdmin 2.8.0.3
  + ADOdb 4.80
  + Mercury Mail Transport System v4.01b
  + FileZilla FTP Server 0.9.14a
  + Webalizer 2.01-10
  + Zend Optimizer 3.0.0
 
* System Vorrausetzungen:
  
  + 64 MB RAM (recommended)
  + 200 MB free Fixed Disk 
  + Windows 98, ME
  + Windows NT, 2000, XP (Recommended)

SCHNELLINSTALLATION:

[Schritt 1: Auf die obersten Hirachie eines beliebigen Laufwerks bzw. 
auf dem Wechseldatenträger des USP Sticks entpacken => E:\ oder W:\. Es 
entsteht E:\xampp oder W:\xampp. Für den USB Stick nicht die 
"setup_xampp.bat" nutzen, um ihn auch transportabel nutzen zu können!]

Schritt 1: Das Setup mit der  Datei "setup_xampp.bat" im XAMPP Verzeichnis 
starten.Bemerkung: XAMPP macht selbst keine Einträge in die Windows Registry
und setzt auch keine Systemvariablen.   

Schritt 2: Apache2 mit PHP4 starten mit
=> \xampp\apache_start.bat
Der Apache 2 wird durch einfaches schließen der 
Apache Kommandoforderung (CMD) heruntergefahren. 

Schritt 3: MySQL starten der mit 
=> \xampp\mysql_start.bat
Den MySQL regulär stoppen mit "mysql_stop.bat".

Schritt 4: Öffne deinen Internet Browser und gebe http://127.0.0.1
oder http://localhost ein. Danach gelangst du zu den zahlreichen 
ApacheFriends Beispielen auf deinem lokalen Server.

Schritt 5: Das Hauptdokumentenverzeichnis für HTTP (oft HTML) ist
=> \xampp\htdocs. PHP kann die Endungen  *.php, *.php4,
*.php3, *.phtml haben, *.shtml für SSI, *.cgi für CGI (z.B. perl).

Schritt 6: XAMPP DEINSTALLIEREN? Einfach das "xampp" 
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
(NT4 | windows 2000 | windows xp)

\xampp\apache\apache_installservice.bat =
==> Installiert des Apache 2 als Dienst

\xampp\apache\apache_uninstallservice.bat =   
==> Deinstalliert des Apache 2 als Dienst

\xampp\mysql\mysql_installservice.bat =
==> Installiert MySQL als Dienst

\xampp\mysql\mysql_uninstallservice.bat = 
==> Deinstalliert MySQL als Dienst

==> Nach allen Dienst(de)installationen, system neustarten! 
---------------------------------------------------------------

DAS THEMA SICHERHEIT

Wie schon an anderer Stelle erwähnt ist XAMPP nicht für den Produktionseinsatz gedacht, 
sondern nur für Entwickler in Entwicklungsumgebungen. Das hat zur Folge, dass XAMPP 
absichtlich nicht restriktiv sondern im Gegenteil sehr offen vorkonfiguriert ist. Für 
einen Entwickler ist das ideal, da er so keine Grenzen vom System vorgeschrieben bekommt. 
Für einen Produktionseinsatz ist das allerdings überhaupt nicht geeignet.Hier eine Liste, 
der Dinge, die an XAMPP absichtlich(!) unsicher sind:

Der MySQL-Administrator (root) hat kein Passwort. 
Der MySQL-Daemon ist übers Netzwerk erreichbar. 
phpMyAdmin ist übers Netzwerk erreichbar. 
In dem XAMPP-Demo-Seiten (die man unter http://localhost findet) gibt es den Punkt "Sicherheitscheck". 
Dort kann man sich den aktuellen Sicherheitszustand seiner XAMPP-Installation anzeigen lassen.

Will man XAMPP in einem Netzwerk betreiben, so dass der XAMPP-Server auch von anderen 
erreichbar ist, dann sollte man unbedingt den folgende URL aufrufen, mit dem man 
diese Unsicherheiten einschränken kann: 

http://localhost/security/

Hier kann das root Passwort für MySQL + phpMyAdmin und auch ein Verzeichnisschutz für die 
XAMPP-Seiten eingerichtet werden. 


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
bzw. als Dienst die C:\my.cnf unter NT/2000/XP. Dort akiviert ihr dann die Zeile
"innodb_data_file_path=ibdata1:30M". Achtung, "innodb" kann ich derzeit nicht
für 95/98/ME empfehlen, da es hier immmer wieder zu blockierenden 
Systemen kam. Also nur NT/2000/XP!  

Wer MySQL als Dienst unter NT/2000/XP benutzen möchte, muss 
unbedingt (!) vorher die "my" bzw."my.cnf unter c:\ (also c:\my.cnf) 
implementieren. Danach die "mysql_installservice.bat" im mysql-Ordner 
aktivieren.  		 	


3) Der MySQL-Server startet ohne Passwort für MySQl-Administrator "root". 
Für eine Zugriff in PHP sähe das also aus:  
mysql_connect("localhost","root","");
Ein Passwort für "root" könnt ihr über den mysqladmin in der Eingabforderung
setzen. Z.B: 
    \xampp\mysql\bin\mysqladmin -u root password geheim
Wichtig: Nach dem einsetzen eines neuen Passwortes für root muss auch 
phpMyAdmin informiert werden! Das geschieht über die Datei "config.inc.php"
zu finden als \xampp\phpmyadmin\config.inc.php. Dort also folgenden 
Zeilen editieren:  
   
    $cfg['Servers'][$i]['user']            = 'root';   // MySQL user
    $cfg['Servers'][$i]['auth_type']       = 'http';   // HTTP Authentifzierung

So wird zuerst das 'root' Passwort vom MySQL Server abgefragt, bevor
phpMyAdmin zugreifen darf.  	
    
---------------------------------------------------------------	
    
Have a lot of fun! Viel Spaß! Bonne Chance!
 