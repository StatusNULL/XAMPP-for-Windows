<?php
	if (isset($_GET['action']) && ($_GET['action'] == "getpdf")) {
		include "lang/".file_get_contents("lang.tmp").".php";
		if (file_exists('../../security/mysqlrootpasswd.txt')) {
			$rootpasswdfile = file('../../security/mysqlrootpasswd.txt');
			$rootpasswd = trim(strrchr($rootpasswdfile[1], ' '));
		} else {
			$rootpasswd = '';
		}
		if (!@mysql_connect("localhost", "root", $rootpasswd)) {
			echo "<h2>".$TEXT['cds-error']."</h2>";
			die;
		}
		mysql_select_db("cdcol");

		include 'fpdf/fpdf.php';
		$pdf = new FPDF();

		$pdf->SetCreator('Apache Friends');
		$pdf->SetSubject('XAMPP for Windows');
		$pdf->SetTitle($TEXT['cds-head1']);

		$pdf->SetTextColor(0);
		$pdf->SetDrawColor(0);
		$pdf->SetFillColor(255);

		$pdf->SetMargins(25, 25, 25);
		$pdf->SetAutoPageBreak(true, 25);
		$pdf->AddPage();

		$pdf->SetFont('Helvetica', '', 14);
		$pdf->Cell(160, 6, $TEXT['cds-head1'], 0, 0, 'C', 1);
		$pdf->Ln(6);
		$pdf->SetFont('Helvetica', '', 8);
		$pdf->Cell(160, 7, '© 2002/2005 Apache Friends <http://www.apachefriends.org/>, GPL', 0, 0, 'C', 1);
		$pdf->Ln(14);

		$pdf->SetFont('Helvetica', '', 12);
		$header = array($TEXT['cds-attrib1'], $TEXT['cds-attrib2'], $TEXT['cds-attrib3'], $TEXT['cds-attrib4']);
		foreach ($header as $col) {
			$pdf->Cell(40, 7, $col, 1, 0, 'C', 1);
		}
		$pdf->Ln(7);

		$result = mysql_query("SELECT `id`, `titel`, `interpret`, `jahr` FROM `cds` ORDER BY `interpret`");
		while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
			foreach ($row as $col) {
				$pdf->Cell(40, 6, $col, 1, 0, 'L', 1);
			}
			$pdf->Ln((6));
		}

		$pdf->Output();
		exit;
	}
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
		<?php include "lang/".file_get_contents("lang.tmp").".php"; ?>

		&nbsp;<p>
		<h1><?php echo $TEXT['cds-head']; ?></h1>

		<?php echo $TEXT['cds-text1']; ?><p>
		<?php echo $TEXT['cds-text2']; ?><p>

		<?php
			// Copyright (C) 2002/2003 Kai Seidler <oswald@apachefriends.org>
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

			if (file_exists('../../security/mysqlrootpasswd.txt')) {
				$rootpasswdfile = file('../../security/mysqlrootpasswd.txt');
				$rootpasswd = trim(strrchr($rootpasswdfile[1], ' '));
			} else {
				$rootpasswd = '';
			}
			if (!@mysql_connect("localhost", "root", $rootpasswd)) {
				echo "<h2>".$TEXT['cds-error']."</h2>";
				die;
			}
			mysql_select_db("cdcol");
		?>

		<h2><?php echo $TEXT['cds-head1']; ?></h2>

		<table border="0" cellpadding="0" cellspacing="0">
			<tr bgcolor="#f87820">
				<td><img src="img/blank.gif" alt="" width="10" height="25"></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="200" height="6"><br><b><?php echo $TEXT['cds-attrib1']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="200" height="6"><br><b><?php echo $TEXT['cds-attrib2']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="50" height="6"><br><b><?php echo $TEXT['cds-attrib3']; ?></b></td>
				<td class="tabhead"><img src="img/blank.gif" alt="" width="50" height="6"><br><b><?php echo $TEXT['cds-attrib4']; ?></b></td>
				<td><img src="img/blank.gif" alt="" width="10" height="25"></td>
			</tr>

			<?php
				if (!empty($_GET['interpret'])) {
					if (empty($_GET['jahr']) == "") {
						$jahr = "NULL";
					}
					mysql_query("INSERT INTO `cds` (`titel`, `interpret`, `jahr`) VALUES('$_GET[titel]', '$_GET[interpret]', $_GET[jahr])");
				}

				if (isset($_GET['action']) && ($_GET['action'] == "del")) {
					mysql_query("DELETE FROM `cds` WHERE `id` = $_GET[id]");
				}

				$result = mysql_query("SELECT `id`, `titel`, `interpret`, `jahr` FROM `cds` ORDER BY `interpret`");

				$i = 0;
				while ($row = mysql_fetch_array($result)) {
					if ($i > 0) {
						echo "<tr valign='bottom'>";
						echo "<td bgcolor='#ffffff' height='1' style='background-image:url(img/strichel.gif)' colspan='6'></td>";
						echo "</tr>";
					}
					echo "<tr valign='middle'>";
					echo "<td class='tabval'><img src='img/blank.gif' alt='' width='10' height='20'></td>";
					echo "<td class='tabval'><b>".$row['interpret']."</b></td>";
					echo "<td class='tabval'>".$row['titel']."&nbsp;</td>";
					echo "<td class='tabval'>".$row['jahr']."&nbsp;</td>";

					echo "<td class='tabval'><a onclick=\"return confirm('".$TEXT['cds-sure']."');\" href='cds.php?action=del&amp;id=".$row['id']."'><span class='red'>[".$TEXT['cds-button1']."]</span></a></td>";
					echo "<td class='tabval'></td>";
					echo "</tr>";
					$i++;
				}

				echo "<tr valign='bottom'>";
				echo "<td bgcolor='#fb7922' colspan='6'><img src='img/blank.gif' alt='' width='1' height='8'></td>";
				echo "</tr>";
			?>
		</table>

		<h2><?php echo $TEXT['cds-head2']; ?></h2>

		<form action="cds.php" method="get">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr><td><?php echo $TEXT['cds-attrib1']; ?>:</td><td> <input type="text" size="30" name="interpret"></td></tr>
				<tr><td><?php echo $TEXT['cds-attrib2']; ?>:</td><td> <input type="text" size="30" name="titel"></td></tr>
				<tr><td><?php echo $TEXT['cds-attrib3']; ?>:</td><td> <input type="text" size="5" name="jahr"></td></tr>
				<tr><td></td><td><input type="submit" value="<?php echo $TEXT['cds-button2']; ?>"></td></tr>
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
