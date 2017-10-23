<?php

function mysqlrootupdate($currentpass, $newpass, $renewpass)
{
	$curdir = getcwd();
	list ($partwampp, $directorwampp) = spliti ('\\\htdocs', $curdir);
	$mypasswdtxt="mysqlrootpasswd.txt";
	$mypasswdtxtdir=$partwampp."\security\\".$mypasswdtxt;
	$dir=$partwampp."\security\\";
	// if ($currentpass=="")
	global $rootpasswdupdate;
	global $update;
	if (@mysql_connect("localhost","root","$currentpass"))
	{
	mysql_select_db("mysql");
	$update="yes";
	mysql_query("UPDATE user SET password = PASSWORD( '$newpass' ) WHERE `User` = 'root'");
	// UPDATE `user` SET `User` = 'testuser', `password` = PASSWORD( 'birdbird' ) WHERE `Host` = 'localhost' AND `User` = 'tefstuser' LIMIT 1 ;
	mysql_close;
	
	$dh = @opendir($dir);
	if ($dh)
	{ } else { system("md $dir"); } 


	$datei = fopen($mypasswdtxtdir,'w+');
	$put="mysql user = root\r\nmysql password = $newpass";
	fputs($datei, $put);
	fclose($datei);
	$rootpasswdupdate="yes";				
	}
	else
	{
	$rootpasswdupdate="no";
	} 
}


function phpmyadminstatus()
{
global $currentstatus;
global $authzeile;
global $notfind;

$curdir = getcwd();
list ($partwampp, $directorwampp) = spliti ('\\\htdocs', $curdir);
$configinc="config.inc.php";
$phpmyadminconf=$partwampp."\phpmyadmin\\".$configinc;

if (file_exists($phpmyadminconf)) 
{
	$datei = fopen($phpmyadminconf,'r');
	$i=0;
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$oldzeile[]=$zeile; 
	list ($left, $right) = split ('=', $zeile);
	if (preg_match("/'auth_type'/i", $left))
		{ 
		if (preg_match("/'http'/i", $right))
			{ $currentstatus[]="http"; $authzeile[]=$i; } 
		elseif (preg_match("/'cookie'/i", $right))
			{ $currentstatus[]="cookie"; $authzeile[]=$i; } 
		else { $currentstatus[]="null"; $authzeile[]=$i; }
	
		}	
	$i++;
	}
	fclose($datei); 
}
else
	{
	$notfind=1;
	}
}



function changephpadminauth($phpmyadminauth, $myupdate)
{
global $phpmyadminconfsafe;
$curdir = getcwd();
list ($partwampp, $directorwampp) = spliti ('\\\htdocs', $curdir);
$configinc="config.inc.php";
$phpmyadminconf=$partwampp."\phpmyadmin\\".$configinc;

if (file_exists($phpmyadminconf)) 
{
	$datei = fopen($phpmyadminconf,'r');
	$i=0;
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$oldzeile[]=$zeile; 
	list ($left, $right) = split ('=', $zeile);
	if (preg_match("/'auth_type'/i", $left))
		{ 
		if (preg_match("/'http'/i", $right))
			{ $currentstatus[]="http"; $authzeile[]=$i; } 
		elseif (preg_match("/'cookie'/i", $right))
			{ $currentstatus[]="cookie"; $authzeile[]=$i; } 
		else { $currentstatus[]="null"; $authzeile[]=$i; }
	
		}	
	$i++;
	}
	fclose($datei); 
	}
	else
	{
	$notfind=1;
	}

$mynewzeile="\$cfg['Servers'][\$i]['auth_type']     = '$phpmyadminauth';      // Authentication method (config, http or cookie based)\n";


	if (file_exists($phpmyadminconf)) 
	{
		If ($currentstatus[0]=="null" || $myupdate=="1")
		{
		copy($phpmyadminconf, $phpmyadminconf.'.safe');
		$phpmyadminconfsafe=$partwampp."\phpmyadmin\\".$configinc.".safe";
		$phpmyadminauth="http";
		$datei = fopen($phpmyadminconf,'w+'); 			
			if($datei) 
            {
			for($z=0;$z<$i+1;$z++) 
                {
				if ($authzeile[0]==$z)
					{
					fputs($datei,$mynewzeile);
					}
					else
					{
					fputs($datei,$oldzeile[$z]);
					}
				}
			}
		}
	}	
}


function htaccess($xauser, $xapasswd)
{	
	global $xamppdirconfig;
	global $xapasswdtxtdir;
	global $htpasswddir;
	global $htpasswddirectory;
	global $htxampp;
	$curdir = getcwd();
	list ($partwampp, $directorwampp) = spliti ('\\\htdocs', $curdir);
	$htaccess=".htaccess";
	$xapasswdtxt="xamppdirpasswd.txt";
	$htpasswd="xampp.users";
	$xapasswdtxtdir=$partwampp."\security\\".$xapasswdtxt;
	$curspcript=$_SERVER["SCRIPT_FILENAME"];
	// list ($left, $right) = split ('url', $curspcript);
	// if ($left=="")
	// {
	$htxampp=$partwampp."\htdocs\\xampp\\".$htaccess;
	// }
	// else
	// {
	// $htxampp=$left.$htaccess;
	// }
	$htpasswdexe=$partwampp."\apache\\bin\\htpasswd.exe";
	if (file_exists($htpasswdexe))
	{
	// $htpasswdexe="\"".$htpasswdexe."\"";
	$htpasswddir="\"".$partwampp."\security\\".$htpasswd."\"";
	$htpasswddirectory=$partwampp."\security\\".$htpasswd;	
	$dir=$partwampp."\security\\";
	$dh = @opendir($dir);
	if ($dh)
	{ } else { system("md $dir"); } 
	
	$datei = fopen($htxampp,'w+');
	$insert="AuthName \"xampp user\"\r\nAuthType Basic\r\nAuthUserFile $htpasswddir\r\nrequire valid-user"; 
	fputs($datei,$insert); 
	fclose($datei);
	$htpassrealm = "\"$htpasswdexe\" -c -m -b c:\\xampp.users $xauser $xapasswd";
	shell_exec("$htpassrealm");
	
	/// Better this way agains problems with "c:\program files" directories \\\\
	if (@copy("c:\\xampp.users", $htpasswddirectory)) 
		{
		unlink ("c:\\xampp.users");
		}
		
	$datei = fopen($xapasswdtxtdir,'w+');
	$put="XAMPP user = $xauser\r\nXAMPP password = $xapasswd";
	fputs($datei, $put);
	fclose($datei);
		$xamppdirconfig="ok";
	
	}
	else
	{
		
		$xamppdirconfig="notok";
	}
}
?> 