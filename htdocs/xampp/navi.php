<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="xampp.js">
</script>
</head>

<body leftmargin=0 topmargin=0 class=n>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

<table border=0 cellpadding=0 cellspacing=0>
<tr valign=top>
<td align=right class=navi>
<img src=img/blank.gif width=145 height=15><br>
<span class=nh><?=$TEXT['navi-xampp']?></span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>
<a name=start id=start class=nh target=content onClick="h(this);" href=start.php><?=$TEXT['navi-welcome']?></a><br>
<a class=n target=content onClick="h(this);" href=status.php><?=$TEXT['navi-status']?></a><br>
<a class=n target=content onClick="h(this);" href=manuals.php><?=$TEXT['navi-doc']?></a><br>
<a class=n target=content onClick="h(this);" href=components.php><?=$TEXT['navi-components']?></a><br>
<a class=n target=content onClick="h(this);" href=phpinfo.php>phpinfo()</a><br>&nbsp;<br>

<span class=nh><?=$TEXT['navi-demos']?></span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>



<?include("navibasics.inc");?>
<?include("naviperl.inc");?>
<?include("navipython.inc");?>
<?include("navijava.inc");?>


<br>&nbsp;<br>

<span class=nh><?=$TEXT['navi-tools']?></span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>
<?include("navitools.inc");?>
<?include("naviservers.inc");?>
<?include("naviother.inc");?>
<br>&nbsp;<br>

<span class=nh><?=$TEXT['navi-languages']?></span><br>
</td></tr>
<tr><td bgcolor=#fb7922 colspan=1 background="img/strichel.gif" class=white><img src=img/blank.gif width=1 height=1></td></tr>
<tr valign=top><td align=right class=navi>

<a target=_parent class=n href="lang.php?en"><?=$TEXT['navi-english']?></a><br>
<a target=_parent class=n href="lang.php?de"><?=$TEXT['navi-german']?></a><br>


<p class=navi>&copy;2002/2003<br>
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

