<?php
	include "langsettings.php";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang, Carsten Wiedmann">
		<link href="xampp.css" rel="stylesheet" type="text/css">
		<title></title>
	</head>

	<body>
		&nbsp;<br>
		<h1><?php echo $TEXT['start-head']; ?> <?php include ".version"; ?></h1>
		<b><?php echo $TEXT['start-subhead']; ?></b><p>

		<?php echo $TEXT['start-text1']; ?><p>
		
		<?php echo $TEXT['start-text2']; ?><p>
		<?php echo $TEXT['start-text3']; ?><p>
		<?php echo $TEXT['start-text4']; ?><p>
		<?php echo $TEXT['start-text5']; ?><p>
		<?php echo $TEXT['start-text6']; ?>

		<?php echo "<p>&nbsp;<br><i>".getenv("SERVER_SOFTWARE")."</i><br>"; ?>
		
	</body>
</html>
