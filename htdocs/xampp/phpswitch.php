<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); 
global $switchphp;
$curdir = getcwd();
list ($partwampp, $directorwampp) = spliti ('\\\htdocs\\\xampp', $curdir);
$switchphp=$partwampp."\\php-switch.bat";
$switch = ereg_replace ("\\\\","/",$switchphp);
$realswitch="file:///".$switch;
$php4ini=$partwampp."\\php\\php4\\php4.ini";
$httpd4conf=$partwampp."\\php\\php4\\httpd4.conf";
$php5ini=$partwampp."\\php\\php5.ini";
$httpd5conf=$partwampp."\\php\\httpd5.conf";
$httpdconf=$partwampp."\\apache\\bin\\httpd.conf";
$phpini=$partwampp."\\apache\\bin\\php.ini";
$version=phpversion();

?>

&nbsp;<p>



<table width="90%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><h1><?=$TEXT['switch-head']?></h1></td>
<td width="6%">&nbsp;</td>
</tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-phpversion']?><? echo "<b>PHP $version</b></i><p>" ?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-whatis']?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-find']?><? echo "<br><br>=> $partwampp\\<B>php-switch.bat</B> <=<p>"; ?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><IMG SRC="img/phpswitch4.gif" WIDTH="669" HEIGHT="331" BORDER="0" ALT=""></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*">&nbsp;</td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-care']?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-where4']?><? echo "$php4ini<br>$httpd4conf"; ?> 
	<?=$TEXT['switch-where5']?><? echo "$php5ini<br>$httpd5conf<p>"; ?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-make1']?><? echo "<I>$phpini<br>$httpdconf</I>"; ?> 
	<?=$TEXT['switch-make2']?><? echo "$php4ini<br>$httpd4conf"; ?>
	<?=$TEXT['switch-make3']?><? echo "$php5ini<br>$httpd5conf"; ?><?=$TEXT['switch-make4']?></td>
<td width="6%">&nbsp;</td>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><?=$TEXT['switch-not']?></td>
<td width="6%">&nbsp;</td>
</tr>
</tr>
<tr>
<td width="6%">&nbsp;</td>
<td width="*"><p><br>© ApacheFriends 2002-2004<p></td>
<td width="6%">&nbsp;</td>
</tr>
</table>


	
</body>
</html>
