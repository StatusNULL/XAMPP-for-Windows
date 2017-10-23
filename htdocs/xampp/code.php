<?

function pagecode($beispiel)
	{
	
		print("<p><br><br><h3><i>source code</i></h3>");
		if($beispiel=="")$beispiel=$_SERVER['PHP_SELF'];
		$f=htmlentities(file_get_contents(basename($beispiel)));
		echo "<h2>".$TEXT['global-sourcecode']."</h2>";
		echo "<form><textarea cols=80 rows=10>";
		echo $f;
		echo "</textarea></form>";
		echo "&nbsp;<p>";
		echo "&nbsp;<p>";
	} 


?>

