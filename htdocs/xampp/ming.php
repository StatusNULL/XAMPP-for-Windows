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
		&nbsp;<p>
		<h1><?php echo $TEXT['flash-head']; ?></h1>

		<?php
			if (empty($_GET['text'])) {
				$_GET['text'] = "ceci n est pas un ami d apache";
			}
		?>

		<object data="mingswf.php?text=<?php echo urlencode($_GET['text']); ?>" width="520" height="320" type="application/x-shockwave-flash">
			<param name="movie" value="mingswf.php?text=<?php echo urlencode($_GET['text']); ?>">
			<param name="loop" value="true">
            <a href="http://www.macromedia.com/go/getflashplayer"><img src="http://www.macromedia.com/images/shared/download_buttons/get_flash_player.gif" width="88" height="31" alt="get flash player" title=""></a>
		</object>

		<p class="small">
	<A HREF="http://ming.sourceforge.net" target="new">http://ming.sourceforge.net</A>
		<p>
		<form name="ff" action="ming.php" method="get">
			<input type="text" name="text" value="<?php echo $_GET['text']; ?>" size="30">
			<input type="submit" value="<?php echo $TEXT['flash-ok']; ?>">
		</form>
		<?php
			if (isset($_GET['source']) && ($_GET['source'] == "in")) {
				include "code.php";
				$beispiel = $_SERVER['SCRIPT_FILENAME'];
				pagecode($beispiel);
			} else {
				echo "<p><br><br><h2><u><a href=\"$_SERVER[PHP_SELF]?source=in\">".$TEXT['srccode-in']."</a></u></h2>";
			}
		?>
	</body>
</html>
