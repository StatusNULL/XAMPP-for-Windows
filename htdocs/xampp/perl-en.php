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
<h1>Testings for Perl</h1><p>
<br>

  </td>
</tr>
<?php
$curdir = getcwd();
list ($part, $direct) = split ('\\\xampp', $curdir);

echo "<tr>
    <td align=left width=\"500\" colspan=\"2\">
<h4>Perl with MOD_PERL ...</h4>
<b>... meant wait a minute, until the Apache HTTPD starts.The same procedure happens when the apache stops. 
To start Mod_Perl with all important perl extensions, that needs some time ... So, who wants to remove mod_perl 
opens the apache configuration \"$part\xampp\apache\httpd.conf \" to deactivate the activated lines with #: 
After that, please (re)start apache.</b> <br><br>
### Please activate or deactivate MOD PERL here ### <br>
### Bitte MOD PERL hier aktivieren oder deaktivieren ###<br>
# LoadFile \"/xampp/perl/bin/perl58.dll\"<br>
# LoadFile \"/xampp/perl/bin/libxml2.dll\"<br>
# LoadModule perl_module modules/mod_perl.so<br>
### Section MOD PERL end ###<br>
<br>
<b>CGI (*.cgi) should always function (however):<br><br> 
<A HREF=\"http://127.0.0.1/cgi-bin/perltest.cgi\">=> Test \"Hello World\" <=</A><br><br><br></B>
  </td>
</tr>

<tr>
    <td align=left width=\"500\" colspan=\"2\"><h4>Who want to use MOD_PERL effectively, please still considers these references</h4><b>
	A: Perl-CGI with the endings .cgi and .pl will be execute overall under $part\xampp\htdocs. Exception: $part\xampp\htdocs\modperl and $part\xampp\htdocs\modperlasp.<br>
	B: Perl with mod_perl will be execute under $part\xampp\htdocs\modperl only. 
	In this directory, all files are execute over mod_perl! So, the endings here are unimportantly.
	The HTTP Alias called \perl\.<br>
	C: Perl:ASP over mod_perl:asp will be execute under $part\xampp\htdocs\modperlasp only.
	In this directory, all files are execute over perl:asp! So, the endings here are unimportantly.
	The HTTP Alias called \asp\.<br><br>
	But why this action? The reason is simple. Under win95|98|ME, file endings
	like .pl or .asp. are not running by the \"connection\" with mod_perl. Only the release of directories for mod_perl 
	would function. For all users of NT, w2k or XP Professional, you can define some file endings for mod_perl. Please show for the \"httpd.conf\". There is a little example inside. And now the tests:</b>      
	</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><b>
(1) CGI (Endings: .cgi or .pl)<br>
Location: Overall $part\xampp\htdocs except $part\xampp\htdocs\modperl and $part\xampp\htdocs\modperlasp<br>
Perl Path into header: Necessarily, here => #!\xampp\perl\bin\perl.exe<br>
Example: $part\xampp\cgi-bin\test.cgi<br> 
<A HREF=\"http://127.0.0.1/cgi-bin/test.cgi\">Test \"Hello World\"</A></B>
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><b>
(2) Perl over mod_perl (Endings: ALL)<br>
Location: Only $part\xampp\htdocs\modperl<br>
Perl Path into header: Not necessarily<br>
Example: $part\xampp\htdocs\modperl\datum.pl<br> 
<A HREF=\"http://127.0.0.1/perl/datum-en.pl\">Test \"Date with Perl\"</A></B>
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left>
&nbsp;
</td>
  </tr>
<tr>
  <td colspan=\"2\" width=\"500\" align=left><B>
(3) Perl:ASP (Endings: ALL)<br>
Location: Only $part\xampp\htdocs\modperlasp<br>
Perl Path into header: Not necessarily<br>
Example: $part\xampp\htdocs\modperlasp\loop.asp<br> 
<A HREF=\"http://127.0.0.1/asp/loop.asp\">Test \"Numbers, which growing\"</A></B>
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