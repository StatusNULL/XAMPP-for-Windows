<?
// ---------------------------------------------------------------------
// GLOBAL
// ---------------------------------------------------------------------

$TEXT['global-xampp']="XAMPP voor Linux";
$TEXT['global-showcode']="Toon bron code";
$TEXT['global-sourcecode']="Bron code";

// ---------------------------------------------------------------------
// NAVIGATION
// ---------------------------------------------------------------------

$TEXT['navi-xampp']="XAMPP";
$TEXT['navi-welcome']="Welkom";
$TEXT['navi-status']="Status";
$TEXT['navi-security']="Beveiliging";
$TEXT['navi-doc']="Documentatie";
$TEXT['navi-components']="Componenten";
$TEXT['navi-about']="Over XAMPP";
$TEXT['navi-security']="Veiligheid";


$TEXT['navi-demos']="Demos";
$TEXT['navi-cdcol']="CD Collectie";
$TEXT['navi-bio']="Bioritme";
$TEXT['navi-guest']="Gasten Boek";
$TEXT['navi-iart']="Instant Art";
$TEXT['navi-iart2']="Flash Art";
$TEXT['navi-phonebook']="Telefoon Boek";
$TEXT['navi-perlasp']="Perl:ASP";
$TEXT['navi-pear']="PEAR:Excel_Writer";
$TEXT['navi-adodb']="ADOdb";
$TEXT['navi-perl']="Perl";
$TEXT['navi-python']="Python";
$TEXT['navi-jsp']="Java";
$TEXT['navi-phpswitch']="PHP Switch";

$TEXT['navi-tools']="Tools";
$TEXT['navi-phpmyadmin']="phpMyAdmin";
$TEXT['navi-webalizer']="webalizer";
$TEXT['navi-phpsqliteadmin']="phpSQLiteAdmin";
$TEXT['navi-mercury']="Mercury Mail";
$TEXT['navi-filezilla']="FileZilla FTP";
$TEXT['navi-jpgraph']="JpGraph";

$TEXT['navi-specialguest']="Current Guest";
$TEXT['navi-guest1']="FCKeditor";

$TEXT['navi-languages']="Talen";
$TEXT['navi-english']="English";
$TEXT['navi-german']="Deutsch";
$TEXT['navi-french']="Francais";
$TEXT['navi-dutch']="Nederlands";
$TEXT['navi-spanish']="Spanish";

// ---------------------------------------------------------------------
// STATUS
// ---------------------------------------------------------------------

$TEXT['status-head']="XAMPP Status";
$TEXT['status-text1']="Deze bladzijde toont in een oogopslag alle informatie over wat draait en werkt en wat niet.";
$TEXT['status-text2']="Sommige veranderingen in de configuratie veroorzaken soms foutieve status meldingen.";

$TEXT['status-mysql']="MySQL database";
$TEXT['status-ssl']="HTTPS (SSL)";
$TEXT['status-php']="PHP";
$TEXT['status-perl']="Perl with mod_perl";
$TEXT['status-cgi']="Common Gateway Interface (CGI)";
$TEXT['status-ssi']="Server Side Includes (SSI)";
$TEXT['status-python']="Python with mod_python";
$TEXT['status-mmcache']="PHP extension »Turck MMCache«";
$TEXT['status-mmcache-url']="http://www.apachefriends.org/faq-wampp-en.html#mmcache";
$TEXT['status-smtp']="SMTP Service";
$TEXT['status-ftp']="FTP Service";
$TEXT['status-tomcat']="Tomcat Service";
$TEXT['status-named']="Domain Name Service (DNS)";
$TEXT['status-oci8']="PHP extension »OCI8/Oracle«";
$TEXT['status-oci8-url']="http://www.apachefriends.org/faq-lampp-en.html#oci8";


$TEXT['status-lookfaq']="lees de FAQ";
$TEXT['status-ok']="GEACTIVEERD";
$TEXT['status-nok']="GEDEACTIVEERD";

$TEXT['status-tab1']="Component";
$TEXT['status-tab2']="Status";
$TEXT['status-tab3']="Hint";

// ---------------------------------------------------------------------
// SECURITY
// ---------------------------------------------------------------------

$TEXT['security-head']="XAMPP beveiliging";
$TEXT['security-text1']="Deze bladzijde geeft een overzicht van de beveiligingsstatus van uw XAMPP installatie. (Ga verder met lezen na de tabel.) <I>Sorry, but no netherland translation for this section available, so switching to english.</I>";
$TEXT['security-text2']="The green marked points are secure; the red marked points are definitively unsecure and the yellow marked points couldn't be checked (for example because the sofware to check isn't running).<p>To fix the problems for mysql, phpmyadmin and the xampp directory simply use</B><p>=> <A HREF=xamppsecurity.php><B>http://localhost/xampp/xamppsecurity.php</B></A> <= &nbsp;&nbsp;[allowed only for localhost]<br>&nbsp;<br>&nbsp;<br>
Some other important notes:<UL>
	<LI>All these test are made ONLY for host \"localhost\" (127.0.0.1).</LI>
	<LI><I><B>For FileZilla FTP und Mercury Mail, you must fix all security problems by yourself! Sorry. </B></I></LI>
	<LI>If your computer is not online or blocked by a firewall, your servers are SECURE against outside attacks.</LI>
	<LI>If servers are not running, these servers are although SECURE!</LI></UL>";
$TEXT['security-text3']="<B>Please consider this: 
With more XAMPP security some examples will NOT execute error free. If you use PHP in \"safe mode\" for example some functions of this security frontend will not working anymore. Often even more security means less functionality at the same time.</B>";
$TEXT['security-text4']="The XAMPP default ports:";

$TEXT['security-ok']="SECURE";
$TEXT['security-nok']="UNSECURE";
$TEXT['security-noidea']="UNKNOWN";

$TEXT['security-tab1']="Subject";
$TEXT['security-tab2']="Status";

$TEXT['security-checkapache-nok']="These XAMPP pages are accessible by network for everyone";
$TEXT['security-checkapache-ok']="These XAMPP pages are no longer accessible by network for everyone";
$TEXT['security-checkapache-text']="Every XAMPP demo page you are right now looking at is accessible for everyone over network. Everyone who knows your IP address can see these pages.";

$TEXT['security-checkmysqlport-nok']="MySQL is accessible by the network";
$TEXT['security-checkmysqlport-ok']="MySQL is no longer accessible over the network";
$TEXT['security-checkmysqlport-text']="This is a potential or at least theoretical security leak. And if you're mad about security you should disable the network interface of MySQL.";

$TEXT['security-checkpmamysqluser-nok']="The phpMyAdmin user pma has no password";
$TEXT['security-checkpmamysqluser-ok']="The phpMyAdmin user pma has no longer no password";
$TEXT['security-checkpmamysqluser-text']="phpMyAdmin saves your preferences in an extra MySQL database. To access this data phpMyAdmin uses the special user pma. This user has in the default installation no password set and to avoid any security problems you should give him a passwort.";

$TEXT['security-checkmysql-nok']="The MySQL admin user root has NO password";
$TEXT['security-checkmysql-ok']="The MySQL admin user root has no longer no password";
$TEXT['security-checkmysql-text']="Every local user on Linux box can access your MySQL database with administrator rights. You should set a password.";

$TEXT['security-pop-nok']="The test user (newuser) for Mercury Mail server (POP3) have an old password (wampp)";
$TEXT['security-pop-ok']="The test user \"newuser\" for the POP3 server (Mercury Mail?) does not exists anymore or have a new password";
$TEXT['security-pop-out']="A POP3 server like Mercury Mail is not running or is blocked by a firewall!";
$TEXT['security-pop-notload']="<I>The necessary IMAP extension for this secure test is not loading (php.ini)!</I><br>";
$TEXT['security-pop-text']="Please check and perhaps edit all users and passwords in the the Mercury Mail server configuration!";

$TEXT['security-checkftppassword-nok']="The FileZilla FTP password is still 'wampp'";
$TEXT['security-checkftppassword-ok']="The FileZilla FTP password was changed";
$TEXT['security-checkftppassword-out']="A FTP server is not running  or is blocked by a firewall!";
$TEXT['security-checkftppassword-text']="If the FileZilla FTP server was started, the default user 'newuser' with password 'wampp' can upload and change files for your XAMPP webserver. So if you enabled FileZilla FTP you should set a new password for user 'newuser'.";

$TEXT['security-phpmyadmin-nok']="PhpMyAdmin is free accessible by network";
$TEXT['security-phpmyadmin-ok']="PhpMyAdmin password login is enabled.";
$TEXT['security-phpmyadmin-out']="PhpMyAdmin: Could not find the 'config.inc.php' ...";
$TEXT['security-phpmyadmin-text']="PhpMyAdmin is accessible by network without password. The configuration 'httpd' or 'cookie' in the \"config.inc.php\" can help.";

$TEXT['security-checkphp-nok']="PHP is NOT running in \"safe mode\"";
$TEXT['security-checkphp-ok']="PHP is running in \"safe mode\"";
$TEXT['security-checkphp-out']="Unable to control the setting of PHP!";
$TEXT['security-checkphp-text']="If do you want to offer PHP executions for outside persons, please think about a \"safe mode\" configuration. But for standalone developer we recommend NOT the \"safe mode\" configuration because some important functions will not working then. <A HREF=\"http://www.php.net/features.safe-mode\" target=\"_new\"><font size=1>More Info</font></A>";

// ---------------------------------------------------------------------
// SECURITY SETUP
// ---------------------------------------------------------------------

$TEXT['mysql-security-head']="Security console MySQL & XAMPP directory protection";
$TEXT['mysql-rootsetup-head']="MYSQL SECTION: \"ROOT\" PASSWORD";
$TEXT['mysql-rootsetup-text1']="";
$TEXT['mysql-rootsetup-notrunning']="The MySQL server is not running or is blocked by a firewall! Please check this problem first ...";
$TEXT['mysql-rootsetup-passwdnotok']="The new password is identical with the repeat password. Please enter both passwords for new!";
$TEXT['mysql-rootsetup-passwdnull']="Zero passwords ('') will not accepted!";
$TEXT['mysql-rootsetup-passwdsuccess']="SUCCESS: The password for the SuperUser 'root' was set or updated!
But note: The initialization of the new password for \"root\" needs a RESTART OF MYSQL !!!! The data with the new password was safed in the following file:";
$TEXT['mysql-rootsetup-passwdnosuccess']="ERROR: The root password is perhaps wrong. MySQL decline the login with these current root password.";
$TEXT['mysql-rootsetup-passwdold']="Current passwort:";
$TEXT['mysql-rootsetup-passwd']="New password:";
$TEXT['mysql-rootsetup-passwdrepeat']="Repeat the new password:";
$TEXT['mysql-rootsetup-passwdchange']="Password changing";
$TEXT['mysql-rootsetup-phpmyadmin']="PhpMyAdmin authentification:";

$TEXT['xampp-setup-head']="XAMPP DIRECTORY PROTECTION (.htaccess)";
$TEXT['xampp-setup-user']="User:";
$TEXT['xampp-setup-passwd']="Password:";
$TEXT['xampp-setup-start']="Make safe the XAMPP directory";
$TEXT['xampp-setup-notok']="<br><br>ERROR: The string for the user name and password must have at least three  characters and not more then 15 characters. Special characters like <öäü (usw.) and empty characters are not allowed!<br><br>";
$TEXT['xampp-config-ok']="<br><br>SUCCESS: The XAMPP directory is protected now! All personal data was safed in the following file:<br>";
$TEXT['xampp-config-notok']="<br><br>ERROR: Your system could NOT activate the directory protection with the \".htaccess\" and the \"htpasswd.exe\". Perhaps PHP is in the \"Safe Mode\".<br><br>";


// ---------------------------------------------------------------------
// START
// ---------------------------------------------------------------------

$TEXT['start-head']="Welkom bij XAMPP voor Linux";

$TEXT['start-subhead']="Gefeliciteerd:<br>U hebt XAMPP succesvol op dit systeem geinstalleerd!";

$TEXT['start-text1']="Nu kunt u beginnen met het gebruiken van Apache and Co. Als eerste kunt u  »Status« proberen op de linker navigatie-balk Om er zeker van te zijn dat alles goed werkt.";

$TEXT['start-text2']="Na het testen kunt u de voorbeelden onder de test link bekijken.";

$TEXT['start-text3']="Als u wilt beginnen met programmeren in PHP or Perl (of wat dan ook) kijk dan eerst in de <a target=extern href=http://www.apachefriends.org/lampp-en.html>XAMPP handleiding</a> en doe daar meer informatie op over uw XAMPP installatie.";

$TEXT['start-text4']="Succes,<br>Kay Vogelgesang + Kai 'Oswald' Seidler";

// ---------------------------------------------------------------------
// MANUALS
// ---------------------------------------------------------------------

$TEXT['manuals-head']="Online documentatie";

$TEXT['manuals-text1']="XAMPP combineeert veel verschillende sofware pakketten in een pakket. hier is een lijst van de standaard en referentie documentatie van de meest belangrijke pakketten.";


$TEXT['manuals-list1']="
<ul>
<li><a href=http://httpd.apache.org/docs-2.0/>Apache 2 documentatie</a>
<li><a href=http://www.php.net/manual/en/>PHP <b>referenz </b>documentatie</a>
<li><a href=http://www.perldoc.com/perl5.8.0/pod/perl.html>Perl documentatie</a>
<li><a href=http://www.mysql.com/documentation/mysql/bychapter/>MySQL documentatie</a>
<li><a href=http://proftpd.linux.co.uk/localsite/Userguide/linked/userguide.html>ProFTPD gebruikershandleiding</a>
<li><a href=http://www.ros.co.nz/pdf/readme.pdf>pdf class documentatie</a>
</ul>";

$TEXT['manuals-text2']="En een lijstje van tutorials en de Apache Friends documentatie pagina:";

$TEXT['manuals-list2']="
<ul>
<li><a href=http://www.apachefriends.org/faq-en.html>Apache Friends documentation</a>
<li><a href=http://www.freewebmasterhelp.com/tutorials/php>PHP Tutorial</a> by David Gowans
<li><a href=http://www.davesite.com/webstation/html/>HTML - An Interactive Tutorial For Beginners</a> by Dave Kristula
<li><a href=http://www.comp.leeds.ac.uk/Perl/start.html>Perl Tutorial</a> by Nik Silver
</ul>";

$TEXT['manuals-text3']="Good luck and have fun! :)";

// ---------------------------------------------------------------------
// COMPONENTS
// ---------------------------------------------------------------------

$TEXT['components-head']="XAMPP componenten";

$TEXT['components-text1']="XAMPP combineert veel verschillende sofware pakketten in een pakket. Hier is een overzicht van alle pakketten.";

$TEXT['components-text2']="Heel veel dank aan de ontwikkelaars van deze programma's.";

$TEXT['components-text3']="In de directory <b>/opt/lampp/licenses</b> vindt u alle licenties en README bestanden van deze programma's.";

// ---------------------------------------------------------------------
// CD COLLECTION DEMO
// ---------------------------------------------------------------------

$TEXT['cds-head']="CD Collectie (Voorbeeld tbv PHP+MySQL+PDF Class)";

$TEXT['cds-text1']="Een heel simpel CD programma.";

$TEXT['cds-text2']="CD lijst als <a href='$PHP_SELF?action=getpdf'>PDF document</a>.";

$TEXT['cds-error']="Kon niet verbinden met de database!<br>Draait MySQL, of hebt u het wachtwoord veranderd?";
$TEXT['cds-head1']="Mijn CDs";
$TEXT['cds-attrib1']="Artiest";
$TEXT['cds-attrib2']="Titel";
$TEXT['cds-attrib3']="Jaar";
$TEXT['cds-attrib4']="Opdracht";
$TEXT['cds-sure']="Zeker?";
$TEXT['cds-head2']="Voeg CD toe";
$TEXT['cds-button1']="Verwijder CD";
$TEXT['cds-button2']="Voeg toe CD";

// ---------------------------------------------------------------------
// BIORHYTHM DEMO
// ---------------------------------------------------------------------

$TEXT['bio-head']="Bioritme (Voorbeeld tbv PHP+GD)";

$TEXT['bio-by']="by";
$TEXT['bio-ask']="Vul de geboortedatum in";
$TEXT['bio-ok']="OK";
$TEXT['bio-error1']="Datum";
$TEXT['bio-error2']="is ongeldig";

$TEXT['bio-birthday']="Geboortedatum";
$TEXT['bio-today']="Vandaag";
$TEXT['bio-intellectual']="Intellectueel";
$TEXT['bio-emotional']="Emotioneel";
$TEXT['bio-physical']="Physiek";

// ---------------------------------------------------------------------
// INSTANT ART DEMO
// ---------------------------------------------------------------------

$TEXT['iart-head']="Instant Art (Voorbeeld tbv PHP+GD+FreeType)";
$TEXT['iart-text1']="Font »AnkeCalligraph« by <a class=blue target=extern href=\"http://www.anke-art.de/\">Anke Arnold</a>";
$TEXT['iart-ok']="OK";

// ---------------------------------------------------------------------
// FLASH ART DEMO
// ---------------------------------------------------------------------

$TEXT['flash-head']="Flash Art (Voorbeeld tbv PHP+MING)";
$TEXT['flash-text1']="Font »AnkeCalligraph« by <a class=blue target=extern href=\"http://www.anke-art.de/\">Anke Arnold</a>";
$TEXT['flash-ok']="OK";

// ---------------------------------------------------------------------
// PHONE BOOK DEMO
// ---------------------------------------------------------------------

$TEXT['phonebook-head']="Telefoon Boek (Voorbeeld tbv PHP+SQLite)";

$TEXT['phonebook-text1']="Een erg simpel telefoonboek script. Maar geimplementeerd met een erg modern en up-to-date technologie: SQLite, de SQL database zonder server.";

$TEXT['phonebook-error']="Kon de database niet openen!";
$TEXT['phonebook-head1']="Mijn telefoonnummers";
$TEXT['phonebook-attrib1']="Achternaam";
$TEXT['phonebook-attrib2']="Voornaam";
$TEXT['phonebook-attrib3']="Telefoonnummer";
$TEXT['phonebook-attrib4']="Opdracht";
$TEXT['phonebook-sure']="Zeker?";
$TEXT['phonebook-head2']="Voeg entry toe";
$TEXT['phonebook-button1']="Verwijder";
$TEXT['phonebook-button2']="Voeg toe";

// ---------------------------------------------------------------------
// ABOUT
// ---------------------------------------------------------------------

$TEXT['about-head']="Over XAMPP";
$TEXT['about-subhead1']="Idee en realisatie";
$TEXT['about-subhead2']="Ontwerp";
$TEXT['about-subhead3']="Collaboration";
$TEXT['about-subhead4']="Contact personen";


// ONLY ENGLISH LANGUAGE SECTION

// ---------------------------------------------------------------------
// CODE
// ---------------------------------------------------------------------

$TEXT['srccode-in']="Get the source here";

// ---------------------------------------------------------------------
// MERCURY
// ---------------------------------------------------------------------

$TEXT['mail-head']="Mailing with Mercury Mail SMTP and POP3 Server";
$TEXT['mail-hinweise']="Some important notes for using Mercury!";
$TEXT['mail-adress']="Sender:";
$TEXT['mail-adressat']="Recipient:";
$TEXT['mail-cc']="CC:";
$TEXT['mail-subject']="Subject:";
$TEXT['mail-message']="Message:";
$TEXT['mail-sendnow']="This message is sending now ...";
$TEXT['mail-sendok']="The message was successfully sent!";
$TEXT['mail-sendnotok']="Error! The message was not successfully sent!";
$TEXT['mail-help1']="Notes for using Mercury:<br><br>";
$TEXT['mail-help2']="<UL>
<LI>Mercury needs an external connection on startup;</LI>
<LI>on startup, Mercury defines the Domain Name Service (DNS) automatically as the name server of your provider;</LI>
<LI>For all user of gateway servers: Please set your DNS via TCP/IP (f.e. via InterNic with the IP number 198.41.0.4);</LI>
<LI>the config file of Mercury is called MERCURY.INI;</LI>
<LI>to test, please send a message to postmaster@localhost or admin@localhost and check for these messages in the following folders: xampp.../mailserver/MAIL/postmaster or (...)/admin;</LI>
<LI>one test user called \"newuser\" (newuser@localhost) with the Password = wampp;</LI>
<LI>spam and other obscenities are totally forbidden with Mercury!;</LI> 
</UL>";
$TEXT['mail-url']="<a href=\"http://www.pmail.com/overviews/ovw_mercury.htm\" target=\"_top\">http://www.pmail.com/overviews/ovw_mercury.htm</a>";
// ---------------------------------------------------------------------
// FileZilla FTP 
// ---------------------------------------------------------------------

$TEXT['filezilla-head']="FileZilla FTP Server";
$TEXT['filezilla-install']="Apache is <U>not</U> a FTP Server ... but FileZilla FTP is one. Please consider the following references.";
$TEXT['filezilla-install2']="Into the main directory of xampp, start \"filezilla_setup.bat\" for setup. Attention: For Windows NT, 2000 and XP Professional, FileZilla needs to install as service.";
$TEXT['filezilla-install3']="Configure \"FileZilla FTP\". For this, please use the FileZilla Interface with the \"FileZilla Server Interface.exe\". Two Users are in this example:<br><br>
A: A default user \"newuser\", password \"wampp\". The home directory is xampp\htdocs.<br> 
B: An anonymous user \"anonymous\", no password. The home directory is xampp\anonymous.<br><br>
The default interface is the loopback address 127.0.0.1.";
$TEXT['filezilla-install4']="The FTP Server is shutdown with the \"FileZillaFTP_stop.bat\". For FileZilla FTP as service, please use the \"FileZillaServer.exe\" directly. Then, you can configure all start options.";
$TEXT['filezilla-url']="<br><br><a href=\"http://filezilla.sourceforge.net\" target=\"_top\">http://filezilla.sourceforge.net</a>";

// ---------------------------------------------------------------------
// PEAR
// ---------------------------------------------------------------------

$TEXT['pear-head']="Excel export with PEAR (PHP)";
$TEXT['pear-text']="A short <a class=blue target=extern href=\"http://www.contentmanager.de/magazin/artikel_310-print_excel_export_mit_pear.html\">Manual</A> from Björn Schotte of <a class=blue target=extern href=\"http://www.thinkphp.de/\">ThinkPHP</A> (only in german)";
$TEXT['pear-cell']="The value of a cell";

// ---------------------------------------------------------------------
// JPGRAPH
// ---------------------------------------------------------------------

$TEXT['jpgraph-head']="JpGraph - Graph Library for PHP";
$TEXT['jpgraph-url']="<br><br><a href=\"http://www.aditus.nu/jpgraph/\" target=\"_top\">http://www.aditus.nu/jpgraph/</a>";

// ---------------------------------------------------------------------
// ADODB
// ---------------------------------------------------------------------

$TEXT['ADOdb-head']="ADOdb - Another DB access (PHP)";
$TEXT['ADOdb-text']="ADOdb stands for Active Data Objects Data Base. We currently support MySQL, PostgreSQL, Interbase, Firebird, Informix, Oracle, MS SQL 7, Foxpro, Access, ADO, Sybase, FrontBase, DB2, SAP DB, SQLite and generic ODBC. The Sybase, Informix, FrontBase and PostgreSQL drivers are community contributions. You find it here at \(mini)xampp\php\pear\adodb.";
$TEXT['ADOdb-example']="The example:";
$TEXT['ADOdb-dbserver']="Database server (MySQL, Oracle ..?)";
$TEXT['ADOdb-host']="Host of the DB server (name or IP)";
$TEXT['ADOdb-user']="Username ";
$TEXT['ADOdb-password']="Password";
$TEXT['ADOdb-database']="Current database on this database server";
$TEXT['ADOdb-table']="Selected table of database";
$TEXT['ADOdb-nottable']="<p><B>Table not found!</B>";
$TEXT['ADOdb-notdbserver']="<p><B>The driver for this database server does not exists or perhaps it is an ODBC, ADO or OLEDB driver!</B>";


// ---------------------------------------------------------------------
// INFO
// ---------------------------------------------------------------------

$TEXT['info-package']="Package";
$TEXT['info-pages']="Pages";
$TEXT['info-extension']="Extensions";
$TEXT['info-module']="Apache module";
$TEXT['info-description']="Description";
$TEXT['info-signature']="Signature";
$TEXT['info-docdir']="Document root";
$TEXT['info-port']="Default port";
$TEXT['info-service']="Services";
$TEXT['info-examples']="Examples";
$TEXT['info-conf']="Configuration files";
$TEXT['info-requires']="Requires";
$TEXT['info-alternative']="Alternative";
$TEXT['info-tomcatwarn']="Warning! Tomcat is not started on port 8080.";
$TEXT['info-tomcatok']="OK! Tomcat is started on port 8080 successfully.";
$TEXT['info-tryjava']="The java example (JSP) with Apache MOD_JK.";
$TEXT['info-nococoon']="Warning! Tomcat is not started on port 8080. Cannot install
\"Cocoon\" without running Tomcat server!";
$TEXT['info-okcocoon']="Ok! The Tomcat is running normaly. The installation works can last some minutes! To install \"Cocoon\" now click here ...";

// ---------------------------------------------------------------------
// PHP Switch
// ---------------------------------------------------------------------

$TEXT['switch-head']="PHP Switch 1.0 win32 for XAMPP";
$TEXT['switch-phpversion']="<i><b>Current in THIS XAMPP is ";
$TEXT['switch-whatis']="<B>What make the PHP switch?</B><br>The apachefriends PHP Switch for XAMPP switching between the PHP version 4 to version 5 AND (!) back. So you can test your scripts with PHP 4 or PHP 5.<p>";
$TEXT['switch-find']="<B>Where is the PHP Switch?</B><br>PHP Switch for XAMPP will execute a PHP file (XAMPP install folder) with the name \"php-switch.php\". You should use this batch file for executing: ";
$TEXT['switch-care']="<B>What can be difficult?</B><br>PHP Switch will not change your PHP version, when a) the Apache HTTPD is running or/and b) the \".phpversion\" file in the install folder is vacant or have a bug. In the \".phpversion\", there was written the XAMPP current main PHP version number like \"4\" or \"5\". Please beginn with a \"shutdown\" for the Apache HTTPD and THEN execute the  \"php-switch.bat\".<p>";
$TEXT['switch-where4']="<B>After That! Where are my (old) config files?</B><br><br>For PHP 4:<br>";
$TEXT['switch-where5']="<br><br>For PHP 5:<br>";
$TEXT['switch-make1']="<B>What is with changes in my config files?</B><br><br>There lives! For PHP4 or PHP5 in the<br>";
$TEXT['switch-make2']="<br><br> .. secured for PHP4 ...<br>";
$TEXT['switch-make3']="<br><br> .. secured for PHP5 ...<br>";
$TEXT['switch-make4']="<br><br>And these files are going back with the PHP switching!!<p>";
$TEXT['switch-not']="<B>My PHP is okay AND i will NOT a \"switch\" !!!</B><br>Super! Then forget this here ... ;-)<br>";

// ---------------------------------------------------------------------
// Cocoon
// ---------------------------------------------------------------------

$TEXT['go-cocoon']="Cocoon now with http://localhost/cocoon/";
$TEXT['path-cocoon']="And the correct folder on your disk is: ...\\xampp\\tomcat\\webapps\\cocoon";

// ---------------------------------------------------------------------
// Guest
// ---------------------------------------------------------------------

$TEXT['guest1-name']="Current Guest in this release: <i>FCKeditor</i>";
$TEXT['guest1-text1']="A very nice HMTL ONLINE editor with much more JavaScript. Optimized for the IE. But do not function with the Mozilla FireFox.";
$TEXT['guest1-text2']="FCKeditor Homepage: <a href=\"http://www.fckeditor.net\" target=\"_new\">www.fckeditor.net</a>. Note: The Arial font do NOT function here, but i do not know why!"; 
$TEXT['guest1-text3']="<a href=\"guest-FCKeditor/fckedit-dynpage.php\" target=\"_new\">The example page written with the FCKeditor.</A>"; 


?>
