<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>

<table width=500 cellpadding=0 cellspacing=0 border=0>

<tr><td><br>
<h1>Here is ApacheFriends XAMPP for windows!</h1>
<h1>Congratulations:<br>
It is working!</h1>

<p>It is running <A HREF="http://www.apachefriends.org/" target="_top">ApacheFriends XAMPP Version 0.9</A> with ...<br><br>
<?
$httpd = getenv("SERVER_SOFTWARE");
echo "<i>$httpd</i><br>";
?>
<p>


<h2>What's new?</h2>
<b>1) XAMPP installation script in PHP!!!<br>
2) New FTP server FileZilla (opensource under sourceforge.net)<br>
3) More PHP examples ...<br>

<?php
$curdir = getcwd();
list ($partXAMPP, $directorXAMPP) = split ('\\\htdocs\\\xampp', $curdir);
echo "4) All logfiles are already in ...<br>Directory => $partXAMPP\apache\logs\<br><br>";
?>

=> 1) Warning! You can use the "setup_xampp.bat" for refreshing all directories. 
But this kind of actualization of this package happens on your own risk! 
Thus caution ... Of course, you can edit the "install.php" in the "install" directory for your individually needs. It would be nice, you will noticed me for suggestions and improvements.     

<?php
echo "<p>Paths for documents:<br><br>
 <UL>
	<LI>Main Doc Root:<br>$partXAMPP\htdocs => HTML and PHP and CGI<br><br></li>
	<LI>Default CGI-BIN:<br>$partXAMPP\cgi-bin => Für *.cgi and *.pl Dateien<br><br></li>
	<LI>apache.exe and php.ini:<br>$partXAMPP\apache\bin => php.ini for mod_php!!!<br><br></li>
	<LI>httpd.conf and moddav.conf:<br>$partXAMPP\apache\conf</li>
</UL>";
?>


<p>PHP? As the information is too much to display here,<br>
 =><a href=phpinfo.php>use PHPINFO</a>

 <p>And PERL? As the information is too much to display here,<br>
 =><a href=perl-en.php>use our TEST PERL</a>

<p>For more informationen please use all the test left in the navigation bar.<br>
If you still have issues, please study the<br> => <a href=xampp_man.txt>XAMPP-reference</a>

<p>
HAVE FUN!<br>
<a href="mailto:kvo@onlinetech.de">Kay 'Birdsinging' Vogelgesang</a>
<br><br>
</td>
</tr>

</table>
</body>
</html>