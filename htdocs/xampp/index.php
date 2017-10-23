<?
	if(file_get_contents("lang.tmp")=="")
	{
		header("Location: splash.php");	
		exit();
	}
?>
<html>
<head>
<link REL="icon" HREF="img/xampp.ico">
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<?include("lang/".file_get_contents("lang.tmp").".php"); ?>
<title><?=$TEXT['global-xampp']?> <?include('.version');?></title>

<frameset rows="68,*" marginwidth="0" marginheight="0" frameborder="0" border="0" borderwidth="0">
    <frame name="head" src="head.php" scrolling=no>
<frameset cols="170,*" marginwidth="0" marginheight="0" frameborder="0" border="0" borderwidth="0">
    <frame name="navi" src="navi.php" scrolling=auto>
    <frame name="content" src="start.php" marginwidth=20>
</frameset>
</frameset>
</head>
<body bgcolor=#ffffff>
</body>
</html>
