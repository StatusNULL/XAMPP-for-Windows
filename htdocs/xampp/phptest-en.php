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
echo "<b>Welcome! If you can see the counter number, PHP4 is working! You are the guest number $zahl. And now, here are all the advanced testings:";

$fp = fopen($fn, "w");
flock($fp,2);
fputs($fp,$zahl);
flock($fp,3);
fclose($fp);
?>
</td></tr>
<tr><td align=left>&nbsp;<p><a href="cds-en.php">NEW! Oswalds CD Collection v0.2 for win32!</a>
</td></tr>
<tr><td align=left>&nbsp;<p><a href="gd-en.html">(1) Dynamic graphs with GD 2</a>
</td></tr>
<tr><td align=left><a href="freetype-en.html">(2) Dynamic buttons with Freetype</a>
</td></tr>
<tr><td align=left><a href="excel-en.php">(4) An Excel Writer in PHP</a>
</td></tr>
<tr><td align=left><a href="pdf.html">(5) An PDF Writer in PHP</a>
</td></tr>
<tr><td align=left>&nbsp;
</td></tr>
<tr><td align=left>&nbsp;
</td></tr>
<tr><td align=left><h4>So i hope, everything functions ...</h4>
</td></tr>
</table>
<p>&nbsp;<p>

</body>
</HTML>