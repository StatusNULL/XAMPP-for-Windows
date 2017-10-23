<?
// ---------------------------------------------------------------------
// GLOBAL
// ---------------------------------------------------------------------

$TEXT['global-xampp']="XAMPP for Windows";

// ---------------------------------------------------------------------
// NAVIGATION
// ---------------------------------------------------------------------

$TEXT['navi-xampp']="XAMPP 1.4.5";
$TEXT['navi-welcome']="Witaj";
$TEXT['navi-status']="Status";
$TEXT['navi-security']="Bezpieczeństwo";
$TEXT['navi-doc']="Dokumentacja";
$TEXT['navi-components']="Komponenty";
$TEXT['navi-about']="O XAMPPie";

$TEXT['navi-demos']="Dema";
$TEXT['navi-cdcol']="Kolekcja Płyt CD";
$TEXT['navi-bio']="Biorytmy";
$TEXT['navi-guest']="Księga Go?ci";
$TEXT['navi-perlenv']="MiniPerl";
$TEXT['navi-iart']="Błyskawiczna Grafika";
$TEXT['navi-iart2']="Grafika Flash";
$TEXT['navi-phonebook']="Księga Telefoniczna";
$TEXT['navi-perlasp']="Perl:ASP";
$TEXT['navi-pear']="PEAR:Excel_Writer";
$TEXT['navi-adodb']="ADOdb";
$TEXT['navi-perl']="Perl";
$TEXT['navi-python']="Python";
$TEXT['navi-jsp']="Java";
$TEXT['navi-phpswitch']="PHP Switch";

$TEXT['navi-tools']="Narzędzia";
$TEXT['navi-phpmyadmin']="phpMyAdmin";
$TEXT['navi-webalizer']="Webalizer";
$TEXT['navi-mercury']="Mercury Mail";
$TEXT['navi-filezilla']="FileZilla FTP";
$TEXT['navi-jpgraph']="JpGraph";

$TEXT['navi-specialguest']="Current Guest";
$TEXT['navi-guest1']="FCKeditor";

$TEXT['navi-languages']="Języki";
$TEXT['navi-english']="Angielski";
$TEXT['navi-german']="Niemiecki";
$TEXT['navi-french']="Francais";
$TEXT['navi-dutch']="Nederlands";
$TEXT['navi-spanish']="Spanish";
$TEXT['navi-polish']="Polski";
$TEXT['navi-spanish']="Espa�ol";
$TEXT['navi-norwegian']="Norsk";
$TEXT['navi-italian']="Italiano";
$TEXT['navi-chinese']="&#20013;&#25991;";

// ---------------------------------------------------------------------
// STATUS
// ---------------------------------------------------------------------

$TEXT['status-head']="XAMPP Status";
$TEXT['status-text1']="Ta strona pokazuje co obecnie działa a co nie.";
$TEXT['status-text2']="Niektóre zmiany w konfiguracji mog dawać fałszywy negatywny efekt. Przy SSL (https://localhost) raporty te nie działaj!";

$TEXT['status-mysql']="Baza danych MySQL";
$TEXT['status-ssl']="HTTPS (SSL)";
$TEXT['status-php']="PHP";
$TEXT['status-perl']="Perl z mod_perl";
$TEXT['status-cgi']="Common Gateway Interface (CGI)";
$TEXT['status-ssi']="Server Side Includes (SSI)";
$TEXT['status-python']="Python z mod_python";
$TEXT['status-mmcache']="PHP rozszerzenie Turck MMCache";
$TEXT['status-mmcache-url']="http://www.apachefriends.org/faq-wampp-en.html#mmcache";
$TEXT['status-smtp']="SMTP Serwer";
$TEXT['status-ftp']="FTP Serwer";
$TEXT['status-tomcat']="Tomcat Service";
$TEXT['status-named']="Domain Name Service (DNS)";
$TEXT['status-oci8']="PHP rozszerzenie OCI8/Oracle";
$TEXT['status-oci8-url']="http://www.apachefriends.org/faq-lampp-en.html#oci8";

$TEXT['status-lookfaq']="zobacz FAQ";
$TEXT['status-ok']="WŁźCZONE";
$TEXT['status-nok']="WYŁźCZONE";

$TEXT['status-tab1']="Komponent";
$TEXT['status-tab2']="Status";
$TEXT['status-tab3']="Wskazówka";

// ---------------------------------------------------------------------
// SECURITY
// ---------------------------------------------------------------------

$TEXT['security-head']="Bezpieczeństwo XAMPPa";
$TEXT['security-text1']="Ta strona informuje o poziomie bezpieczeństwa XAMPPa (proszę czytać tekst pod tabel) <I>Sorry, no polish translation for this section available, so switching to english.</I>";
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
$TEXT['xampp-setup-notok']="<br><br>ERROR: The string for the user name and password must have at least three  characters and not more then 15 characters. Special characters like <��� (usw.) and empty characters are not allowed!<br><br>";
$TEXT['xampp-config-ok']="<br><br>SUCCESS: The XAMPP directory is protected now! All personal data was safed in the following file:<br>";
$TEXT['xampp-config-notok']="<br><br>ERROR: Your system could NOT activate the directory protection with the \".htaccess\" and the \"htpasswd.exe\". Perhaps PHP is in the \"Safe Mode\".<br><br>";

// ---------------------------------------------------------------------
// START
// ---------------------------------------------------------------------

$TEXT['start-head']="Witaj w XAMPP dla Windowsa";

$TEXT['start-subhead']="Gratulacje!<BR>XAMPP poprawinie zainstalowany.";

$TEXT['start-text1']="Możesz już korzystać z Apache i reszty jego kumpli. Zanim to zrobisz możesz sprawdzić co działa klikajc w link <B>Status</b> obok.";

$TEXT['start-text2']="Uwaga, XAMPP w wersji 1.4 jest przystosowany do zarzdzania pakietami. XAMPP posiada pakiety: <UL><LI>XAMPP pakiet bazowy</LI><LI>XAMPP Perl</LI><LI>XAMPP Python<LI></LI>XAMPP Utility addon (więcej narzędzi, lecz nieaktywnych)</LI><LI>XAMPP Server addon (więcej opcji serwerowych, lecz nieaktywnych)</LI><LI>XAMPP Inne dodatki (nieaktywne)</LI></UL>";

$TEXT['start-text3']="Dla normalnej inicjalizacji dodatku odpal 1 raz na 1 dodatek plik \"setup_xampp.bat\". Dla dodatków instalacyjnych musisz mieć instalacyjn wersję XAMPPa! W innych przypadkach XAMPP zip może być.";

$TEXT['start-text4']="Dla wsparcia OpenSSL proszę używać testu certyfikatu z <a href='https://127.0.0.1' target='_top'>https://127.0.0.1</a> lub <a href='https://localhost' target='_top'>https://localhost</a>";

$TEXT['start-text5']="I najważniejsze - podziękowania dla Carsten, Nemesis, KriS, Boppy, Pc-Dummy i wielu innym, którzy pomagaj rozwijać XAMPPa!<BR><BR>Polskie miniwsparcie w <a href=\"http://www.cms.rk.edu.pl\" target=\"_blank\">Bibliotece CMS Riklaunima</a>.";

$TEXT['start-text6']="Powodzenia, Kay Vogelgesang + Kai 'Oswald' Seidler";

// ---------------------------------------------------------------------
// MANUALS
// ---------------------------------------------------------------------

$TEXT['manuals-head']="Dokumentacja online";

$TEXT['manuals-text1']="XAMPP łczy ze sob wiele programów. Oto ich lista i odno?niki do dokumentacji.";


$TEXT['manuals-list1']="
<ul>
<li><a href=http://httpd.apache.org/docs-2.0/>Apache 2</a>
<li><a href=http://www.php.net/manual/pl/>PHP</a>
<li><a href=http://www.perldoc.com/perl5.8.0/pod/perl.html>Perl</a>
<li><a href=http://www.mysql.com/documentation/mysql/bychapter/>MySQL</a>
<li><a href=http://php.weblogs.com/ADODB>ADODB</a>
<li><a href=http://turck-mmcache.sourceforge.net/>Turck MMCache dla PHP</a>
<li><a href=http://www.ros.co.nz/pdf/readme.pdf>klasa pdf</a>
</ul>";

$TEXT['manuals-text2']="Oto mała lista tutoriali Apache i strona Apache Friends:";

$TEXT['manuals-list2']="
<ul>
<li><a href=http://www.apachefriends.org/faq-en.html>Strona Apache Friends</a>
<li><a href=http://www.freewebmasterhelp.com/tutorials/php>Tutorial PHP</a> autorstwa Davida Gowansa
<li><a href=http://www.davesite.com/webstation/html/>HTML - Tutorial dla pocztkujcych</a> by Dave Kristula
<li><a href=http://www.comp.leeds.ac.uk/Perl/start.html>Tutorial Perla</a> by Nik Silver
</ul>";

$TEXT['manuals-text3']="<LI><B>Strony Polskie</b><BR><LI><a href=http://www.cms.rk.edu.pl>Biblioteka CMS</a> - PHP, CMSy i nie tylko<LI><A href=http://www.polhost.net>polhostn.net</a> - PHP i Skrypty<LI><A href=http://www.post-nuke.pl>postnuke.pl</a> - Wsparcie postnuke<LI><a href=http://www.php.pl>php.pl</a> - Polska strona o PHP";

// ---------------------------------------------------------------------
// COMPONENTS
// ---------------------------------------------------------------------

$TEXT['components-head']="Komponenty XAMPPa";

$TEXT['components-text1']="XAMPP łczy ze sob wiele programów, oto ich lista.";

$TEXT['components-text2']="Wyrazy uznania dla twórców tych programów.";

$TEXT['components-text3']="W katalogu <b>\\xampp\licenses</b> znajdziesz licencje tych programów.";

// ---------------------------------------------------------------------
// CD COLLECTION DEMO
// ---------------------------------------------------------------------

$TEXT['cds-head']="Kolekcja płyt CD (Przykład klasy PHP+MySQL+PDF)";

$TEXT['cds-text1']="Prosty program CD.";

$TEXT['cds-text2']="Lista CD jako <a href='$PHP_SELF?action=getpdf'>Dokument PDF</a>.";

$TEXT['cds-error']="Nie można połczyć się z baz danych!<br>Czy MySQL chodzi, czy nie zmieniłe? hasła?";
$TEXT['cds-head1']="Moje CDs";
$TEXT['cds-attrib1']="Wykonawca";
$TEXT['cds-attrib2']="Tytuł";
$TEXT['cds-attrib3']="Rok";
$TEXT['cds-attrib4']="Komenda";
$TEXT['cds-sure']="Jeste? pewien?";
$TEXT['cds-head2']="Dodaj CD";
$TEXT['cds-button1']="Kasuj CD";
$TEXT['cds-button2']="Dodaj CD";

// ---------------------------------------------------------------------
// BIORHYTHM DEMO
// ---------------------------------------------------------------------

$TEXT['bio-head']="Biorytmy (przykład zastosowania PHP+GD)";

$TEXT['bio-by']="przez";
$TEXT['bio-ask']="Wprowad? datę urodzenia";
$TEXT['bio-ok']="OK";
$TEXT['bio-error1']="Data";
$TEXT['bio-error2']="jest błędna";

$TEXT['bio-birthday']="data urodzenia";
$TEXT['bio-today']="Dzi?";
$TEXT['bio-intellectual']="Intelekt";
$TEXT['bio-emotional']="Emocje";
$TEXT['bio-physical']="Kondycja";

// ---------------------------------------------------------------------
// INSTANT ART DEMO
// ---------------------------------------------------------------------

$TEXT['iart-head']="Błyskawiczna Grafika (Zastosowanie PHP+GD+FreeType)";
$TEXT['iart-text1']="Czcionka AnkeCalligraph autorstwa <a class=blue target=extern href=\"http://www.anke-art.de/\">Anke Arnold</a>";
$TEXT['iart-ok']="OK";

// ---------------------------------------------------------------------
// FLASH ART DEMO
// ---------------------------------------------------------------------

$TEXT['flash-head']="Grafika Flash (Zastosowanie PHP+MING)";
$TEXT['flash-text1']="MING dla Windows32 nie jest jeszcze gotowy.<br>Szczegóły: <a class=blue target=extern href=\"http://www.opaque.net/wiki/index.php?Ming\">Ming - an SWF output library and PHP module</a>";
$TEXT['flash-ok']="OK";

// ---------------------------------------------------------------------
// PHONE BOOK DEMO
// ---------------------------------------------------------------------

$TEXT['phonebook-head']="Księga telefonów (Przykład zastosowania PHP+SQLite)";

$TEXT['phonebook-text1']="Prosty skrypt, lecz wykorzystujcy najnowsze rozwizania.";

$TEXT['phonebook-error']="Nie można otworzyć bazy danych!";
$TEXT['phonebook-head1']="Moje numery telefonów";
$TEXT['phonebook-attrib1']="Nazwisko";
$TEXT['phonebook-attrib2']="Imię";
$TEXT['phonebook-attrib3']="Numer telefonu";
$TEXT['phonebook-attrib4']="Komenda";
$TEXT['phonebook-sure']="Jeste? pewien?";
$TEXT['phonebook-head2']="Dodaj wpis";
$TEXT['phonebook-button1']="Kasuj";
$TEXT['phonebook-button2']="Dodaj";

// ---------------------------------------------------------------------
// ABOUT
// ---------------------------------------------------------------------

$TEXT['about-head']="O XAMPPie";

$TEXT['about-subhead1']="Cele i założenia";

$TEXT['about-subhead2']="Szata graficzna";

$TEXT['about-subhead3']="Współpraca";

$TEXT['about-subhead4']="Kontakt";

// ---------------------------------------------------------------------
// CODE
// ---------------------------------------------------------------------

$TEXT['srccode-in']="Kod ?ródłowy tutaj";

// ---------------------------------------------------------------------
// MERCURY
// ---------------------------------------------------------------------

$TEXT['mail-head']="Wysyłanie maili za pomoc Mercury Mail na serwerach SMTP i POP3";
$TEXT['mail-hinweise']="Notki odnosnie wykorzystywania tego programu!";
$TEXT['mail-adress']="Nadawca:";
$TEXT['mail-adressat']="Adresat:";
$TEXT['mail-cc']="CC:";
$TEXT['mail-subject']="Temat:";
$TEXT['mail-message']="Wiadomo?ć:";
$TEXT['mail-sendnow']="Wiadomo?ć jest wysyłana ...";
$TEXT['mail-sendok']="Wiadomo?ć wysłana pomy?lnie!";
$TEXT['mail-sendnotok']="Błd! Nie udało się wysłać poprawnie wiadomo?ć!";
$TEXT['mail-help1']="Notki:<br><br>";
$TEXT['mail-help2']="<UL>
<LI>Mercury potrzebuje zewnętrznego połczenia przy starcie;</LI>
<LI>przy starcie Mercury definiuje Domain Name Service (DNS) automatycznie, jako nazwę serwera twojego dostawcy;</LI>
<LI>Dla użytkowników gateway servers: Proszę ustawić DNS poprzez TCP/IP (poprzez InterNic z IP 198.41.0.4);</LI>
<LI>Plik konfiguracyjny Mercury to MERCURY.INI;</LI>
<LI>dla testów możesz wysłać email do postmaster@localhost lub admin@localhost i poszukać tych wiadomo?ci w katalogach: xampp.../mailserver/MAIL/postmaster lub (...)/admin;</LI>
<LI>jeden testowy użytkownik \"newuser\" (newuser@localhost) z hasłem = wampp;</LI>
<LI>spam i podobne s zabronione w Mercury!;</LI> 
</UL>";
$TEXT['mail-url']="<a href=\"http://www.pmail.com/overviews/ovw_mercury.htm\" target=\"_top\">http://www.pmail.com/overviews/ovw_mercury.htm</a>";
// ---------------------------------------------------------------------
// FileZilla FTP 
// ---------------------------------------------------------------------

$TEXT['filezilla-head']="Serwer FileZilla FTP";
$TEXT['filezilla-install']="Apache nie jest serwerem FTP ... ale FileZilla FTP jest.";
$TEXT['filezilla-install2']="W głównym katalogu XAMPPa uruchom \"filezilla_setup.bat\" by skonfigurować serwer. Uwaga: Dla Windows NT, 2000 i XP Professional, FileZilla musi zostać zainstalowana jako service.";
$TEXT['filezilla-install3']="Konfigurowanie \"FileZilla FTP\". W tym celu użyj interfejsu FileZilla \"FileZilla Server Interface.exe\". W przykładzie ustawieni s dwaj użytkownicy:<br><br>
A: Domy?lny użytkownik \"newuser\", hasło \"wampp\". Główny katalog xampp\htdocs.<br> 
B: Anonimowy użytkownik \"anonymous\", bez hasła. Główny katalog xampp\anonymous.<br><br>
Domy?lnym interfejsem jest adres loopback - 127.0.0.1.";
$TEXT['filezilla-install4']="Serwer FTP jest wyłczany za pomoc \"FileZillaFTP_stop.bat\". Dla FileZilla jako service użyj \"FileZillaServer.exe\" bezpo?rednio. Wtedy możesz skonfigurować wszystkie opcje startowe.";
$TEXT['filezilla-url']="<br><br><a href=\"http://filezilla.sourceforge.net\" target=\"_top\">http://filezilla.sourceforge.net</a>";

// ---------------------------------------------------------------------
// PEAR
// ---------------------------------------------------------------------

$TEXT['pear-head']="Eksport do Excela za pomoc PEAR (PHP)";
$TEXT['pear-text']="Krótki <a class=blue target=extern href=\"http://www.contentmanager.de/magazin/artikel_310-print_excel_export_mit_pear.html\">Manual</A> po niemiecku autorstwa Björna Schottea.";
$TEXT['pear-cell']="Warto?ć komórki";

// ---------------------------------------------------------------------
// JPGRAPH
// ---------------------------------------------------------------------

$TEXT['jpgraph-head']="JpGraph - Biblioteka graficzna dla PHP";
$TEXT['jpgraph-url']="<br><br><a href=\"http://www.aditus.nu/jpgraph/\" target=\"_top\">http://www.aditus.nu/jpgraph/</a>";

// ---------------------------------------------------------------------
// ADODB
// ---------------------------------------------------------------------

$TEXT['ADOdb-head']="ADOdb - Dostęp do baz danych (PHP)";
$TEXT['ADOdb-text']="ADOdb wspiera MySQL, PostgreSQL, Interbase, Firebird, Informix, Oracle, MS SQL 7, Foxpro, Access, ADO, Sybase, FrontBase, DB2, SAP DB, SQLite i pochodne ODBC. Obsługa Sybase, Informix, FrontBase i PostgreSQL została zaimplementowana przez fanów projektu. Znajdziesz je w \(mini)xampp\php\pear\adodb.";
$TEXT['ADOdb-example']="Przykład:";
$TEXT['ADOdb-dbserver']="Server bay danych (MySQL, Oracle ..?)";
$TEXT['ADOdb-host']="Host (nazwa lub IP)";
$TEXT['ADOdb-user']="Użytkownik ";
$TEXT['ADOdb-password']="Hasło";
$TEXT['ADOdb-database']="Obecna baza na serwerze";
$TEXT['ADOdb-table']="Zaznaczone tabele";
$TEXT['ADOdb-nottable']="<p><B>Tabela nie znaleziona!</B>";
$TEXT['ADOdb-notdbserver']="<p><B>Driver do tej bazy nie istnieje!</B>";


// ---------------------------------------------------------------------
// INFO
// ---------------------------------------------------------------------

$TEXT['info-package']="Pakiet";
$TEXT['info-pages']="Strony";
$TEXT['info-extension']="Rozszerzenie";
$TEXT['info-module']="Moduł Apache";
$TEXT['info-description']="Opis";
$TEXT['info-signature']="Sygnatura";
$TEXT['info-docdir']="Document root";
$TEXT['info-port']="Domy?lny port";
$TEXT['info-service']="Services";
$TEXT['info-examples']="Przykłady";
$TEXT['info-conf']="Pliki konfiguracyjne";
$TEXT['info-requires']="Wymaga";
$TEXT['info-alternative']="Alternatywa";
$TEXT['info-tomcatwarn']="Uwaga, Tomcat nie działa na porcie 8080.";
$TEXT['info-tomcatok']="OK! Tomcat działa na porcie 8080.";
$TEXT['info-tryjava']="Przykład Javy (JSP) z Apache MOD_JK.";
$TEXT['info-nococoon']="Uwaga, Tomcat nie działa na porcie 8080, nie można zainstalować cocoon!";
$TEXT['info-okcocoon']="Tomcat działa na porcie 8080! By zainstalować \"Cocoon\" kliknij tutaj ...";

// ONLY ENGLISH LANGUAGE SECTION

// ---------------------------------------------------------------------
// Guest
// ---------------------------------------------------------------------

$TEXT['guest1-name']="Current Guest in this release: <i>FCKeditor</i>";
$TEXT['guest1-text1']="A very nice HMTL ONLINE editor with much more JavaScript. Optimized for the IE. But do not function with the Mozilla FireFox.";
$TEXT['guest1-text2']="FCKeditor Homepage: <a href=\"http://www.fckeditor.net\" target=\"_new\">www.fckeditor.net</a>. Note: The Arial font do NOT function here, but i do not know why!"; 
$TEXT['guest1-text3']="<a href=\"guest-FCKeditor/fckedit-dynpage.php\" target=\"_new\">The example page written with the FCKeditor.</A>"; 
?>


