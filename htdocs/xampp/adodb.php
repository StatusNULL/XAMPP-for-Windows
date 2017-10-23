<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
&nbsp;<p>
<h1><?=$TEXT['ADOdb-head']?></h1>
<?=$TEXT['ADOdb-text']?><p>
<?=$TEXT['ADOdb-example']?><p>

<?
if ($adodb=="submit")
{
 if ($dbserver=="sqlite")
	{
include_once('adodb/adodb.inc.php');
	include_once('adodb/tohtml.inc.php'); 
	$db = ADONewConnection($dbserver);
	$db->Connect($database, '0666');
	echo "<p><B>DBServer: $dbserver</B><p>";
	$result = $db->Execute("select * FROM $table");
	while (!$result->EOF) 
		{
		for ($i=0, $max=$result->FieldCount(); $i < $max; $i++)
        print $result->fields[$i].' ';
		$result->MoveNext();
		print "<br>";
		}
	}
else
{
if (($dbserver=="mysql") OR ($dbserver=="postgres7") OR ($dbserver=="ibase") OR ($dbserver=="mssql") OR ($dbserver=="borland_ibase") OR ($dbserver=="firebird") OR ($dbserver=="mssqlpo") OR ($dbserver=="maxsql") OR ($dbserver=="oci8") OR ($dbserver=="oci805") OR ($dbserver=="oci8po") OR ($dbserver=="postgres") OR ($dbserver=="oracle") OR ($dbserver=="postgres64") OR ($dbserver=="sybase"))
	{
	include_once('adodb/adodb.inc.php');
	include_once('adodb/tohtml.inc.php'); 
	$db = ADONewConnection($dbserver);
	// $db->debug = true;
	$db->Connect($host, $user, $password, $database);
	echo "<p><B>DBServer: $dbserver</B><p>";
	$result = $db->Execute("select * FROM $table");
	if ($result=="" || $result==" " || $result === false)
	{
	 print_r($TEXT['ADOdb-nottable']);
	}
	else
	{
		while (!$result->EOF) 
		{
		for ($i=0, $max=$result->FieldCount(); $i < $max; $i++)
        print $result->fields[$i].' ';
		$result->MoveNext();
		print "<br>";
		} 
	}
	}
	else
	{
	 print_r($TEXT['ADOdb-notdbserver']);
	}
}
}


?>

<? echo "<form method=\"POST\" action=\"$PHP_SELF\">"; ?>

<table width="720" cellpadding="0" cellspacing="0" border="0">
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-dbserver']?></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-host']?></td>
</tr>

<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="dbserver" size="40" value="mysql"></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="host" size="40" value="127.0.0.1"></td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-user']?></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-password']?></td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="user" size="40" value="root"></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="password" size="40" value=""></td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-database']?></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><?=$TEXT['ADOdb-table']?></td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="database" size="40" value="cdcol"></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="text" name="table" size="40" value="cds"></td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
</tr>
<tr>
    <td align=left width="10">&nbsp;</td>
	<td align=left width="350"><input type="submit" name="adodb" value="submit"></td>
	<td align=left width="10">&nbsp;</td>
	<td align=left width="350">&nbsp;</td>
</tr>
</table>


 </form>





<p>
<? if ($source=="in")
		{ include("code.php"); $beispiel = $SCRIPT_FILENAME; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} ?>



</body>
</html>
