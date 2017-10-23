<HEAD>
<TITLE> Perl </TITLE>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</HEAD>

<BODY>
&nbsp;<p>


<table width=500 cellpadding=0 cellspacing=0 border=0>
<tr>
  <td colspan="2" width="500" align=left>
<h1>Testings für Perl</h1><p>
<br>

  </td>
</tr>



<?php
$curdir = getcwd();
list ($part, $direct) = split ('\\\xampp', $curdir);

echo "<tr>
    <td align=left width=\"500\" colspan=\"2\">
<h4>Perl mit MOD_PERL ...</h4>
<b>bedeutet erst einmal beim manuellen Starten des Apache HTTPD warten, bis sich dieser sich vollständig initialisiert hat. Das selbe Phänomen gibt es dann auch noch für das manuelle Stoppen des Apache. Der Apache startet nähmlich Mod_Perl mit den wichtigen Perl Extensions und das kann dauern ... Wer also MOD_PERL nach der Installation des xampp wieder entfernen möchte, der öffnet die Konfiguartionsdatei des Apache, also die $part\xampp\apache\httpd.conf und kommentiert dort die folgenden MOD PERL Zeilen mit # vollständig aus. Danach Apache (neu)start.</b> <br><br>
### Please activate or deactivate MOD PERL here ### <br>
### Bitte MOD PERL hier aktivieren oder deaktivieren ###<br>
# LoadFile \"/xampp/perl/bin/perl58.dll\"<br>
# LoadFile \"/xampp/perl/bin/libxml2.dll\"<br>
# LoadModule perl_module modules/mod_perl.so<br>
### Section MOD PERL end ###<br>
<br>
<b>CGI (*.cgi) sollte aber immer funktionieren:<br><br> 
<A HREF=\"http://127.0.0.1/cgi-bin/perltest.cgi\">=> Test \"Hello World\" <=</A><br><br><br></B>
  </td>
</tr>

<tr>
    <td align=left width=\"500\" colspan=\"2\"><h4>Wer MOD_PERL benutzen will, beachtet bitte noch diese Hinweise</h4><b>
	A: Perl-CGI wird überall unter $part\xampp\htdocs mit den Endungen .cgi und .pl ausgeführt. Ausnahme: $part\xampp\htdocs\modperl und $part\xampp\htdocs\modperlasp.<br>
	B: Perl über mod_perl wird hier als Standard nur unter $part\xampp\htdocs\modperl ausgeführt. Übrigens alle dort ansässigen Dateien werden über mod_perl ausgeführt, egal welche Endung! Der HTTP Alias heißt \perl\.<br>
	C: Perl:ASP über mod_perl:asp wird nur im Verzeicbnis $part\xampp\htdocs\modperlasp ausgeführt. Auch dort werden alle Dateien über Perl:ASP ausgeführt. Der HTTP Alias heißt /asp/.<br><br>
	Warum nun das alles, fragt sich sicherlich der eine oder andere. Der Grund ist einfach. Unter win95|98|ME läuft die Kopplung der Dateiendungen .pl und .asp für mod_perl und perl:asp nicht. Allein die Freigabe von Verzeichnissen für mod_perl + perl:asp lief hier zufriedenstellend. Wer also NT, w2k oder XP Professional benutzt, kann die \"httpd.conf\" so ändern, dass bestimmte Endungen über mod_perl angesprochen werden. Das Fragment steht noch da! Für alle win95|98|ME Besitzer bitte Hände weg! Und nun die Tests für MOD_PERL:</b>      
	</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><b>
(1) CGI (Endungen: .cgi oder .pl)<br>
Ort: Überall $part\xampp\htdocs ausser $part\xampp\htdocs\modperl und $part\xampp\htdocs\modperlasp<br>
Perlpfad im Header: Notwendig, hier => #!\xampp\perl\bin\perl.exe<br>
Beispieldatei: $part\xampp\cgi-bin\perltest.cgi<br> 
<A HREF=\"http://127.0.0.1/cgi-bin/perltest.cgi\">Test \"Hello World\"</A></B>
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><b>
(2) Perl über MOD-Perl (Endungen: EGAL)<br>
Ort: Nur $part\xampp\htdocs\modperl<br>
Perlpfad im Header: Nicht notwendig<br>
Beispieldatei: $part\xampp\htdocs\modperl\datum.pl<br> 
<A HREF=\"http://127.0.0.1/perl/datum.pl\">Test \"Datum mit Perl\"</A></B>
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><B>
(3) Perl:ASP (Endungen: EGAL)<br>
Ort: Nur $part\xampp\htdocs\modperlasp<br>
Perlpfad im Header: Nicht notwendig<br>
Beispieldatei: $part\xampp\htdocs\modperlasp\loop.asp<br> 
<A HREF=\"http://127.0.0.1/asp/loop.asp\">Test \"Zahlen, die wachsen\"</A></B>
</td>
  </tr>";
  ?>

<tr>
  <td colspan="2" width="500" align=left>
&nbsp;
</td>
</tr>
<tr>
  <td colspan="2" width="500" align=left>
<h4>OK?</h4>
</td>
</tr>



  </table>
</body>
</HTML>