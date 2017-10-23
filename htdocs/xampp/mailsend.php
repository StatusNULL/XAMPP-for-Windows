<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

&nbsp;<p>
<h1><?=$TEXT['mail-sendnow']?></h1><p>
</td></tr>
<tr><td>&nbsp;<p>
<?
$mailtos = "$recipients";
$subject = "$subject";
$message = "$message";




if ($ccaddress=="" || $ccaddress==" ")
{
	$header="From: $knownsender";
	
}
else
{
	$header .="From: $knownsender\r\n";
	$header .=" Cc: $ccaddress";
}
// $header.="Bcc: $bcaddress";

if (@mail($mailtos, $subject, $message, $header))
{
	echo "<I>".$TEXT['mail-sendok']."</I>";
}
else
{
	echo "<I>".$TEXT['mail-sendnotok']."</I>";
}
?>
</td></tr>
<tr><td>&nbsp;<p>&nbsp;<p>&nbsp;<p>
<a href="javascript:history.back()">Zurück zum Formular</a>
</td></tr>
</table>
</BODY>
</HTML>