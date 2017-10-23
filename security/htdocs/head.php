<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body style="background: #ffffff; margin-top: 8px; margin-left: 8px;">

<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td><img src="img/blank.gif" width=111 height=1></td>
<? if(file_get_contents("lang.tmp")=="de") { ?>
<td><a target=content href="http://www.apachefriends.org/xampp.html"><img border="0" src="img/logo-small.gif"></a></td>
<? } else { ?>
<td><a target=content href="http://www.apachefriends.org/xampp-en.html"><img border="0" src="img/logo-small.gif"></a></td>
<? } ?>
<td><img src="img/blank.gif" width=10 height=1></td>
<td><img src="img/head-xampp.gif"></td>
<td><img src="img/blank.gif" width=10 height=1></td>
<? if(file_get_contents("lang.tmp")=="de") { ?>
<td><img src="img/head-fuer.gif"></td>
<? } else { ?>
<td><img src="img/head-for.gif"></td>
<? } ?>
<td><img src="img/blank.gif" width=10 height=1></td>
<td><img src="img/head-windows.gif"></td>
</tr>
</table>

</body>
</html>
