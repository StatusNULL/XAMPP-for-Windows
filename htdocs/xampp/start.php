<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>

<table width=500 cellpadding=0 cellspacing=0 border=0>

<tr><td><br>
<h1>Das ist ApacheFriends XAMPP für Windows!</h1>
<h1>Herzlichen Gl&uuml;ckwunsch:<br>
Es hat geklappt!</h1>

<p>Es läuft hier <A HREF="http://www.apachefriends.org/" target="_top">ApacheFriends XAMPP Version 1.2</A> mit ...<br><br>
<?
$httpd = getenv("SERVER_SOFTWARE");
echo "<i>$httpd</i><br>";
?>
<p>

<h2>Ein Danke an ...</h2>
=> KriS, Nemesis, Boppy und allen anderen, die mit ihren Skripts, Hinweisen und gefundenen Bugs dieses Produkt verbessert haben!    
<br><br>

<?php
$curdir = getcwd();
list ($partXAMPP, $directorXAMPP) = split ('\\\htdocs\\\xampp', $curdir);
echo "Die Logfile sind wieder unter ...<br>Verzeichnis => $partXAMPP\apache\logs\<br><br>";
?>

Warnung: Mit der abermaligen Aktivierung der "setup_xampp.bat" versucht das "install.php" Programm im "install" Verzeichnis die zur Zeit geltenen Pfade in den bekannten Konfigurationsdateien nochmals zu aktualisieren. Diese Funktion ist aber noch nicht genügend ausgeprüft und im Alpha Stadium ... also das nur auf eigene Gefahr! Und für Entwckler: 
Die "install.php" ist die das PHP Skript und kann und sollte natürlich verbessert werden, zumal mir die Zeit fehlte, die notwendige Straffung vorzunehmen. Ich würde Hinweise auf Verbesserungen dann gerne aufnehmen, mit Erwähnung des Autors mindenstens im Skript! 

<?php
echo "<p>Pfade für Dokumente:<br><br>
 <UL>
	<LI>Hauptdokumentenverzeichnis:<br>$partXAMPP\htdocs => HTML PHP sowie CGI<br><br></li>
	<LI>Default CGI-BIN:<br>$partXAMPP\cgi-bin => Für *.cgi und *.pl Dateien<br><br></li>
	<LI>apache.exe und php.ini:<br>$partXAMPP\apache\bin => php.ini für mod_php!!!<br><br></li>
	<LI>httpd.conf und moddav.conf:<br>$partXAMPP\apache\conf</li>
</UL>";
?>


<p>PHP? Die Informationen hierzu sind etwas umfangreicher,<br>
 =><a href=phpinfo.php>deshalb hier auf PHPINFO klicken!</a><br><br>
 
 <p>Und PERL? Die Informationen hierzu sind etwas umfangreicher,<br>
 =><a href=perl.php>deshalb hier auf unser TEST PERL klicken!</a><br><br>

<p>Für detailiertere Informationen zu den einzelnen Programmiersprachen (Tests), den Servern und dem Zubehör benutzt bitte die entsprechenden Rubriken in der Navigation. Vieles wird dann hoffentlich klarer ...
Und wenn alles nicht hilft, dann schaut bitte noch einmal in die => <a href=xampp_man.txt>XAMPP-Anleitung</a>


<p>
Und so viel Spaß mit XAMPP!!!<br>
<a href="mailto:kvo@onlinetech.de">Kay 'Birdsinging' Vogelgesang</a>
<br><br>
</td>
</tr>

</table>
</body>
</html>