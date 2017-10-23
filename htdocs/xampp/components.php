<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
&nbsp;<br>
<h1><?=$TEXT['components-head']?></h1>

<?=$TEXT['components-text1']?><p>
<?=$TEXT['components-text2']?><p>

<?include("softwarelist.inc");?>

<p>
<?=$TEXT['components-text3']?>

&nbsp;<p>&nbsp;<p>&nbsp;<p>
&nbsp;<p>&nbsp;<p>&nbsp;<p>

</body>
</html>
