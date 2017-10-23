<?php
	if (file_get_contents("lang.tmp") == "") {
		if (!empty($_SERVER['HTTPS']) && ('on' == $_SERVER['HTTPS'])) {
			$uri = 'https://';
		} else {
			$uri = 'http://';
		}
		$uri .= $_SERVER['HTTP_HOST'];
		header('Location: '.$uri.'/xampp/splash.php');
		exit;
	}

	include "langsettings.php";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
	"http://www.w3.org/TR/html4/frameset.dtd">
<html>
	<head>
		<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang, Carsten Wiedmann">
		<link rel="icon" href="img/xampp.ico">
		<title><?php echo $TEXT['global-xampp']; ?> <?php include '.version'; ?></title>
	</head>

	<frameset rows="68,*" border="0" framespacing="0">
		<frame name="head" src="head.php" frameborder="0" scrolling="no">
		<frameset cols="175,*" border="0" framespacing="0">
			<frame name="navi" src="navi.php" frameborder="0" scrolling="auto">
			<frame name="content" src="start.php" frameborder="0" marginwidth="20">
		</frameset>
	</frameset>
</html>
