<?

// ---------------------------------------------------------------------
// GLOBAL
// ---------------------------------------------------------------------

$TEXT['global-xampp']="XAMPP für Windows";

// ---------------------------------------------------------------------
// NAVIGATION
// ---------------------------------------------------------------------

$TEXT['navi-xampp']="XAMPP 1.4.7";
$TEXT['navi-welcome']="Willkommen";
$TEXT['navi-status']="Status";
$TEXT['navi-security']="Sicherheitscheck";
$TEXT['navi-doc']="Dokumentation";
$TEXT['navi-components']="Komponenten";
$TEXT['navi-about']="Über XAMPP";

$TEXT['navi-demos']="Demos";
$TEXT['navi-cdcol']="CD-Verwaltung";
$TEXT['navi-bio']="Biorhythmus";
$TEXT['navi-guest']="Gästebuch";
$TEXT['navi-perlenv']="MiniPerl";
$TEXT['navi-iart']="Instant Art";
$TEXT['navi-iart2']="Flash Art";
$TEXT['navi-phonebook']="Telefonbuch";
$TEXT['navi-perlasp']="Perl:ASP";
$TEXT['navi-pear']="PEAR:Excel_Writer";
$TEXT['navi-adodb']="ADOdb";
$TEXT['navi-perl']="Perl";
$TEXT['navi-python']="Python";
$TEXT['navi-jsp']="Java";
$TEXT['navi-phpswitch']="PHP Umschalter";

$TEXT['navi-tools']="Tools";
$TEXT['navi-phpmyadmin']="phpMyAdmin";
$TEXT['navi-webalizer']="Webalizer";
$TEXT['navi-mercury']="Mercury Mail";
$TEXT['navi-filezilla']="FileZilla FTP";
$TEXT['navi-jpgraph']="JpGraph";
                                                                                                                        
$TEXT['navi-languages']="Sprachen";
$TEXT['navi-english']="English";
$TEXT['navi-german']="Deutsch";

// ---------------------------------------------------------------------
// STATUS
// ---------------------------------------------------------------------

$TEXT['status-head']="XAMPP-Status";
$TEXT['status-text1']="Auf dieser Übersicht kann man sehen welche XAMPP-Komponenten gestartet sind bzw. welche funktionieren. Sofern nichts an der Konfiguration von XAMPP geändert wurde, sollten MySQL, PHP, Perl, CGI und SSI aktiviert sein.";
$TEXT['status-text2']="Dieser Check funktioniert nur zuverlässig solange nichts an der Konfiguration des Apache geändert wurde. Durch bestimmte Änderungen kann das Ergebnis dieses Tests verfälscht werden. Mit SSL (https://localhost) funktionieren die Statuschecks nicht!";

$TEXT['status-mysql']="MySQL-Datenbank";
$TEXT['status-ssl']="HTTPS (SSL)";
$TEXT['status-php']="PHP";
$TEXT['status-perl']="Perl mit mod_perl";
$TEXT['status-cgi']="Common Gateway Interface (CGI)";
$TEXT['status-ssi']="Server Side Includes (SSI)";
$TEXT['status-python']="Python mit mod_python";
$TEXT['status-smtp']="SMTP Server";
$TEXT['status-ftp']="FTP Server";
$TEXT['status-tomcat']="Tomcat Server";
$TEXT['status-named']="Domain Name Server (DNS)";
$TEXT['status-mmcache']="PHP-Erweiterung »Turck MMCache«";
$TEXT['status-mmcache-url']="http://www.apachefriends.org/faq-wampp.html#mmcache";
$TEXT['status-oci8']="PHP-Erweiterung »OCI8/Oracle«";
$TEXT['status-oci8-url']="http://www.apachefriends.org/faq-lampp.html#oci8";

$TEXT['status-lookfaq']="siehe FAQ";
$TEXT['status-ok']="AKTIVIERT";
$TEXT['status-nok']="DEAKTIVIERT";

$TEXT['status-tab1']="Komponente";
$TEXT['status-tab2']="Status";
$TEXT['status-tab3']="Hinweis";

// ---------------------------------------------------------------------
// SECURITY
// ---------------------------------------------------------------------

$TEXT['security-head']="XAMPP-Sicherheit";
$TEXT['security-text1']="Anhand dieser Übersicht kann man sehen welche Punkte an der XAMPP-Installation noch unsicher sind und noch überprüft werden müssten. (Bitte unter der Tabelle weiterlesen.)";
$TEXT['security-text2']="Die grün markierten Punkte sind sicher; die rot marktierten Punkte sind definitiv unsicher und bei den gelb martierten Punkten konnte die Sicherheit nicht überprüft werden (zum Beispiel weil das zu testende Programm gar nicht läuft).<p>Zum Schließen dieser Sicherheitslücken einfach als root den folgenden Befehl aufrufen:<p><b>/opt/lampp/lampp security</b><p>Dadurch wird ein dialoggeführtes Programm gestartet, welches alle diese Sicherheitslücken schließen kann.";

$TEXT['security-ok']="SICHER";
$TEXT['security-nok']="UNSICHER";
$TEXT['security-noidea']="UNBEKANNT";

$TEXT['security-tab1']="Betreff";
$TEXT['security-tab2']="Status";

$TEXT['security-checkapache-nok']="Diese XAMPP-Seiten sind über's Netzwerk erreichbar";
$TEXT['security-checkapache-ok']="Diese XAMPP-Seiten sind nicht über's Netzwerk erreichbar";
$TEXT['security-checkapache-text']="Alles was Du hier sehen kannst (diese Seiten, dieser Text), kann potentiell auch jedere andere sehren, der Deinen Rechner über's Netzwerk erreichen kann. Wenn Du zum Beispiel mit diesem Rechner ins Internet geht, dann kann jeder im Internet, der Deine IP-Adresse kennt oder rät auf diese Seiten zugreifen.";

$TEXT['security-checkmysqlport-nok']="MySQL ist über's Netzwerk erreichbar";
$TEXT['security-checkmysqlport-ok']="MySQL ist nicht über's Netzwerk erreichbar";
$TEXT['security-checkmysqlport-text']="Auf die MySQL-Datenbank kann potentiell über's Netzwerk zugegriffen werden. Zwar ist es in der Standardinstallation von XAMPP trotzdem nicht möglich von außen Zugriff zur Datenbank zu bekommen. Aber um eine absolute Sicherheit zu bekommen sollte der Netzwerkzugriff auf MySQL abgeschaltet werden.";

$TEXT['security-checkpmamysqluser-nok']="Der phpMyAdmin-Benutzer pma hat kein Passwort";
$TEXT['security-checkpmamysqluser-ok']="Der phpMyAdmin-Benutzer hat ein Passwort";
$TEXT['security-checkpmamysqluser-text']="phpMyAdmin speichtert seine eigenen Einstellungen in der MySQL-Datenbank. phpMyAdmin benutzt dazu den MySQL-Benutzer pma. Damit sonst niemand anderes als phpMyAdmin über diesen Benutzer auf die Datenbank zugreifen kann, sollte diesem Benutzer ein Passwort gesetzt werden.";

$TEXT['security-checkmysql-nok']="MySQL-root hat kein Passwort";
$TEXT['security-checkmysql-ok']="MySQL-root hat ein Passwort";
$TEXT['security-checkmysql-text']="Der MySQL-root hat noch kein Passwort gesetzt bekommen. Jeder Benutzer auf dem Rechner kann so auf der MySQL-Datenbank machen was er will. Der MySQL-root sollte also auf alle Fälle ein Passwort gesetzt bekommen.";

$TEXT['security-checkftppassword-nok']="Das FTP-Passwort ist noch immer 'lampp'";
$TEXT['security-checkftppassword-ok']="Das FTP-Passwort wurde geändert";
$TEXT['security-checkftppassword-text']="Wenn Du ProFTPD im XAMPP aktiviert hast, dann kannst Du standardmäßig mit dem Benutzernamen 'nobody' und dem Passwort 'lampp' Dateien für Deinen Webserver hochladen. Potentiell kann das nun natürlich jeder und daher sollte hier unbeding ein anderes Passwort gesetzt werden.";

// ---------------------------------------------------------------------
// START
// ---------------------------------------------------------------------

$TEXT['start-head']="Willkommen zu XAMPP für Windows";

$TEXT['start-subhead']="Herzlichen Glückwunsch:<br>XAMPP wurde erfolgreich auf diesem Rechner installiert!";

$TEXT['start-text1']="Nun kann es losgehen. :) Als erstes bitte einmal auf der linken Seite auf »Status« klicken. Damit bekommt man einen Überblick was alles schon funktioniert. Ein paar Funktionen werden ausgeschaltet sein. Das ist Absicht so. Es sind Funktionen, die nicht überall funktionieren oder evtl. Probleme bereiten könnten.";

$TEXT['start-text2']="Achtung: Der XAMPP wurde ab Version 1.4.x auf eine Einzelpaketverwaltung umgestellt. Es gibt nun die folgenden Pakete/Addons: <UL><LI>XAMPP Basis Paket</LI><LI>XAMPP Perl addon</LI><LI>XAMPP Python addon<LI></LI>XAMPP Utility addon (Zubehör aber noch inaktiv)</LI><LI>XAMPP Server addon (weitere Server aber noch inaktiv)</LI><LI>XAMPP Other addon (weitere nützliche Sachen aber noch inaktiv)</LI></UL>";

$TEXT['start-text3']="Bitte \"installiert\" die Zusatzpakete, die ihr noch benötigt, einfach hinterher. Nach dem erfolgreichen raufspielen bitte immer die \"setup_xampp.bat\" betätigen, um den XAMPP neu zu initialisieren. Ach so, die Installerversionen der einzelnen Addons funktionieren nur wenn das XAMPP Basispaket ebenfalls über eine Installerversion eingerichtet wurde.";

$TEXT['start-text4']="Für die OpenSSL Unterstützung benutzt bitte das Testzertifikat mit der URL <a href='https://127.0.0.1' target='_top'>https://127.0.0.1</a> bzw. <a href='https://localhost' target='_top'>https://localhost</a>";

$TEXT['start-text5']="Und ganz wichtig! Einen großen Dank für die Mitarbeit und Mithilfe an Nemesis, KriS, Boppy, Pc-Dummy und allen anderen Freunden von XAMPP!";

$TEXT['start-text6']="Viel Spaß, Kay Vogelgesang + Kai 'Oswald' Seidler";

// ---------------------------------------------------------------------
// MANUALS
// ---------------------------------------------------------------------

$TEXT['manuals-head']="Online-Dokumentation";

$TEXT['manuals-text1']="XAMPP verbindet viele unterschiedliche Pakete in einem Paket. Hier ist eine Auswahl der Standard- und Referenz-Dokumentationen zu den wichtigsten Paketen von XAMPP.";


$TEXT['manuals-list1']="
<ul>
<li><a href=http://httpd.apache.org/docs-2.0/>Apache 2 Dokumentation (in Englisch)</a>
<li><a href=http://www.php.net/manual/de/>PHP <b>Referenz-</b>Dokumentation (in Deutsch)</a>
<li><a href=http://www.perldoc.com/perl5.8.0/pod/perl.html>Perl Dokumentation (in Englisch)</a>
<li><a href=http://www.mysql.com/documentation/mysql/bychapter/>MySQL Dokumentation (in Englisch)</a>
<li><a href=http://php.weblogs.com/ADODB>ADODB (in Englisch)</a>
<li><a href=http://turck-mmcache.sourceforge.net/>Turck MMCache für PHP (in Englisch)</a>
<li><a href=http://www.ros.co.nz/pdf/readme.pdf>pdf class Dokumentation</a>
</ul>";

$TEXT['manuals-text2']="Und hier noch eine kleine Auswahl an deutschsprachigen Anleitungen und die zentrale Dokumentations-Seite von Apache Friends:";

$TEXT['manuals-list2']="
<ul>
<li><a href=http://www.apachefriends.org/faq.html>Apache Friends Dokumentation</a>
<li><a href=http://www.schattenbaum.net/php/>PHP für Dich</a> (incl. MySQL-Einführung) von Claudia Schaffarik
<li><a href=http://selfhtml.teamone.de/>SELFHTML</a> von Stefan Münz
<li><a href=http://cgi.de2.info/>CGI Einführung</a> von Stephan Muller
</ul>";

$TEXT['manuals-text3']="Viel Spaß und Erfolg beim Lesen! :)";

// ---------------------------------------------------------------------
// COMPONENTS
// ---------------------------------------------------------------------

$TEXT['components-head']="XAMPP-Komponenten";

$TEXT['components-text1']="XAMPP verbindet viele unterschiedliche Pakete in einem Paket. Hier ist eine Übersicht aller enthaltenen Pakete.";

$TEXT['components-text2']="Vielen Dank an die unzähligen Autoren dieser Programme.";

$TEXT['components-text3']="Im Verzeichnis <b>\\xampp\licenses</b> befinden sich die einzelnen Lizenz-Texte dieser Pakete.";

// ---------------------------------------------------------------------
// CD COLLECTION DEMO
// ---------------------------------------------------------------------

$TEXT['cds-head']="CD-Verwaltung (Beispiel für PHP+MySQL+PDF Class)";

$TEXT['cds-text1']="Eine sehr einfach CD-Verwaltung. Da man Eintäge nicht mehr verbessern kann, wenn man sich mal vertippt hat, empfiehlt sich phpMyAdmin (unten links in der Navigation).";

$TEXT['cds-text2']="<b>Neu seit 0.9.6:</b> Ausgabe der eingestellten CDs als <a href='$PHP_SELF?action=getpdf'>PDF-Dokument</a>.";

$TEXT['cds-error']="Kann die Datenbank nicht erreichen!<br>Läuft MySQL oder wurde das Passwort geändert?";
$TEXT['cds-head1']="Meine CDs";
$TEXT['cds-attrib1']="Interpret";
$TEXT['cds-attrib2']="Titel";
$TEXT['cds-attrib3']="Jahr";
$TEXT['cds-attrib4']="Aktion";
$TEXT['cds-sure']="Wirklich sicher?";
$TEXT['cds-head2']="CD hinzufügen";
$TEXT['cds-button1']="CD LÖSCHEN";
$TEXT['cds-button2']="CD HINZUFÜGEN";

// ---------------------------------------------------------------------
// BIORHYTHM DEMO
// ---------------------------------------------------------------------

$TEXT['bio-head']="Biorhythm (mit PHP+GD)";
$TEXT['bio-head']="Biorhythmus (Beispiel für PHP+GD)";

$TEXT['bio-by']="von";
$TEXT['bio-ask']="Bitte gib dein Geburtsdatum ein";
$TEXT['bio-ok']="OK";
$TEXT['bio-error1']="Das Datum";
$TEXT['bio-error2']="ist ungültig";

$TEXT['bio-birthday']="Geburtstag";
$TEXT['bio-today']="Heute";
$TEXT['bio-intellectual']="Intelligenz";
$TEXT['bio-emotional']="Emotion";
$TEXT['bio-physical']="Körper";

// ---------------------------------------------------------------------
// INSTANT ART DEMO
// ---------------------------------------------------------------------

$TEXT['iart-head']="Instant Art (Beispiel für PHP+GD+FreeType)";
$TEXT['iart-text1']="Font »AnkeCalligraph« von <a class=blue target=extern href=\"http://www.anke-art.de/\">Anke Arnold</a>";
$TEXT['iart-ok']="OK";

// ---------------------------------------------------------------------
// FLASH ART DEMO
// ---------------------------------------------------------------------

$TEXT['flash-head']="Flash Art (Beispiel für PHP+MING)";
$TEXT['flash-text1']="Das MING Projekt für Windows wurde leider nicht weiterverfolgt und ist deshalb unvollständig.<br>Vgl. bitte <a class=blue target=extern href=\"http://ming.sourceforge.net/install.html/\">Ming - an SWF output library and PHP module</a>";
$TEXT['flash-ok']="OK";

// ---------------------------------------------------------------------
// PHONE BOOK DEMO
// ---------------------------------------------------------------------

$TEXT['phonebook-head']="Telefonbuch (Beispiel für PHP+SQLite)";

$TEXT['phonebook-text1']="Ein sehr einfaches Telefonbuch. Allerdings mit einer sehr aktuellen Technik:<br>SQLite, einer SQL-Datenbank ohne extra Server.";

$TEXT['phonebook-error']="Kann die Datenbank nicht öffnen!";
$TEXT['phonebook-head1']="Meine Telefonnummern";
$TEXT['phonebook-attrib1']="Nachname";
$TEXT['phonebook-attrib2']="Vorname";
$TEXT['phonebook-attrib3']="Telefonnummer";
$TEXT['phonebook-attrib4']="Aktion";
$TEXT['phonebook-sure']="Wirklich sicher?";
$TEXT['phonebook-head2']="Eintrag hinzufügen";
$TEXT['phonebook-button1']="LÖSCHEN";
$TEXT['phonebook-button2']="HINZUFÜGEN";

// ---------------------------------------------------------------------
// ABOUT
// ---------------------------------------------------------------------

$TEXT['about-head']="Über XAMPP";

$TEXT['about-subhead1']="Konzept und Umsetzung";

$TEXT['about-subhead2']="Design";

$TEXT['about-subhead3']="Mitwirkung";

$TEXT['about-subhead4']="Ansprechpartner";

// ---------------------------------------------------------------------
// CODE
// ---------------------------------------------------------------------

$TEXT['srccode-in']="Den Quellcode einblenden";

// ---------------------------------------------------------------------
// MERCURY
// ---------------------------------------------------------------------

$TEXT['mail-head']="Mailing mit Mercury Mail SMTP und POP3 Server";
$TEXT['mail-hinweise']="Einige wichtige Hinweise zur Nutzung von Mercury findet ihr hier!";
$TEXT['mail-adress']="Adresse des Absenders:";
$TEXT['mail-adressat']="Adresse des Adressats:";
$TEXT['mail-cc']="CC:";
$TEXT['mail-subject']="Betreff:";
$TEXT['mail-message']="Nachricht:";
$TEXT['mail-sendnow']="Die Nachricht wird nun versendet ...";
$TEXT['mail-sendok']="Die Nachricht wurde erfolgreich versandt!";
$TEXT['mail-sendnotok']="Fehler! Die Nachricht konnte nicht versendet werden!";
$TEXT['mail-help1']="Hinweise für die Nutzung von Mercury:<br><br>";
$TEXT['mail-help2']="<UL>
	<LI>Mercury braucht beim Start eine Aussenbindung (DFÜ oder DSL);</LI>
	<LI>Beim start setzt Mercury seinen Domain Name Service (DNS) automatisch auf den Nameserver des Providers;</LI>
	<LI>Benutzer von Gateway-Servern sollten hingegen einen Domain Name Server via TCP/IP gesetzt haben (z.B. von T-Online mit der IP 194.25.2.129);</LI>
<LI>Die Config-Datei von Mercury lautet MERCURY.INI;</LI>
<LI>Lokal versandte E-Mails werden u.U. von manchen Providern abgelehnt (vorallem von T-Online und AOL). Der Grund: Diese Provider überprüfen den Mail Header bezüglich einer RELAY Option, um SPAM zu vermeiden;</LI>
<LI>lokal zum Testen eine E-Mail an die User postmaster@localhost und admin@localhost senden und den Eingang in den Verzeichnissen xampp.../mailserver/MAIL/postmaster und (...)/admin kontrollieren;</LI>
<LI>ein Test Benutzer heißt \"newuser\" (newuser@localhost) mit dem Passwort = wampp;</LI>
<LI>SPAM und andere Schweinereien sind mit Mercury total verboten!;</LI> 
</UL>";
$TEXT['mail-url']="<a href=\"http://www.pmail.com/overviews/ovw_mercury.htm\" target=\"_top\">http://www.pmail.com/overviews/ovw_mercury.htm</a>";
// ---------------------------------------------------------------------
// FileZilla FTP 
// ---------------------------------------------------------------------

$TEXT['filezilla-head']="FileZilla FTP Server";
$TEXT['filezilla-install']="Der Apache ist <U>kein</U> FTP Server ... aber FileZilla FTP ist einer. Bitte beachtet die folgenden Hinweise.";
$TEXT['filezilla-install2']="Einfach die Datei \"filezilla_setup.bat\" im Hauptverzeichnis des xampp starten, um den FTP Server einzurichten. Unter Windows NT, 2000 und XP Professional Betrienssystemen wird der Nutzer nun automatisch aufgefordert, FileZilla als Dienst zu installieren, damit der Server starten kann.";
$TEXT['filezilla-install3']="Nun könnt ihr \"FileZilla FTP\" konfigurieren. Nutzt dazu das FileZilla Interface namens \"FileZilla Server Interface.exe\" im FileZilla-Verzeichnis. Natürlich könnt ihr euch an der Beispielkonfiguration orientieren. Zwei Nutzer wurde in dem Beispiel angelegt:<br><br>
A: Ein Standardnutzer namens \"newuser\", Kennwort \"wampp\". Das Heimatverzeichnis ist xampp\htdocs.<br> 
B: Ein Anonymous User namens \"anonymous\", kein Kennwort. Das Heimatverzeichnis ist xampp\anonymous. Kann via Browser mit <A HREF=\"ftp://127.0.0.1\" target=\"_new\">ftp://127.0.0.1</A> angesprochen werden.<br><br>Der FileZilla ist hier erst einmal nur über die Loopback Adresse 127.0.0.1 gebunden, ihr könnt den zu nutzenden IP Addressbereich aber noch über das FileZilla Interface ändern.";
$TEXT['filezilla-install4']="Den FTP Server stoppen mit \"FileZillaFTP_stop.bat\". Wer den Server als Dienst starten möchte, sollte die Exekute-Datei mal mit Doppelklick auf \"FileZillaServer.exe\" starten. Dieser fragt dann nach den ganzen Startoptionen.";
$TEXT['filezilla-url']="<br><br><a href=\"http://filezilla.sourceforge.net\" target=\"_top\">http://filezilla.sourceforge.net</a>";

// ---------------------------------------------------------------------
// PEAR
// ---------------------------------------------------------------------

$TEXT['pear-head']="Excel Export mit PEAR (PHP)";
$TEXT['pear-text']="Ein kurzes <a class=blue target=extern href=\"http://www.contentmanager.de/magazin/artikel_310-print_excel_export_mit_pear.html\">Manual</A> machte freundlicher Weise Björn Schotte von <a class=blue target=extern href=\"http://www.thinkphp.de/\">ThinkPHP</A>";
$TEXT['pear-cell']="Der Inhalt einer Excel Zelle";

// ---------------------------------------------------------------------
// JPGRAPH
// ---------------------------------------------------------------------

$TEXT['jpgraph-head']="JpGraph - Grafik Bibliotheken für PHP";
$TEXT['jpgraph-url']="<br><br><a href=\"http://www.aditus.nu/jpgraph/\" target=\"_top\">http://www.aditus.nu/jpgraph/</a>";

// ---------------------------------------------------------------------
// ADODB
// ---------------------------------------------------------------------

$TEXT['ADOdb-head']="ADOdb - Der andere Datenbank-Zugriff (PHP)";
$TEXT['ADOdb-text']="ADOdb steht für Active Data Objects Data Base und unterstützt MySQL, PostgreSQL, Interbase, Firebird, Informix, Oracle, MS SQL 7, Foxpro, Access, ADO, Sybase, FrontBase, DB2, SAP DB, SQLite sowie ODBC. Die Sybase, Informix, FrontBase und PostgreSQL Treiber sind Gemeinschaftsbeiträge. Ihr findet es hier unter \(mini)xampp\php\pear\adodb.";
$TEXT['ADOdb-example']="Das Beispiel:";
$TEXT['ADOdb-dbserver']="Datenbankserver (MySQL, Oracle ..?)";
$TEXT['ADOdb-host']="Host des DB-Servers (Name oder IP)";
$TEXT['ADOdb-user']="Name des zugriffsberechtigten Nutzers";
$TEXT['ADOdb-password']="Passwort des zugriffsberechtigten Nutzers";
$TEXT['ADOdb-database']="Datenbank auf dem Datenbankserver";
$TEXT['ADOdb-table']="Tabelle dieser Datenbank";
$TEXT['ADOdb-nottable']="<p><B>Tabelle nicht gefunden!</B>";
$TEXT['ADOdb-notdbserver']="<p><B>Der Treiber für diesen Datenbankserver existiert nicht oder es handelt es ich um ein ODBC, ADO oder OLEDB Treiber!</B>";

// ---------------------------------------------------------------------
// INFO
// ---------------------------------------------------------------------

$TEXT['info-package']="Packet";
$TEXT['info-pages']="Seiten";
$TEXT['info-extension']="Endungen";
$TEXT['info-module']="Apache Modul";
$TEXT['info-description']="Beschreibung";
$TEXT['info-signature']="Signatur";
$TEXT['info-docdir']="Dokumentverzeichnis";
$TEXT['info-port']="Standard Port";
$TEXT['info-service']="Dienste";
$TEXT['info-examples']="Beispiele";
$TEXT['info-conf']="Konfigurationsdateien";
$TEXT['info-requires']="Braucht";
$TEXT['info-alternative']="Alternativ";
$TEXT['info-tomcatwarn']="Warnung! Tomcat ist nicht auf Port 8080 gestartet.";
$TEXT['info-tomcatok']="OK! Der Tomcat ist auf Port 8080 erfolgreich gestartet.";
$TEXT['info-tryjava']="Das Java Beispiel (JSP) über Apache MOD_JK.";
$TEXT['info-nococoon']="Warnung! Tomcat ist nicht auf Port 8080 gestartet. So kann ich nicht \"Cocoon\" installieren!";
$TEXT['info-okcocoon']="Ok! Der Tomcat ist hochgefahren. Die Installation kann ein paar Minuten dauern. Zum installieren von \"Cocoon\" klicke nun hier ...";

// ---------------------------------------------------------------------
// PHP Switch
// ---------------------------------------------------------------------

$TEXT['switch-head']="PHP Switch 1.0 win32 für XAMPP";
$TEXT['switch-phpversion']="<i><b>Aktuell in diesem XAMPP ist ";
$TEXT['switch-whatis']="<B>Was macht eigentlich der PHP Switch?</B><br>Der ApacheFriends PHP Switch für den XAMPP wechselt zwischen der PHP Version 4 zu der Version 5 UND zurück. Damit kannst du deine Skripte mit PHP 4 oder PHP 5 testen.<p>";
$TEXT['switch-find']="<B>Wo ist der PHP Switch?</B><br>PHP Switch für den XAMPP ist eine PHP Datei im XAMPP install Ordner mit dem Namen \"php-switch.php\" ausführt. Ausgeführt wird der Wechsel mit dem Batchfile ";
$TEXT['switch-care']="<B>Was muss ich beachten?</B><br>PHP Switch weigert sich den Wechsel vorzunehmen, wenn a) der Apache noch läuft und b) \".phpversion\" Datei im install Ordner fehlt oder fehlerhaft ist. In der \".phpversion\" steht die (Haupt) Nummer der gerade benutzen PHP Version. Also zu Beginn \"shutdown\" Apache und erst dann die  \"php-switch.bat\" ausführen.<p>";
$TEXT['switch-where4']="<B>Wo sind danach meine (alten) Konfigurationsdateien?</B><br><br>Für PHP 4:<br>";
$TEXT['switch-where5']="<br><br>Für PHP 5:<br>";
$TEXT['switch-make1']="<B>Werden denn Änderungen übernommen?</B><br><br>Ja! Für PHP4 oder PHP5 jeweils in der<br>";
$TEXT['switch-make2']="<br><br> .. gesichert bei PHP4 ...<br>";
$TEXT['switch-make3']="<br><br> .. gesichert bei PHP5 ...<br>";
$TEXT['switch-make4']="<br><br>Und auch wieder bei einem \"switch\" zurückgeführt!!<p>";
$TEXT['switch-not']="<B>Ich bin so zufrieden und möchte keinen \"Switch\" !!!</B><br>Super! Dann vergiß das ganze  hier ... ;-)<br>";

?>
