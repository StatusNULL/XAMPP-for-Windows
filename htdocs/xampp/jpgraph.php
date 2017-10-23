<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

&nbsp;<p>
<h1><?=$TEXT['jpgraph-head']?></h1>
<br>&nbsp;<br>

<A HREF="/jpgraph/Examples/"><IMG SRC="/jpgraph/Examples/alphabarex1.php" border="0" alt= " Examples! "></A>
<br>&nbsp;<br>
<?=$TEXT['jpgraph-url']?>

<? if ($source=="in")
		{ include("code.php"); $beispiel = $SCRIPT_FILENAME; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} ?>
</body>
</html>
