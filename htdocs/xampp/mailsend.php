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

		&nbsp;<p>
		<h1><?php echo $TEXT['mail-sendnow']; ?></h1><p>
		<table>
			<tr>
				<td>&nbsp;<p>
					<?php
						if (empty($_POST['knownsender'])) {
							$_POST['knownsender'] = '';
						}
						if (empty($_POST['recipients'])) {
							$_POST['recipients'] = '';
						}
						if (empty($_POST['ccaddress'])) {
							$_POST['ccaddress'] = '';
						}
						if (empty($_POST['subject'])) {
							$_POST['subject'] = '';
						}
						if (empty($_POST['message'])) {
							$_POST['message'] = '';
						}
						$mailtos = $_POST['recipients'];
						$subject = $_POST['subject'];
						$message = $_POST['message'];

						if (($_POST['ccaddress'] == "") || ($_POST['ccaddress'] == " ")) {
							$header = "From: $_POST[knownsender]";
						} else {
							$header .= "From: $_POST[knownsender]\r\n";
							$header .= " Cc: $_POST[ccaddress]";
						}

						if (@mail($mailtos, $subject, $message, $header)) {
							echo "<i>".$TEXT['mail-sendok']."</i>";
						} else {
							echo "<i>".$TEXT['mail-sendnotok']."</i>";
						}
					?>
				</td>
			</tr>
			<tr>
				<td>&nbsp;<p>&nbsp;<p>&nbsp;<p>
					<a href="javascript:history.back()">Zur�ck zum Formular</a>
				</td>
			</tr>
		</table>
	</body>
</html>
