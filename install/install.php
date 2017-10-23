<?php

/* 
#### Installer PHP  1.4 RC2  #### 
#### Author: Kay Vogelgesang for www.apachefriends.org 2004 ####  
*/    

print "\r\n  ########################################################################\n
  # ApacheFriends XAMPP setup win32 Version 1.4                          #\r\n
  #----------------------------------------------------------------------#\r\n
  # Copyright (c) 2002-2004 Apachefriends                                #\r\n
  #----------------------------------------------------------------------#\r\n
  # Authors: Kay Vogelgesang <kvo@apachefriends.org>                     #\r\n
  #          Oswald Kai Seidler <oswald@apachefriends.org>               #\r\n
  ########################################################################\r\n\r\n"; 

/// Where I stand? ///
$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = spliti ('\\\install', $curdir);
$awkpart = eregi_replace ("\\\\","\\\\",$partwampp);
$awkpartslash = ereg_replace ("\\\\","/",$partwampp);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";

/// I need the install.sys + update.sys for more xampp informations
$installsys="install.sys";
$installsysroot=$partwampp."\install\\".$installsys;

/// Some addon|update.sys files 
$perlupdatesys="perlupdate.sys";
$pythonupdatesys="pythonupdate.sys";
$serverupdatesys="serverupdate.sys";
$utilsupdatesys="utilsupdate.sys";
$javaupdatesys="javaupdate.sys";
$otherupdatesys="otherupdate.sys";


/// XAMPP main directrory is ... 
$substit="\\\\\\\\xampp";
$substitslash="/xampp";

/// Globale variables
global $BS; 
$BS = 0;
global $CS; 
$CS = 0;
global $slashi;
$slashi=1;
global $bslashi;
$bslashi=1;
$awkexe=".\install\awk.exe";
$awk=".\install\config.awk";
// $awkexe="$partwampp\install\awk.exe";
// $awk="$partwampp\install\config.awk";
$awknewdir="\"".$awkpart."\"";
$awkslashdir="\"".$awkpartslash."\"";
global $xamppversion;
if (file_exists("$partwampp\install\.version")) 
{ include_once("$partwampp\install\.version"); }
$confhttpdroot=$partwampp."\apache\\conf\\httpd.conf";


// Find the install status for xampp basic package in the install.sys file
if (file_exists($installsysroot)) 
{
$i=0;
$datei = fopen($installsysroot,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$sysroot[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split (' = ', $sysroot[0]);
// $right = eregi_replace (" ","",$right);
$right = eregi_replace ("\r\n","",$right);
if (strtolower($partwampp)==strtolower($right))
	{
	$xamppinstaller="nothingtodo";
	}
else
	{ 
	$xamppinstaller="newpath";
	$substit = eregi_replace ("\\\\","\\\\\\\\",$right);
	$substitslash = eregi_replace("\\\\","/",$right);
	}
}
else
{ 
	$installsys = fopen($installsysroot,'w');
	$wamppinfo = "DIR = $partwampp\r\nxampp = $xamppversion\r\nserver = 0\r\nperl = 0\r\npython = 0\r\nutils = 0\r\njava = 0\r\nother = 0"; 
	fputs($installsys,$wamppinfo); 
	fclose($installsys);
	$xamppinstaller="newinstall"; 
}


/// Find some *update.sys files and modify the install.sys ...

$path=$partwampp."\install\\";
$hdl=opendir($path);
while ($res = readdir ($hdl)) { $array[]=$res; } //Searching all xampp sys files
closedir($hdl); 
$werte=count($array);
for ($q=2; $q<$werte; $q++)
{
if ($array[$q]==$perlupdatesys || $array[$q]==$pythonupdatesys || $array[$q]==$serverupdatesys || $array[$q]==$utilsupdatesys || $array[$q]==$javaupdatesys || $array[$q]==$otherupdatesys)
	{

$updatesysroot=$partwampp."\install\\".$array[$q];

if (file_exists($updatesysroot)) 
{
	$datei = fopen($updatesysroot,'r');
	unset($updatezeile);
	
	$i=0;
	while(!feof($datei)) 
	{

	$zeile = fgets($datei,255);
	$updatezeile[]=$zeile;
	list ($left, $right) = split ('=', $updatezeile[0]);
	// $right = eregi_replace (" ","",$right);
	$left = eregi_replace (" ","",$left);
	$left = eregi_replace ("\r\n","",$left);
	$right = eregi_replace ("\r\n","",$right);		
	$update=$left;
	$update=strtolower($update); 
	$updateversion=$right;
	$updateversionzahl = eregi_replace ("\.","",$updateversion);
	$updateinc="xampp".$update.".inc";
	$updateconf=$update.".conf";
	echo "  Configure for $update $updateversion\r\n";
	$i++;
	}
	fclose($datei);	

	if (file_exists($installsysroot)) 
	{
	$datei = fopen($installsysroot,'r');
	unset($newzeile);
	$i=0;
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$newzeile[]=$zeile; 
	$i++; 
	}
	fclose($datei);

		/// Analyze install.sys to *update.syse for todo 	
		$datei = fopen($installsysroot,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi($update,$newzeile[$z]))
					{
						list ($left, $right) = split ('=', $newzeile[$z]);
						// $right = eregi_replace (" ","",$right);
						$left = eregi_replace (" ","",$left);
						$left = eregi_replace ("\r\n","",$left);
						$right = eregi_replace ("\r\n","",$right);
						$currentversionzahl = eregi_replace ("\.","",$right);
						if ($currentversionzahl == 0 )
						{
							$updatemake="makenew"; // New installation
							$putnew="$update = $updateversion\r\n";
							fputs($datei, $putnew);
						}
						elseif ($currentversionzahl < $updateversionzahl)
						{
							$updatemake="update";  // Update installation
							$putnew="perl = $updateversion\r\n";
							fputs($datei, $putnew);
						}
						else
						{
							$updatemake="doppelt"; // Installation is current
							fputs($datei,$newzeile[$z]); 
						}

					}
					else 
					{ 
					fputs($datei,$newzeile[$z]); 
					}
				}
			}
	fclose($datei);
	
	if ($updatemake=="makenew" || $updatemake=="doppelt")
	{ 
		include_once("$partwampp\install\\$updateinc"); 
	}

	
	}
// httpd.conf modification for Perl, Python or Java (only single)
if ($update=="perl")
	{
	$includehttpdconf="\r\n\r\nInclude conf/perl.conf";
	}
	if ($update=="python")
	{
	$includehttpdconf="\r\n\r\nInclude conf/python.conf";
	}
	if ($update=="java")
	{
	$includehttpdconf="\r\n\r\nInclude conf/java.conf";
	}
	
if (($update=="perl" || $update=="python" || $update=="java") && $updatemake=="makenew")
	{
	$datei = fopen($confhttpdroot,'a'); 
	if($datei) 
            { 
			fputs($datei, $includehttpdconf);
			}
	fclose($datei);
	}


unlink ($updatesysroot);
}
} 
}




if ($xamppinstaller=="newinstall" || $xamppinstaller=="newpath")
{
if ($xamppinstaller=="newinstall")
	{
	/// First initialization only main packages 
	if (file_exists("$partwampp\install\\xamppbasic.inc")) 
		{ include_once("$partwampp\install\\xamppbasic.inc"); }

	}
	
	else
	{
/// Find all the packages 
if (file_exists("$partwampp\install\\xamppbasic.inc")) 
{ include_once("$partwampp\install\\xamppbasic.inc"); }
if (file_exists("$partwampp\install\\xamppserver.inc")) 
{ include_once("$partwampp\install\\xamppserver.inc"); }
if (file_exists("$partwampp\install\\xamppperl.inc")) 
{ include_once("$partwampp\install\\xamppperl.inc"); }
if (file_exists("$partwampp\install\\xampppython.inc")) 
{ include_once("$partwampp\install\\xampppython.inc"); }
if (file_exists("$partwampp\install\\xampputils.inc")) 
{ include_once("$partwampp\install\\xampputils.inc"); }
if (file_exists("$partwampp\install\\xamppjava.inc")) 
{ include_once("$partwampp\install\\xamppjava.inc"); }
if (file_exists("$partwampp\install\\xamppother.inc")) 
{ include_once("$partwampp\install\\xamppother.inc"); }
$updatemake="nothingtodo";
	}
}

$scount=count($slash);
$bcount=count($backslash);

/////////////////// xampp path is changing ///////////////////
if ($xamppinstaller=="newpath")
{
set_time_limit(0);
define('STDIN',fopen("php://stdin","r"));
	while($BS == "0")
	{
	echo "\n  Do you want to refresh the XAMPP installation?\n";
	echo "  Soll die XAMPP Installation jetzt aktualisiert werden?\n\n";
	echo "  1) Refresh now! (Jetzt aktualisieren!)\n";
	echo "  x) Exit (Beenden)\n";

		switch(trim(fgets(STDIN,256)))
		{
		case 1:
		$BS = 1;
		echo "\r\n  XAMPP is refreshing now ...\r\n";
		echo "  XAMPP wird nun aktualisiert ...\r\n\r\n";
		sleep(1);
		break;

		case "x":
		echo "\r\n  The refresh is terminating on demand ...  exit\r\n";
		echo "  Die Aktualisierung wurde auf Wunsch abgebrochen ...\r\n";
		sleep(3);
		exit();

		default: 
		exit();
		}
	}
fclose(STDIN);
}

/////////////////// You can configure the addon modules for httpd ///////////////////
if (file_exists($installsysroot)) 
	{
	$datei = fopen($installsysroot,'r');
	unset($newzeile);
	$i=0;
		while(!feof($datei)) 
		{
		$zeile = fgets($datei,255);
		list ($left, $right) = split ('=', $zeile);
		// $right = eregi_replace (" ","",$right);
		$left = eregi_replace (" ","",$left);
		$left = eregi_replace ("\r\n","",$left);
		$right = eregi_replace ("\r\n","",$right);
		$right = eregi_replace ("\.","",$right);
		if (strtolower($right) > 0)
			{
			if (strtolower($left)=="perl")
				{
				$perlactive="yes";
				
				}
				if (strtolower($left)=="python")
				{
				$pythonactive="yes";
				}
				if (strtolower($left)=="java")
				{
				$javaactive="yes";
				}
			} 
		}
fclose($datei);
	}




/////////////////// Case new install ///////////////////
if ($xamppinstaller=="newinstall" || $BS==1 || $updatemake=="makenew" || $updatemake=="doppelt")
{

if ($BS=="1")
{ echo "  Refreshing all paths in config files ... \r\n\r\n";  }

echo "  Configure XAMPP with awk for ";
$system = system ("echo '%os%'");
if ($system!="'Windows_NT'")
{$system = "Windows"; echo "  $system 98/ME/HOME (not NT)";} 
echo "  Please wait ...";
if ($xamppinstaller=="newinstall")
{
if ($system=="Windows")
{
	$confhttpdroot=$partwampp."\apache\\conf\\httpd.conf";
	$includewin="Win32DisableAcceptEx ON\r\n";
	echo "\r\n  Disable AcceptEx Winsocks v2 support (only NT)";
	$datei = fopen($confhttpdroot,'r');
	unset($newzeile);
	$i=0;
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$newzeile[]=$zeile; 
	$i++; 
	}
	fclose($datei);
	 $datei = fopen($confhttpdroot,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi("Win32DisableAcceptEx",$newzeile[$z]))
					{
						fputs($datei, $includewin);
					}
					else 
					{ 
					fputs($datei,$newzeile[$z]); 
					}
				}
			}
	fclose($datei);
}
else
{
	$confhttpdroot=$partwampp."\apache\\conf\\httpd.conf";
	$includewin="# Win32DisableAcceptEx ON\r\n";
	echo "\r\n  Enable AcceptEx Winsocks v2 support for NT systems";
	$datei = fopen($confhttpdroot,'r');
	$i=0;
	unset($newzeile);
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$newzeile[]=$zeile; 
	$i++; 
	}
	fclose($datei);
	 $datei = fopen($confhttpdroot,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi("Win32DisableAcceptEx",$newzeile[$z]))
					{
						fputs($datei, $includewin);
					}
					else 
					{ 
					fputs($datei,$newzeile[$z]); 
					}
				}
			}
	fclose($datei);
}
}
$substit="\"".$substit."\"";
for ($i=1;$i<=$bcount;$i++)
{




$temp=$backslash[$i];
$awkconfig=$backslashrootawk[$temp].$backslash[$i]."\"";
$awkconfigtemp=$backslashrootawk[$temp].$backslash[$i]."temp\"";
$configreal=$backslashrootreal[$temp].$backslash[$i];
$configtemp=$backslashrootreal[$temp].$backslash[$i]."temp";


///////////// Section SET  NEW configfiles for addons/update OR DELETE /////////////
$configrealnew=$backslashrootreal[$temp].$backslash[$i].".new";
if (!file_exists($configreal) && file_exists($configrealnew))
	{ 
			
			if (!@copy($configrealnew, $configreal)) 
				{}			
			else { unlink ($configrealnew); }
		
	}
	elseif (file_exists($configrealnew))
	{ unlink ($configrealnew); }

if ($updatemake=="doppelt")
	{ break; }


$awkrealm=$awkexe." -v DIR=".$awknewdir." -v CONFIG=".$awkconfig. " -v CONFIGNEW=".$awkconfigtemp. "  -v SUBSTIT=".$substit." -f ".$awk;  



if (file_exists($awk) && file_exists($awkexe) && file_exists($configreal)) 
{		
	shell_exec("$awkrealm");
} 

	if (file_exists($configtemp) && file_exists($configreal))
	{
	if (!@copy($configtemp, $configreal)) 
		{
		// echo "\r\n\r\n$configtemp could not be copied to $configreal";
		}
		else { unlink ($configtemp); }
	} 
}


$substitslash="\"".$substitslash."\"";
for ($i=1;$i<=$scount;$i++)
{
$temp=$slash[$i];
$awkconfig=$slashrootawk[$temp].$slash[$i]."\"";
$awkconfigtemp=$slashrootawk[$temp].$slash[$i]."temp\"";
$configreal=$slashrootreal[$temp].$slash[$i];
$configtemp=$slashrootreal[$temp].$slash[$i]."temp";

///////////// Section SET  NEW configfiles for addons/update OR DELETE /////////////
$configrealnew=$slashrootreal[$temp].$slash[$i].".new";
if (!file_exists($configreal) && file_exists($configrealnew))
	{ 
			
			if (!@copy($configrealnew, $configreal)) 
				{}			
			else { unlink ($configrealnew); }
		
	}
	elseif (file_exists($configrealnew))
	{ unlink ($configrealnew); }

	if ($updatemake=="doppelt")
	{ break; }

$awkrealm=$awkexe." -v DIR=".$awkslashdir." -v CONFIG=".$awkconfig. " -v CONFIGNEW=".$awkconfigtemp. "  -v SUBSTIT=".$substitslash." -f ".$awk;  


if (file_exists($awk) && file_exists($awkexe) && file_exists($configreal)) 
{
	shell_exec("$awkrealm");
} 

	if (file_exists($configtemp) && file_exists($configreal))
	{
	if (!@copy($configtemp, $configreal)) 
		{
		// echo "\r\n\r\n$configtemp could not be copied to $configreal";
		}
		else { unlink ($configtemp); }
	} 
}


	
	if ($xamppinstaller=="newpath" || $BS==1)
	{
		if (file_exists($installsysroot)) 
		{
		$datei = fopen($installsysroot,'r');
		unset($newzeile);
		$i=0;
		while(!feof($datei)) 
		{
		$zeile = fgets($datei,255);
		$newzeile[]=$zeile; 
		$i++; 
		}
		fclose($datei);
		}
		
		$datei = fopen($installsysroot,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi("DIR",$newzeile[$z]))
					{
						$includenewdir="DIR = $partwampp\r\n";
						fputs($datei, $includenewdir);
					}
					else 
					{ 
					$includenewdir=$newzeile[$z];
					fputs($datei, $includenewdir); 
					}
				}
			}
			fclose($datei);
	}

////////// Replace (copy) some newer files ////////////////
	$phpbin=$partwampp."\apache\bin\php.ini";
	$phpcgi=$partwampp."\php\php.ini";
	$workersbin=$partwampp."\\tomcat\\conf\workers.properties";
	$workersjk=$partwampp."\\tomcat\\conf\jk\workers.properties";
		if (file_exists($phpbin)) 
		{
		copy($phpbin,$phpcgi);
		}
		if (file_exists($workersbin)) 
		{
		copy($workersbin,$workersjk);
		}

	echo "  DONE!\r\n\r\n";
echo "\r\n  ##### Have fun with ApacheFriends XAMPP! #####\r\n\r\n\r\n";
sleep(3);
exit();
}



//////////////// Selection for modules  ////////////////
if (($perlactive=="yes" || $pythonactive=="yes" || $javaactive=="yes") && $update=="")
{
$u=1;

if ($perlactive=="yes")
	{
	$moduleconf="conf/perl.conf";
	$moduleconfigure="MOD_PERL";
	$u++;
	}
if ($pythonactive=="yes")
	{
	$moduleconf="conf/pyton.conf";
	$moduleconfigure="MOD_PYTHON";
	$u++;
	}
if ($javaactive=="yes")
	{
	$moduleconf="conf/java.conf";
	$moduleconfigure="MOD_JDK";
	$u++;
	}

set_time_limit(0);
define('NEWSTDIN',fopen("php://stdin","r"));
while($CS == "0")
{
echo "\n  Please select your choice!\n";
echo "  Bitte jetzt auswaehlen!\n\n";
if ($perlactive=="yes")
	{
	echo "  1) Configuration with MOD_PERL (mit MOD_PERL)\n";
	echo "  2) Configuration without MOD_PERL (ohne MOD MOD_PERL)\n";
	}
	if ($pythonactive=="yes")
	{
	echo "  3) Configuration with MOD_PYTHON (mit MOD_PYTHON)\n";
	echo "  4) Configuration without MOD_PYTHON (ohne MOD_PYTHON)\n";
	}
	if ($javaactive=="yes")
	{
	echo "  5) Configuration with MOD_JDK (mit MOD_JDK)\n";
	echo "  6) Configuration without MOD_JDK (ohne MOD_JDK)\n";
	}
	echo "  x) Exit (Beenden)\n";

switch(trim(fgets(NEWSTDIN,256)))
{
case 1:
$CS = 1;
echo "\r\n  Starting configure XAMPP with MOD_PERL ...\r\n";
sleep(1);
break;

case 2:
$CS = 2;
echo "\r\n  Starting configure XAMPP without MOD_PERL ...\r\n";
sleep(1);
break;

case 3:
$CS = 3;
echo "\r\n  Starting configure XAMPP with MOD_PYTHON ...\r\n";
sleep(1);
break;

case 4:
$CS = 4;
echo "\r\n  Starting configure XAMPP without MOD_PYTHON ...\r\n";
sleep(1);
break;

case 5:
$CS = 5;
echo "\r\n  Starting configure XAMPP with MOD_JDK ...\r\n";
sleep(1);
break;

case 6:
$CS = 6;
echo "\r\n  Starting configure XAMPP without MOD_JDK ...\r\n";
sleep(1);
break;

case "x":
echo "\r\n  Setup is terminating on demand ...  exit\r\n";
echo "  Das Setup wurde auf Wunsch abgebrochen ...\r\n";
sleep(3);
exit();

default: 
exit();
}
}
fclose(NEWSTDIN);

if ($CS == 1)
	{ $include = "Include conf/perl.conf"; $searchstring="conf/perl.conf";}
if ($CS == 2)
	{ $include = "# Include conf/perl.conf"; $searchstring="conf/perl.conf";}
if ($CS == 3)
	{ $include = "Include conf/python.conf"; $searchstring="conf/python.conf"; }
if ($CS == 4)
	{ $include = "# Include conf/python.conf"; $searchstring="conf/python.conf";}
if ($CS == 5)
	{ $include = "Include conf/java.conf"; $searchstring="conf/java.conf";}
if ($CS == 6)
	{ $include = "# Include conf/java.conf"; $searchstring="conf/java.conf";}




if ($CS > 0)
{	
	$i=0;	
	$datei = fopen($confhttpdroot,'r');
	while(!feof($datei)) 
	{
	$zeile = fgets($datei,255);
	$newzeile[]=$zeile; 
	$i++; 
	}
	fclose($datei);
	 $datei = fopen($confhttpdroot,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi($searchstring,$newzeile[$z]))
					{
						fputs($datei, $include);
					}
					else 
					{ 
					fputs($datei,$newzeile[$z]); 
					}
				}
			}
	fclose($datei);
	echo "  Done!\r\n\r\n";	
}
}

if ($updatemake=="")
		{  $updatemake="nothingtodo"; }

if ($updatemake=="nothingtodo" && $xamppinstaller=="nothingtodo" && ($CS < 1 || $CS == ""))
{ echo "\r\n\r\n Sorry, but ... nothing to do!\r\n\r\n\r\n";  }


exit();
?>
