<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
&nbsp;<p>

<h1><?=$TEXT['status-head']?></h1>

<?=$TEXT['status-text1']?><p>

<?php
	
	$i=0;

	$up="";

       if($GLOBALS['SERVER_PORT']==443)
                $prot="https";
        else
                $prot="http";

	if($PHP_AUTH_USER)
		$up="$PHP_AUTH_USER:$PHP_AUTH_PW@";
	$b="$prot://$up".$GLOBALS['SERVER_NAME'];
	if($GLOBALS['SERVER_PORT']!=80)
	{
		$b="$prot://$up".$GLOBALS['SERVER_NAME'].".:".$GLOBALS['SERVER_PORT'];
	}
	function line($text,$status,$link="")
	{
		global $i,$TEXT;

		if($i>0)
		{
			echo "<tr valign=bottom>";
			echo "<td bgcolor=#ffffff background='img/strichel.gif' colspan=5><img src=img/blank.gif width=1 height=1></td>";
			echo "</tr>";
		}
		echo "<tr bgcolor=#ffffff>";
		echo "<td bgcolor=#ffffff><img src=img/blank.gif width=1 height=20></td>";
		echo "<td class=tabval>";
		echo "$text";
		echo "</td>";
		if(trim($status)=="OK"){ 
			echo "<td><span class=green>&nbsp;".$TEXT['status-ok']."&nbsp;</span></td>";
			echo "<td></td>";
			$i++;
		 }
		else 
		{
			echo "<td><span class=red>&nbsp;".$TEXT['status-nok']."&nbsp;</span></td>";
			if($link=="")
				echo "<td></td>";
			else
				echo "<td><a target=faq href='$link'><span style='font-size: 10pt'>".$TEXT['status-lookfaq']."</span></a></td>";
		}
		echo "<td bgcolor=#ffffff><img src=img/blank.gif width=1 height=1></td>";
		echo "</tr>";
		$i++;
	}


	$a=@file("$b/xampp/php.php");
	$php=$a[0];
	$a=@file("$b/xampp/mysql.php");
	$mysql=$a[0];
	$a=@file("$b/cgi-bin/cgi.cgi");
	$cgi=$a[0];
	$a=@file("$b/xampp/ssi.shtml");
	$ssi=$a[0];
	$a=@file("$b/modperl/perl.pl");
	$perl=$a[0];

	if(extension_loaded('Turck MMCache'))
		$mmcache="OK";
	else
		$mmcache="NOK";

		$host = "127.0.0.1";
		$timeout= 1;
	
		if (($handle = @fsockopen($host, 110, $errno, $errstr, $timeout)) == false)
		$smtp="NOK";
		else
		$smtp="OK";
		@fclose($handle);

		if (($handle = @fsockopen($host, 21, $errno, $errstr, $timeout)) == false)
		$ftp="NOK";
		else
		$ftp="OK";
		@fclose($handle);


	/* if(extension_loaded('oci8'))
		$oci8="OK";
	else
		$oci8="NOK"; */
	

	echo '<table border=0 cellpadding=0 cellspacing=0>';
	echo "<tr valign=top>";
	echo "<td bgcolor=#fb7922 valign=top><img src=img/blank.gif width=10 height=0></td>";
	echo "<td bgcolor=#fb7922 class=tabhead><img src=img/blank.gif width=250 height=6><br>".$TEXT['status-tab1']."</td>";
	echo "<td bgcolor=#fb7922 class=tabhead><img src=img/blank.gif width=100 height=6><br>".$TEXT['status-tab2']."</td>";
	echo "<td bgcolor=#fb7922 class=tabhead><img src=img/blank.gif width=100 height=6><br>".$TEXT['status-tab3']."</td>";
	echo "<td bgcolor=#fb7922 valign=top><br><img src=img/blank.gif width=1 height=10></td>";
	echo "</tr>";
	line($TEXT['status-mysql'],$mysql);
	line($TEXT['status-php'],$php);
	line($TEXT['status-perl'],$perl);
	line($TEXT['status-cgi'],$cgi);
	line($TEXT['status-ssi'],$ssi);
	line($TEXT['status-mmcache'],$mmcache,$TEXT['status-mmcache-url']);
	line($TEXT['status-smtp'],$smtp);
	line($TEXT['status-ftp'],$ftp);
	// line($TEXT['status-oci8'],$oci8,$TEXT['status-oci8-url']);

	echo "<tr valign=bottom>";
	echo "<td bgcolor=#fb7922></td>";
	echo "<td bgcolor=#fb7922 colspan=3><img src=img/blank.gif width=1 height=8></td>";
	echo "<td bgcolor=#fb7922></td>";
	echo "</tr>";
	echo "</table>";

	echo "<p>";


?>
<?=$TEXT['status-text2']?><p>

<? if ($source=="in")
		{ include("code.php"); $beispiel = $SCRIPT_FILENAME; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} ?>
</body>
</html>
