<?
// ---------------------------------------------------------------------
// GLOBAL
// ---------------------------------------------------------------------

$TEXT['global-xampp']="XAMPP for Windows";

// ---------------------------------------------------------------------
// NAVIGATION
// ---------------------------------------------------------------------

$TEXT['navi-xampp']="XAMPP";
$TEXT['navi-welcome']="Welcome";
$TEXT['navi-status']="Status";
$TEXT['navi-security']="Security";
$TEXT['navi-doc']="Documentation";
$TEXT['navi-components']="Components";
$TEXT['navi-about']="About XAMPP";

$TEXT['navi-demos']="Demos";
$TEXT['navi-cdcol']="CD Collection";
$TEXT['navi-bio']="Biorhythm";
$TEXT['navi-guest']="Guest Book";
$TEXT['navi-perlenv']="MiniPerl";
$TEXT['navi-iart']="Instant Art";
$TEXT['navi-iart2']="Flash Art";
$TEXT['navi-phonebook']="Phone Book";
$TEXT['navi-perlasp']="Perl:ASP";
$TEXT['navi-pear']="PEAR:Excel_Writer";
$TEXT['navi-adodb']="ADOdb";
$TEXT['navi-perl']="Module Perl";

$TEXT['navi-tools']="Tools";
$TEXT['navi-phpmyadmin']="phpMyAdmin";
$TEXT['navi-webalizer']="Webalizer";
$TEXT['navi-mercury']="Mercury Mail";
$TEXT['navi-filezilla']="FileZilla FTP";
$TEXT['navi-jpgraph']="JpGraph";

$TEXT['navi-languages']="Languages";
$TEXT['navi-english']="English";
$TEXT['navi-german']="Deutsch";

// ---------------------------------------------------------------------
// STATUS
// ---------------------------------------------------------------------

$TEXT['status-head']="XAMPP Status";
$TEXT['status-text1']="This page offers you on one view all information about what's running and working and what's not.";
$TEXT['status-text2']="Some changes to the configuration sometime may cause false negative status reports. With SSL (https://localhost) all these reports do not function!";

$TEXT['status-mysql']="MySQL database";
$TEXT['status-php']="PHP";
$TEXT['status-perl']="Perl with mod_perl";
$TEXT['status-cgi']="Common Gateway Interface (CGI)";
$TEXT['status-ssi']="Server Side Includes (SSI)";
$TEXT['status-mmcache']="PHP extension »Turck MMCache«";
$TEXT['status-mmcache-url']="http://www.apachefriends.org/faq-wampp-en.html#mmcache";
$TEXT['status-smtp']="SMTP Server";
$TEXT['status-ftp']="FTP Server";
$TEXT['status-oci8']="PHP extension »OCI8/Oracle«";
$TEXT['status-oci8-url']="http://www.apachefriends.org/faq-lampp-en.html#oci8";

$TEXT['status-lookfaq']="see FAQ";
$TEXT['status-ok']="ACTIVATED";
$TEXT['status-nok']="DEACTIVATED";

$TEXT['status-tab1']="Component";
$TEXT['status-tab2']="Status";
$TEXT['status-tab3']="Hint";

// ---------------------------------------------------------------------
// SECURITY
// ---------------------------------------------------------------------

$TEXT['security-head']="XAMPP security";
$TEXT['security-text1']="This page gives you a quick overview about the security status of your XAMPP installation. (Please continue reading after the table.)";
$TEXT['security-text2']="The green marked points are secure; the red marked points are definitively unsecure and the yellow marked points couldn't be checked (for example because the sofware to check isn't running).<p>To fix or close all these matters simply call<p><b>/opt/lampp/lampp security</b><p>This will start an interactive program.";

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

$TEXT['security-checkmysql-nok']="The MySQL user root has no password";
$TEXT['security-checkmysql-ok']="The MySQL user root has no longer no password";
$TEXT['security-checkmysql-text']="Every local user on Linux box can access your MySQL database with administrator rights. You should set a password.";

$TEXT['security-checkftppassword-nok']="The FTP password for user nobody is still 'lampp'";
$TEXT['security-checkftppassword-ok']="The FTP password for user nobody is no langer 'lampp'";
$TEXT['security-checkftppassword-text']="By using the default password for the FTP user nobody everyone can upload and change files for your XAMPP webserver. So if you enabled ProFTPD you should set a new password for user nobody.";

// ---------------------------------------------------------------------
// START
// ---------------------------------------------------------------------

$TEXT['start-head']="Welcome to XAMPP for Windows";

$TEXT['start-subhead']="Congratulations:<br>You successfully installed XAMPP on this system!";

$TEXT['start-text1']="Now you can start using Apache and Co. Firstly you should try »Status« on the left navigation to make sure everything works fine.";

$TEXT['start-text2']="After testing you may take a look at the examples below the test link.";

$TEXT['start-text3']="If you want to start programming PHP or Perl (or whatever ;) please take a look at the <a href=readme_en.txt>XAMPP readme</a> first and get more information about your XAMPP installation.";

$TEXT['start-text4']="For OpenSSL support please use the test certificate with <a href='https://127.0.0.1' target='_top'>https://127.0.0.1</a> or <a href='https://localhost' target='_top'>https://localhost</a>";

$TEXT['start-text5']="And very important! Big thanks for help and support to Nemesis, KriS, Boppy, Pc-Dummy and all other friends of XAMPP!";

$TEXT['start-text6']="Good luck,<br>Oswald + Kay Vogelgesang";

// ---------------------------------------------------------------------
// MANUALS
// ---------------------------------------------------------------------

$TEXT['manuals-head']="Online documentation";

$TEXT['manuals-text1']="XAMPP combines many different sofware packages into one packet. Here's a list of standard and reference documentation of the most important packages.";


$TEXT['manuals-list1']="
<ul>
<li><a href=http://httpd.apache.org/docs-2.0/>Apache 2 documentation</a>
<li><a href=http://www.php.net/manual/en/>PHP <b>referenz </b>documentation</a>
<li><a href=http://www.perldoc.com/perl5.8.0/pod/perl.html>Perl documentation</a>
<li><a href=http://www.mysql.com/documentation/mysql/bychapter/>MySQL documentation</a>
<li><a href=http://php.weblogs.com/ADODB>ADODB</a>
<li><a href=http://turck-mmcache.sourceforge.net/>Turck MMCache for PHP</a>
<li><a href=http://www.ros.co.nz/pdf/readme.pdf>pdf class documentation</a>
</ul>";

$TEXT['manuals-text2']="And a small list of tutorials and the Apache Friends documentation page:";

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

$TEXT['components-head']="XAMPP components";

$TEXT['components-text1']="XAMPP combines many different sofware packages into one packet. Here's an overview over all packages.";

$TEXT['components-text2']="Many thanks to the developers of these programs.";

$TEXT['components-text3']="In the directory <b>\(mini)xampp\licenses</b> you will find all licenses files of these programs.";

// ---------------------------------------------------------------------
// CD COLLECTION DEMO
// ---------------------------------------------------------------------

$TEXT['cds-head']="CD Collection (Example for PHP+MySQL+PDF Class)";

$TEXT['cds-text1']="A very simple CD programm.";

$TEXT['cds-text2']="CD list as <a href='$PHP_SELF?action=getpdf'>PDF document</a>.";

$TEXT['cds-error']="Could not connect to database!<br>Is MySQL running or did you change the password?";
$TEXT['cds-head1']="My CDs";
$TEXT['cds-attrib1']="Artist";
$TEXT['cds-attrib2']="Title";
$TEXT['cds-attrib3']="Year";
$TEXT['cds-attrib4']="Command";
$TEXT['cds-sure']="Sure?";
$TEXT['cds-head2']="Add CD";
$TEXT['cds-button1']="DELETE CD";
$TEXT['cds-button2']="ADD CD";

// ---------------------------------------------------------------------
// BIORHYTHM DEMO
// ---------------------------------------------------------------------

$TEXT['bio-head']="Biorhythm (Example for PHP+GD)";

$TEXT['bio-by']="by";
$TEXT['bio-ask']="Please enter your date of birth";
$TEXT['bio-ok']="OK";
$TEXT['bio-error1']="Date";
$TEXT['bio-error2']="is invalid";

$TEXT['bio-birthday']="Birthday";
$TEXT['bio-today']="Today";
$TEXT['bio-intellectual']="Intellectual";
$TEXT['bio-emotional']="Emotional";
$TEXT['bio-physical']="Physical";

// ---------------------------------------------------------------------
// INSTANT ART DEMO
// ---------------------------------------------------------------------

$TEXT['iart-head']="Instant Art (Example for PHP+GD+FreeType)";
$TEXT['iart-text1']="Font »AnkeCalligraph« by <a class=blue target=extern href=\"http://www.anke-art.de/\">Anke Arnold</a>";
$TEXT['iart-ok']="OK";

// ---------------------------------------------------------------------
// FLASH ART DEMO
// ---------------------------------------------------------------------

$TEXT['flash-head']="Flash Art (Example for PHP+MING)";
$TEXT['flash-text1']="The MING project for win32 does not exist any longer and it is not complete.<br>Please read this: <a class=blue target=extern href=\"http://ming.sourceforge.net/install.html/\">Ming - an SWF output library and PHP module</a>";
$TEXT['flash-ok']="OK";

// ---------------------------------------------------------------------
// PHONE BOOK DEMO
// ---------------------------------------------------------------------

$TEXT['phonebook-head']="Phone Book (Example for PHP+SQLite)";

$TEXT['phonebook-text1']="A very simple phone book script. But implemented with a very modern and up-to-date technology: SQLite, the SQL database without server.";

$TEXT['phonebook-error']="Couldn't open the database!";
$TEXT['phonebook-head1']="My phone numbers";
$TEXT['phonebook-attrib1']="Last name";
$TEXT['phonebook-attrib2']="First name";
$TEXT['phonebook-attrib3']="Phone number";
$TEXT['phonebook-attrib4']="Command";
$TEXT['phonebook-sure']="Sure?";
$TEXT['phonebook-head2']="Add entry";
$TEXT['phonebook-button1']="DELETE";
$TEXT['phonebook-button2']="ADD";

// ---------------------------------------------------------------------
// ABOUT
// ---------------------------------------------------------------------

$TEXT['about-head']="About XAMPP";

$TEXT['about-subhead1']="Idea and realisation";

$TEXT['about-subhead2']="Design";

$TEXT['about-subhead3']="Collaboration";

$TEXT['about-subhead4']="Contact persons";

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

?>
