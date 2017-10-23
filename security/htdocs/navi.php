<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="xampp.js">
</script>
</head>

<body leftmargin=0 topmargin=0 class=n>

<? if(file_get_contents("lang.tmp")=="")
	{
	include("lang/".file_get_contents("lang.tmp")."en.php");
	}
	else
	{
include("lang/".file_get_contents("lang.tmp").".php"); 
	}
?>

<table border=0 cellpadding=0 cellspacing=0>
<tr valign=top>
<td align=right class=navi>
<img src=img/blank.gif width=145 height=15><br>
<span class=nh>&nbsp;<?=$TEXT['navi-xampp']?> <br>[PHP: <?=phpversion() ?>]</span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>
<a name=start id=start class=nh target=content onClick="h(this);" href=security.php><?=$TEXT['navi-security']?></a><br>


<br>
</td></tr>


<tr><td bgcolor=#fb7922 colspan=1 class=white></td></tr>
<tr valign=top><td align=right class=navi>
<br>
<span class=nh><?=$TEXT['navi-languages']?></span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>

<a target=_parent class=n href="lang.php?de"><?=$TEXT['navi-german']?></a><br>
<a target=_parent class=n href="lang.php?en"><?=$TEXT['navi-english']?></a><br>
<a target=_parent class=n href="lang.php?es"><?=$TEXT['navi-spanish']?></a><br>
<a target=_parent class=n href="lang.php?fr"><?=$TEXT['navi-french']?></a><br>
<a target=_parent class=n href="lang.php?it"><?=$TEXT['navi-italian']?></a><br>
<a target=_parent class=n href="lang.php?nl"><?=$TEXT['navi-dutch']?></a><br>
<a target=_parent class=n href="lang.php?no"><?=$TEXT['navi-norwegian']?></a><br>
<a target=_parent class=n href="lang.php?pl"><?=$TEXT['navi-polish']?></a><br>
<a target=_parent class=n href="lang.php?sl"><?=$TEXT['navi-slovenian']?></a><br>
<a target=_parent class=n href="lang.php?zh"><?=$TEXT['navi-chinese']?></a><p>


<p class=navi>&copy;2002/2005<br>
<? if(file_get_contents("lang.tmp")=="de") { ?>
<a target="_new" href="http://www.apachefriends.org/index.html"><img border=0 src="img/apachefriends.gif"></a><p>
<? } else { ?>
<a target="_new" href="http://www.apachefriends.org/index-en.html"><img border=0 src="img/apachefriends.gif"></a><p>
<? } ?>
</td>
</tr>
</table>
</body>
</html>

