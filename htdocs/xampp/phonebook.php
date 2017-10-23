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
		<h1><?php echo $TEXT['phonebook-head']; ?></h1>

		<?php echo $TEXT['phonebook-text1']; ?><p>

		<?php
			// Copyright (C) 2003 Kai Seidler <oswald@apachefriends.org>
			//
			// This program is free software; you can redistribute it and/or modify
			// it under the terms of the GNU General Public License as published by
			// the Free Software Foundation; either version 2 of the License, or
			// (at your option) any later version.
			//
			// This program is distributed in the hope that it will be useful,
			// but WITHOUT ANY WARRANTY; without even the implied warranty of
			// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
			// GNU General Public License for more details.
			//
			// You should have received a copy of the GNU General Public License
			// along with this program; if not, write to the Free Software
			// Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

			if (!($db = sqlite_open('sqlite/phonebook', '0666'))) {
				echo "<h2>".$TEXT['phonebook-error']."</h2>";
				die;
			}
		?>

		<h2><?php echo $TEXT['phonebook-head1']; ?></h2>

		<table border="0" cellpadding="0" cellspacing="0">
			<tr bgcolor="#f87820">
				<td><img src="img/blank.gif" alt="" width="10" height="25"></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="150" height="6"><br><b><?php echo $TEXT['phonebook-attrib1']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="150" height="6"><br><b><?php echo $TEXT['phonebook-attrib2']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="150" height="6"><br><b><?php echo $TEXT['phonebook-attrib3']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="50" height="6"><br><b><?php echo $TEXT['phonebook-attrib4']; ?></b></td>
				<td><img src="img/blank.gif" alt="" width="10" height="25"></td>
			</tr>

			<?php
				if (!empty($_GET['firstname'])) {
					if (empty($_GET['lastname'])) {
						$_GET['lastname'] = '';
					}
					if (empty($_GET['phone'])) {
						$_GET['phone'] = '';
					}
					sqlite_query($db, "INSERT INTO users (firstname, lastname, phone) VALUES('$_GET[firstname]', '$_GET[lastname]', '$_GET[phone]')");
				}

				if (isset($_GET['action']) && ($_GET['action'] == "del")) {
					sqlite_query($db, "DELETE FROM users WHERE id = $_GET[id]");
				}

				$result = sqlite_query($db, "SELECT id, firstname, lastname, phone FROM users ORDER BY lastname");

				$i = 0;
				while ($row = sqlite_fetch_array($result)) {
					if ($i > 0) {
						echo "<tr valign='bottom'>";
						echo "<td bgcolor='#ffffff' height='1' style='background-image:url(img/strichel.gif)' colspan='6'></td>";
						echo "</tr>";
					}
					echo "<tr valign='middle'>";
					echo "<td class='tabval'><img src='img/blank.gif' alt='' width='10' height='20'></td>";
					echo "<td class='tabval'><b>".$row['lastname']."</b></td>";
					echo "<td class='tabval'>".$row['firstname']."&nbsp;</td>";
					echo "<td class='tabval'>".$row['phone']."&nbsp;</td>";

					echo "<td class='tabval'><a onclick=\"return confirm('".$TEXT['phonebook-sure']."');\" href='phonebook.php?action=del&amp;id=".$row['id']."'><span class='red'>[".$TEXT['phonebook-button1']."]</span></a></td>";
					echo "<td class='tabval'></td>";
					echo "</tr>";
					$i++;
				}

				echo "<tr valign='bottom'>";
				echo "<td bgcolor='#fb7922' colspan='6'><img src='img/blank.gif' alt='' width='1' height='8'></td>";
				echo "</tr>";

				sqlite_close($db);
			?>

		</table>

		<h2><?php echo $TEXT['phonebook-head2']; ?></h2>

		<form action="phonebook.php" method="get">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr><td><?php echo $TEXT['phonebook-attrib1']; ?>:</td><td><input type="text" size="20" name="lastname"></td></tr>
			<tr><td><?php echo $TEXT['phonebook-attrib2']; ?>:</td><td> <input type="text" size="20" name="firstname"></td></tr>
			<tr><td><?php echo $TEXT['phonebook-attrib3']; ?>:</td><td> <input type="text" size="20" name="phone"></td></tr>
			<tr><td></td><td><input type="submit" value="<?php echo $TEXT['phonebook-button2']; ?>"></td></tr>
			</table>
		</form>
		<p>
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
