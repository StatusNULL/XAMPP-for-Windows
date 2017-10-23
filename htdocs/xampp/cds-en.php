<?      
        if($action=="getpdf")
        {       
                mysql_connect("localhost","root","");
                mysql_select_db("cdcol");

                include 'class.ezpdf.php';
                $pdf =& new Cezpdf();
                $pdf->selectFont('../pdf/fonts/Helvetica');
                
                $pdf->ezText('CD Collection v0.2',14);
                $pdf->ezText('© 2002/2003 Kai Seidler, oswald@apachefriends.org, GPL',10);
                $pdf->ezText('',12);
                
                $result=mysql_query("SELECT id,titel,interpret,jahr FROM cds ORDER BY interpret;");
                
                $i=0;
                while( $row=mysql_fetch_array($result) )
                {       
                        $data[$i]=array('artist'=>$row['interpret'],'title'=>$row['titel'],'year'=>$row['jahr']);
                        $i++;
                }
                
                $pdf->ezTable($data,"","",array('xPos'=>'left','xOrientation'=>'right','width'=>500));
                
                $pdf->ezStream();

        }
?>

<html>
<head>
<title>apachefriends.org cd collection v0.2</title>
<link href="xampp2.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor=#ffffff>
&nbsp;<p>
<h1>CD Collection v0.2 (with PHP+MySQL+PDF Class)</h1>

A very simple CD software. It's only an example!!! :)<p>

<b>New since 0.9.6 (win32 since 1.0):</b> CD output in <a href="<?=$PHP_SELF?>?action=getpdf">PDF</a>.

<?

//    Copyright (C) 2002/2003 Kai Seidler, oswald@apachefriends.org
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


	if(!mysql_connect("localhost","root",""))
	{
		echo "<h2>Kann die Datenbank nicht erreichen!<br>Läuft MySQL? Das Passwort geändert?</h2>";
		die();
	}
	mysql_select_db("cdcol");
?>

<h2>My CDs</h2>

<table width=10% border=0 cellpadding=0 cellspacing=0>
<tr>
<td class=h><img src=img/blank.gif width=200 height=1><br>&nbsp;<b>Artist</b></td>
<td class=h><img src=img/blank.gif width=200 height=1><br><b>Title</b></td>
<td class=h><img src=img/blank.gif width=50 height=1><br><b>Year</b></td>
<td></td>
</tr>


<?
        echo "<tr><td bgcolor=#acacc9 colspan=3><img src=img/blank.gif width=1 height=2></td>";
        echo "<td><img src=img/blank.gif width=1 height=1></td>";
        echo "<td bgcolor=#acacc9><img src=img/blank.gif width=1 height=1></td>";
        echo "</tr>";

	if($interpret!="")
	{
		if($jahr=="")$jahr="NULL";
		mysql_query("INSERT INTO cds (titel,interpret,jahr) VALUES('$titel','$interpret',$jahr);");
	}

	if($action=="del")
	{
		mysql_query("DELETE FROM cds WHERE id=$id;");
	}

	$result=mysql_query("SELECT id,titel,interpret,jahr FROM cds ORDER BY interpret;");
	
	$i=0;
	while( $row=mysql_fetch_array($result) )
	{
		echo "<tr>";
		echo "<td class=d>&nbsp;<b>".$row['interpret']."</b></td>";
		echo "<td class=d>".$row['titel']."&nbsp;</td>";
		echo "<td class=d>".$row['jahr']."&nbsp;</td>";
	     	echo "<td><img src=img/blank.gif width=1 height=1></td>";
                echo "<td bgcolor=#7c7c99><img src=img/blank.gif width=2 height=1></td>";
                echo "<td><img src=img/blank.gif width=1 height=1></td>";
                echo "<td bgcolor=#7c7c99><img src=img/blank.gif width=1 height=1></td>";
                echo "<td><img src=img/blank.gif width=5 height=1></td>";

		echo "<td><a onclick=\"return confirm('Wirklich sicher?');\" href=cds.php?action=del&id=".$row['id']."><img border=0 src=img/deletecd.gif></a></td>";
		echo "</tr>";
		echo "<tr><td bgcolor=#acacc9 colspan=3><img src=img/blank.gif width=1 height=1></td>";
		echo "<td><img src=img/blank.gif width=1 height=1></td>";
		echo "<td bgcolor=#acacc9><img src=img/blank.gif width=1 height=1></td>";
		echo "</tr>";
	}

?>

</table>

<h2>Add a CD</h2>

<form action=cds.php method=get>
<table border=0 cellpadding=0 cellspacing=0>
<tr><td>Artist:</td><td><input type=text size=30 name=interpret></td></tr>
<tr><td>Title:</td><td> <input type=text size=30 name=titel></td></tr>
<tr><td>Year:</td><td> <input type=text size=5 name=jahr></td></tr>
<tr><td></td><td><input type=image src=img/addcd.gif border=0 value="Add CD"></td></tr>
</table>
</form>

&nbsp;
<p class=small>
Author: Kai 'Oswald' Seidler<br>
For xampp win32: Kay Vogelgesang<br>
Last modification: December 3rd 2002<br>
&copy; 2002/2003 apachefriends.org
</body>
</html>
