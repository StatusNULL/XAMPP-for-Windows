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
<h1>Testings f�r Perl</h1><p>
<br>

  </td>
</tr>



<?php
$curdir = getcwd();
list ($part, $direct) = split ('\\\xampp', $curdir);

echo "<tr>
    <td align=left width=\"500\" colspan=\"2\">
<h4>Perl mit MOD_PERL ...</h4>
<b>bedeutet erst einmal beim manuellen Starten des Apache HTTPD warten, bis sich dieser sich vollst�ndig initialisiert hat. Das selbe Ph�nomen gibt es dann auch noch f�r das manuelle Stoppen des Apache. Der Apache startet n�hmlich Mod_Perl mit den wichtigen Perl Extensions und das kann dauern ... Wer also MOD_PERL nach der Installation des xampp wieder entfernen m�chte, der �ffnet die Konfiguartionsdatei des Apache, also die $part\xampp\apache\httpd.conf und kommentiert dort die folgenden MOD PERL Zeilen mit # vollst�ndig aus. Danach Apache (neu)start.</b> <br><br>
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
	A: Perl-CGI wird �berall unter $part\xampp\htdocs mit den Endungen .cgi und .pl ausgef�hrt. Ausnahme: $part\xampp\htdocs\modperl und $part\xampp\htdocs\modperlasp.<br>
	B: Perl �ber mod_perl wird hier als Standard nur unter $part\xampp\htdocs\modperl ausgef�hrt. �brigens alle dort ans�ssigen Dateien werden �ber mod_perl ausgef�hrt, egal welche Endung! Der HTTP Alias hei�t \perl\.<br>
	C: Perl:ASP �ber mod_perl:asp wird nur im Verzeicbnis $part\xampp\htdocs\modperlasp ausgef�hrt. Auch dort werden alle Dateien �ber Perl:ASP ausgef�hrt. Der HTTP Alias hei�t /asp/.<br><br>
	Warum nun das alles, fragt sich sicherlich der eine oder andere. Der Grund ist einfach. Unter win95|98|ME l�uft die Kopplung der Dateiendungen .pl und .asp f�r mod_perl und perl:asp nicht. Allein die Freigabe von Verzeichnissen f�r mod_perl + perl:asp lief hier zufriedenstellend. Wer also NT, w2k oder XP Professional benutzt, kann die \"httpd.conf\" so �ndern, dass bestimmte Endungen �ber mod_perl angesprochen werden. Das Fragment steht noch da! F�r alle win95|98|ME Besitzer bitte H�nde weg! Und nun die Tests f�r MOD_PERL:</b>      
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
Ort: �berall $part\xampp\htdocs ausser $part\xampp\htdocs\modperl und $part\xampp\htdocs\modperlasp<br>
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
(2) Perl �ber MOD-Perl (Endungen: EGAL)<br>
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