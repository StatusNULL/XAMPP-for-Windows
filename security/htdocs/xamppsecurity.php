<? 

$host="127.0.0.1";
$timeout="1";

if ($REMOTE_ADDR)
{
	if ($REMOTE_ADDR!=$host)
	{ echo "<h2> FORBIDDEN FOR CLIENT $remoteclient <h2>"; exit; }
}

global $authphpmyadmin;
include(".\securefunctions.php");

$curdir = getcwd();
list ($partwampp, $directorwampp) = spliti ('\\\htdocs', $curdir);
$mypasswdtxt="mysqlrootpasswd.txt";
$mypasswdtxtdir=$partwampp."\security\\".$mypasswdtxt;




if (($handle = @fsockopen($host,"3306",$errno, $errstr,$timeout)) == true)
{
@fclose($handle);

if(@mysql_connect($host,"root",""))
	{
		// echo "   MySQL: The Root user have NO Password!\r\n";
		$registpasswd="no";
		mysql_close;
	}
	else
	{
		// echo "   MySQL: The Root user have a Password!\r\n";
		$registpasswd="yes";
	}
$mysqlrun=1;
}
else
{
@fclose($handle);
//  echo "MySQL is NOT running ...\r\n";
$mysqlrun=0;
} 

if ($xamppaccess)
	{
		If (ereg('^([a-zA-Z0-9@*#]{3,15})$', $xamppuser))
		{
		  $xamppereg="ok";
		}
		else
		{
		 $xamppereg="notok";
		}
		If (ereg('^([a-zA-Z0-9@*#]{3,15})$', $xampppasswd))
		{
		$xampperegpass="ok";
		}
		else
		{
		$xampperegpass="notok";;
		}
		if ($xamppereg=="ok" && $xampperegpass=="ok")
		{
		htaccess($xamppuser, $xampppasswd);
		}

	}

if ($changing)
{
	If (ereg('^([a-zA-Z0-9@*#]{3,15})$', $mypasswd))
		{
		  $mysqlpasswdereg="ok";
		}
		else
		{
		 $mysqlpasswdereg="notok";
		}
		If (ereg('^([a-zA-Z0-9@*#]{3,15})$', $mypasswdrepeat))
		{
		$remysqlpasswdereg="ok";
		}
		else
		{
		$remysqlpasswdereg="notok";;
		}
		if ($mysqlpasswdereg=="ok" && $remysqlpasswdereg=="ok")
		{
		// htaccess($xamppuser, $xampppasswd);
		} 
		if ($mypasswdold)
		{
			If (ereg('^([a-zA-Z0-9@*#]{3,15})$', $mypasswdold))
			{
			$oldmysqlpasswdereg="ok";
			}
			else
			{
			$oldmysqlpasswdereg="notok";
			}
			if ($mysqlpasswdereg=="ok" && $remysqlpasswdereg=="ok" && $oldmysqlpasswdereg=="ok")
			{
			$mysqlpassok="yes";
			}
		}
		else
		{
			if ($mysqlpasswdereg=="ok" && $remysqlpasswdereg=="ok")
			{
			$mysqlpassok="yes";
			}
		}
		if ($mysqlpassok=="yes")
		{
			if ($mypasswd!=$mypasswdrepeat)
			{ 
			}
			else
			{ 
			mysqlrootupdate($mypasswdold, $mypasswd, $mypasswdrepeat);
				if ($rootpasswdupdate=="yes")
				{
				phpmyadminstatus();	
				if ($currentstatus[0]=="cookie" || $currentstatus[0]=="http")
				{ 
					if ($currentstatus[0]==$authphpmyadmin)
					{ } 
					else
					{ changephpadminauth($authphpmyadmin, "1"); } 
					
				} 
				else { changephpadminauth($authphpmyadmin, "0"); }		
				}
			}
		}

}

?>

<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? if(file_get_contents("lang.tmp")=="")
	{
	include("lang/".file_get_contents("lang.tmp")."en.php");
	}
	else
	{
include("lang/".file_get_contents("lang.tmp").".php"); 
	}
	 ?>


<br>
<form method="POST" action="<?=$PHP_SELF?>">
<table width=600 cellpadding=0 cellspacing=0 border=0>

<tr>
  <td align=left width="600" colspan=2 align=left><hr width="80%" color="#bb3902"></td>
</tr>
<tr>
  <td align=left width="200">&nbsp;</td>
  <td align=left width="400">&nbsp;
</td>
</tr>
<tr>
  <td align=left width="600" colspan=2 align=left><h1><?=$TEXT['mysql-security-head']?></h1></td>
</tr>

<tr>
  <td align=left width="600" colspan=2 align=left><hr width="80%" color="#bb3902"></td>
</tr>
<tr>
  <td align=left width="200">&nbsp;</td>
  <td align=left width="400">&nbsp;
</td>
</tr>
<tr>
  <td align=left width="600" colspan=2 align=left><b><?=$TEXT['mysql-rootsetup-head']?></b></td>
</tr>
<tr>
  <td align=left width="600" colspan="2">
  <?
if ($changing && $mysqlpassok!="yes")
{ echo "<b><i><FONT COLOR=\"#FF3366\">".$TEXT['xampp-setup-notok']."</font></i></b>"; }
if ($changing && $mysqlpassok=="yes")
{ echo "<b><i><FONT COLOR=\"#000000\">".$TEXT['xampp-setup-ok']."</font></i></b>"; }
  ?>
  &nbsp;</td>
</tr>
<tr>
  <td align=left width="200">MySQL SuperUser:</td><td align=left width="400">

    <B>root</B>

    </td>
</tr>

<tr>
  <td align=left width="200">&nbsp;</td>
  <td align=left width="400">&nbsp;
</td>
</tr>

<? 
if ($mysqlrun==0)
{
		echo "<tr>
  <td align=left width=\"600\" colspan=\"2\"><h3><i>".$TEXT['mysql-rootsetup-notrunning']."</i></h3></td>
</tr>";
}
else
{


	if ($update=="yes")
	{
		echo "<tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr><tr>
  <td align=left width=\"600\" colspan=\"2\"><FONT COLOR=\"#0000A0\"> <b>".$TEXT['mysql-rootsetup-passwdsuccess']."<br>
  <br>$mypasswdtxtdir"; 
  if ($phpmyadminconfsafe)
		{ echo "<br>$phpmyadminconfsafe"; }

  
  echo "</font></b></td>
</td>
</tr>
	  <tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr>";
	}
if ($update=="no")
	{
		echo "<tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr><tr>
  <td align=left width=\"600\" colspan=\"2\"><h3><i>".$TEXT['mysql-rootsetup-passwdnosuccess']."</i></h3></td>
</td>
</tr>
	  <tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr>";
	}
	if ($mypasswdok=="null")
	{
		echo "<tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr><tr>
  <td align=left width=\"600\" colspan=\"2\"><h3><i>".$TEXT['mysql-rootsetup-passwdnull']."</i></h3></td>
</td>
</tr>
	  <tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr>";
	}
	if ($mypasswdok=="no")
	{
		echo "<tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr><tr>
  <td align=left width=\"600\" colspan=\"2\"><h3><i>".$TEXT['mysql-rootsetup-passwdnotok']."</i></h3></td>
</td>
</tr>
	  <tr>
  <td align=left width=\"200\">&nbsp;</td>
  <td align=left width=\"400\">&nbsp;</td>
</tr>";
	}
	if ($registpasswd=="yes")
	{
	echo "<tr>
  <td align=left width=\"200\">".$TEXT['mysql-rootsetup-passwdold']."</td>
  <td align=left width=\"400\"><input type=\"password\" name=\"mypasswdold\" size=\"40\">
</td>
</tr>";
	}
	



echo "<tr>
  <td align=left width=\"200\">".$TEXT['mysql-rootsetup-passwd']."</td>
  <td align=left width=\"400\"><input type=\"password\" name=\"mypasswd\" size=\"40\">
</td>
</tr>
 
  <tr>
    <td align=left width=\"200\">".$TEXT['mysql-rootsetup-passwdrepeat']."</td>
    <td align=left width=\"400\"><input type=\"password\" name=\"mypasswdrepeat\" size=\"40\">
</td>

  </tr>
 
  <tr>
    <td align=left width=\"200\">&nbsp;</td><td align=center width=\"400\">&nbsp;</td>
  </tr>";
  if ($authphpmyadmin)
	{ if ($authphpmyadmin=="cookie")
	   { $checkedcookie="checked"; } else { $checkedhttpd="checked"; } }
	else {
   phpmyadminstatus();
   if ($currentstatus[0]=="cookie")
	   { $checkedcookie="checked"; } else { $checkedhttpd="checked"; } }


	  echo "<tr>
    <td align=left width=\"200\">".$TEXT['mysql-rootsetup-phpmyadmin']."</td><td align=left width=\"400\"><I>http</I> <input type=\"radio\" value=\"http\" $checkedhttpd name=\"authphpmyadmin\">&nbsp;&nbsp;<I>cookie</I> <input type=\"radio\" value=\"cookie\" $checkedcookie name=\"authphpmyadmin\">  
	 </td>
  </tr>
 
	 <tr>
    <td align=left width=\"200\">&nbsp;</td><td align=center width=\"400\">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width=\"200\">&nbsp;</td><td align=left width=\"400\"><input type=submit value=\"".$TEXT['mysql-rootsetup-passwdchange']."\" name=\"changing\"></td>
  </tr>";
}
	echo "<tr>
    <td align=left width=\"200\">&nbsp;</td><td align=center width=\"400\">&nbsp;</td>
  </tr>
		  <tr>
    <td align=left width=\"600\" colspan=2><hr width=\"80%\" color=\"#bb3902\"></td>
  </tr>
		  <tr>
    <td align=left width=\"600\" colspan=2>&nbsp;";
	 If ($xamppereg=="notok" || $xampperegpass=="notok")
	{ echo "<b><i><FONT COLOR=\"#FF3366\">".$TEXT['xampp-setup-notok']."</font></i></b>"; }
	 If ($xamppdirconfig=="notok")
	{ echo "<b><i><FONT COLOR=\"#FF3366\">".$TEXT['xampp-config-notok']."</font></i></b>"; }
	 If ($xamppdirconfig=="ok")
	{ echo "<b><FONT COLOR=\"#0000A0\">".$TEXT['xampp-config-ok']."$xapasswdtxtdir<br>$htpasswddirectory<br>$htxampp</font></b><bR><br>"; }
	 echo "&nbsp;</td>
  </tr>
		  <tr>
    <td align=left width=\"600\" colspan=2><b>".$TEXT['xampp-setup-head']."</b></td>
  </tr>
		   <tr>
    <td align=left width=\"200\">&nbsp;</td><td align=center width=\"400\">&nbsp;</td>
  </tr>
		 <tr>
  <td align=left width=\"200\">".$TEXT['xampp-setup-user']."</td>
  <td align=left width=\"400\"><input type=\"text\" name=\"xamppuser\" size=\"40\">
</td>
</tr>
	  <tr>
  <td align=left width=\"200\">".$TEXT['xampp-setup-passwd']."</td>
  <td align=left width=\"400\"><input type=\"password\" name=\"xampppasswd\" size=\"40\">
</td>
</tr>
		   <tr>
    <td align=center width=\"600\" colspan=2>&nbsp;</td>
  </tr>
		  <tr>
    <td align=left width=\"200\">&nbsp;</td><td align=left width=\"400\"><input type=submit value=\"".$TEXT['xampp-setup-start']."\" name=\"xamppaccess\"></form></td>
  </tr>
  </table>
</form>";
?>

</body>
</html>
