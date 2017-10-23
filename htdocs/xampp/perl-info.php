<html>
<head>
<meta name="author" content="Kay Vogelgesang, Kai Oswald Seidler">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? 
include("lang/".file_get_contents("lang.tmp").".php"); 
include ("where.php");
$apppath= $partwampp."\perl\\bin\\perl -v";
$app = shell_exec ($apppath);
?>

&nbsp;<br>
<h1>PERL</h1>

<table border="0">


<tr>
<td width="100"><?=$TEXT['info-module']?>:</td>
<td width="10">&nbsp;</td>
<td width="*">PERL/1.99_12</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-extension']?>:</td>
<td width="10">&nbsp;</td>
<td width="*">.pl</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-docdir']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\htdocs\\modperl\\";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-conf']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\apache\\conf\\perl.conf";?> + <? echo $partwampp."\apache\\conf\\startup.pl";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-examples']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\htdocs\\modperl\\modperl.pl";?> | Alias: <a target=content href=/perl/modperl.pl>http://localhost/perl/modperl.pl</a></td>
</tr>
<tr>
<td width="100">&nbsp;</td>
<td width="10">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-extension']?>:</td>
<td width="10">&nbsp;</td>
<td width="*">.asp</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-docdir']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\htdocs\\modperlasp\\";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-conf']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\apache\\conf\\perl.conf";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-examples']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\htdocs\\modperlasp\\loop.asp";?> | Alias: <a target=content href=/asp/loop.asp>http://localhost/asp/loop.asp</a></td>
</tr>

<tr>
<td width="100">&nbsp;</td>
<td width="10">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-extension']?>:</td>
<td width="10">&nbsp;</td>
<td width="*">.cgi</td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-docdir']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\cgi-bin\\";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-conf']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\apache\\conf\\httpd.conf";?></td>
</tr>
<tr>
<td width="100"><?=$TEXT['info-examples']?>:</td>
<td width="10">&nbsp;</td>
<td width="*"><? echo $partwampp."\cgi-bin\\perltest.cgi";?> | Alias: <a target=content href=/cgi-bin/perltest.cgi>http://localhost/cgi-bin/perltest.cgi</a></td>
</tr>

<tr>
<td width="100">&nbsp;</td>
<td width="10">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="100">Homepage:</td>
<td width="10">&nbsp;</td>
<td width="*"><A HREF="http://www.perl.org" target="_new">http://www.perl.org</A></td>
</tr>
<tr>
<td width="100">&nbsp;</td>
<td width="10">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="*" colspan="3"><? echo "$app";?></td>
</tr>
</table>
<p>


</body>
</html>
