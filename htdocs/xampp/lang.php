<?
	$fp=fopen("lang.tmp","w");
	fwrite($fp,$_SERVER['QUERY_STRING']);
	fclose($fp);
	header("Location: index.php");
?>
