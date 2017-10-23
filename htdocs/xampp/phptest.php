<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<TITLE> PHP TESTINGS  </TITLE>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</HEAD>

<BODY>
&nbsp;<p>
<table width=500 cellpadding=0 cellspacing=0 border=0>
<tr><td align=left>
<h1>PHP TESTINGS</h1><p>
<?
$fn = "counter.txt";
if (file_exists($fn))
{
$fp = fopen($fn, "r");
$zahl= fgets($fp,10);
fclose($fp);
}
else

$zahl = 0;
$zahl = $zahl + 1;
echo "<b>Herzlich Willkommen! Du bist der $zahl. Besucher auf dieser Seite. Schön, PHP geht schon einmal. Und nun alle Tests für die fortgeschrittene PHP Programmierung:";

$fp = fopen($fn, "w");
flock($fp,2);
fputs($fp,$zahl);
flock($fp,3);
fclose($fp);
?>
</td></tr>
<tr><td align=left>&nbsp;<p><a href="gd.html">(1) Dynamische Graphiken mit GD 2</a>
</td></tr>
<tr><td align=left><a href="freetype.html">(2) Dynamische Buttons mit Freetype</a>
</td></tr>
<tr><td align=left><a href="excel.php">(4) Ein Excel Writer in PHP</a>
</td></tr>
<tr><td align=left><a href="pdf.html">(5) Ein PDF Writer in PHP</a>
</td></tr>
<tr><td align=left>&nbsp;
</td></tr>
<tr><td align=left>&nbsp;
</td></tr>
<tr><td align=left><h4>Na, hoffentlich funktioniert alles ...</h4>
</td></tr>
</table>
<p>&nbsp;<p>

</body>
</HTML>