<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang, Carsten Wiedmann">
		<link href="xampp.css" rel="stylesheet" type="text/css">
		<title></title>
	</head>

	<body>
		<?php include "lang/".file_get_contents("lang.tmp").".php"; ?>
		&nbsp;<br>
		<h1><?php echo $TEXT['start-head']; ?> <?php include ".version"; ?></h1>
		<b><?php echo $TEXT['start-subhead']; ?></b><p>

		<?php echo $TEXT['start-text1']; ?><p>
		<?php
			if ($TEXT['start-text-newest']) {
				echo "<p>".$TEXT['start-text-newest'];
			}
		?>
		<?php echo $TEXT['start-text2']; ?><p>
		<?php echo $TEXT['start-text3']; ?><p>
		<?php echo $TEXT['start-text4']; ?><p>
		<?php echo $TEXT['start-text5']; ?><p>
		<?php echo $TEXT['start-text6']; ?>

		<?php echo "<p>&nbsp;<br><i>".getenv("SERVER_SOFTWARE")."</i><br>"; ?>
		<?php
			if (file_get_contents("lang.tmp") == "de") {
				include "lang/wisdoms-de.php";
				$zufall = mt_rand(0, 45);
				echo "<br>&nbsp;<h3><font size='2'>Eine ganz kleine Weisheit:<br><cite>".$WISDOM[$zufall]."</cite></font></h3>";
			}
		?>
	</body>
</html>
