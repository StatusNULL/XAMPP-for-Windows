<html>
<head>
<meta name="author" content="Kay Vogelgesang, Kai Oswald Seidler">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
&nbsp;<br>
<h1><?=$TEXT['start-head']?> <?include(".version")?></h1>
<b><?=$TEXT['start-subhead']?></b><p>

<?=$TEXT['start-text1']?><p>
<?=$TEXT['start-text2']?><p>
<?=$TEXT['start-text3']?><p>
<?=$TEXT['start-text4']?><p>
<?=$TEXT['start-text5']?><p>
<?=$TEXT['start-text6']?>
<? echo "<p>&nbsp;<br><i>".getenv("SERVER_SOFTWARE")."</i><br>"; ?>

</body>
</html>
