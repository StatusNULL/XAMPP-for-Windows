<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

&nbsp;<p>
<h1><?=$TEXT['flash-head']?></h1>

<? if($text=="")$text = "ceci n est pas un ami d apache"; ?>
	
<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
  codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,0,0" 
  width=520 height=320>
<PARAM name="Movie" value="winming_ok.php?text=<?=urlencode($text)?>">
<PARAM name="loop" value="true">
<EMBED src="mingswf.php?text=<?=urlencode($text)?>" width=520 height=320
  pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" LOOP=TRUE>
</EMBED>
</OBJECT>

<p class=small>
<?=$TEXT['flash-text1']?>
<p>
<?
if ($source=="in")
		{ include("code.php"); $beispiel = "winming_ok.php"; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");}
		?>


</body>
</html>
