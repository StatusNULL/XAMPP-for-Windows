<?php

/* 
#### Install 1.0 (beta) #### 
#### Author: Kay Vogelgesang for www.apachefriends.org 2004 ####  
*/    


 print "\r\n  ########################################################################\n
  # ApacheFriends XAMPP setup win32 Version 1.0                          #\r\n
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
/// Standard END ///

$installsys="install.sys";
$installsysroot=$partwampp."\install\\".$installsys;
$substit="\\\\\\\\xampp";
$substitslash="/xampp";
global $perl;
$perl = 1;
global $BS; 
$BS = 0;
$configure = 0;

$backslash[1]="server.xml";
$backslash[2]="php.ini";
$backslash[3]="FileZilla Server.xml";
$backslash[4]="MERCURY.INI";
$backslash[5]="workers.properties";
$backslash[6]="cgi.cgi";
$backslash[7]="drivers.pl";
$backslash[8]="guestbook-de.cgi";
$backslash[9]="guestbook-en.cgi";
$backslash[10]="perltest.cgi";
$backslash[11]="printenv.pl";
$backslash[12]="apache_start.bat";
$backslash[13]="tomcat_start.bat";
$backslash[14]="tomcat_stop.bat";
$backslash[15]="tomcat_installservice.bat";
$backslash[16]="posadisrc.txt";
$backslash[17]="python.cgi";
$backslash[18]="tomcat_service-install.bat";
$backslash[19]="webalizer.conf";
$backslash[20]="pear.bat";

$backslashrootawk['server.xml']="\"$awkpart\\\\tomcat\\\conf\\\\";
$backslashrootreal['server.xml']="$partwampp\\tomcat\conf\\";
$backslashrootawk['php.ini']="\"$awkpart\\\apache\\\bin\\\\";
$backslashrootreal['php.ini']="$partwampp\apache\bin\\";
$backslashrootawk['FileZilla Server.xml']="\"$awkpart\\\FileZillaFTP\\\\";
$backslashrootreal['FileZilla Server.xml']="$partwampp\FileZillaFTP\\";
$backslashrootawk['MERCURY.INI']="\"$awkpart\\\MercuryMail\\\\";
$backslashrootreal['MERCURY.INI']="$partwampp\MercuryMail\\";
$backslashrootawk['workers.properties']="\"$awkpart\\\\tomcat\\\conf\\\\";
$backslashrootreal['workers.properties']="$partwampp\\tomcat\conf\\";
$backslashrootawk['cgi.cgi']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['cgi.cgi']="$partwampp\cgi-bin\\";
$backslashrootawk['drivers.pl']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['drivers.pl']="$partwampp\cgi-bin\\";
$backslashrootawk['guestbook-de.cgi']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['guestbook-de.cgi']="$partwampp\cgi-bin\\";
$backslashrootawk['guestbook-en.cgi']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['guestbook-en.cgi']="$partwampp\cgi-bin\\";
$backslashrootawk['perltest.cgi']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['perltest.cgi']="$partwampp\cgi-bin\\";
$backslashrootawk['printenv.pl']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['printenv.pl']="$partwampp\cgi-bin\\";
$backslashrootawk['apache_start.bat']="\"$awkpart\\\\";
$backslashrootreal['apache_start.bat']="$partwampp\\";
$backslashrootawk['tomcat_start.bat']="\"$awkpart\\\\";
$backslashrootreal['tomcat_start.bat']="$partwampp\\";
$backslashrootawk['tomcat_stop.bat']="\"$awkpart\\\\";
$backslashrootreal['tomcat_stop.bat']="$partwampp\\";
$backslashrootawk['tomcat_installservice.bat']="\"$awkpart\\\\tomcat\\\\";
$backslashrootreal['tomcat_installservice.bat']="$partwampp\\tomcat\\";
$backslashrootawk['posadisrc.txt']="\"$awkpart\\\\PosadisDNS\\\Config\\\\";
$backslashrootreal['posadisrc.txt']="$partwampp\\PosadisDNS\Config\\";
$backslashrootawk['python.cgi']="\"$awkpart\\\cgi-bin\\\\";
$backslashrootreal['python.cgi']="$partwampp\cgi-bin\\";
$backslashrootawk['tomcat_service-install.bat']="\"$awkpart\\\\services_NT\\\\";
$backslashrootreal['tomcat_service-install.bat']="$partwampp\\services_NT\\";
$backslashrootawk['webalizer.conf']="\"$awkpart\\\\webalizer\\\\";
$backslashrootreal['webalizer.conf']="$partwampp\\webalizer\\";
$backslashrootawk['pear.bat']="\"$awkpart\\\\php\\\\";
$backslashrootreal['pear.bat']="$partwampp\\php\\";

$slash[1]="httpd.conf";
$slashrootawk['httpd.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['httpd.conf']="$partwampp\apache\conf\\";
$slash[2]="mod_auth_mysql.conf";
$slashrootawk['mod_auth_mysql.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['mod_auth_mysql.conf']="$partwampp\apache\conf\\";
$slash[3]="mod_jk.conf";
$slashrootawk['mod_jk.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['mod_jk.conf']="$partwampp\apache\conf\\";
$slash[4]="moddav.conf";
$slashrootawk['moddav.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['moddav.conf']="$partwampp\apache\conf\\";
$slash[5]="perl.conf";
$slashrootawk['perl.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['perl.conf']="$partwampp\apache\conf\\";
$slash[6]="ssl.conf";
$slashrootawk['ssl.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['ssl.conf']="$partwampp\apache\conf\\";
$slash[7]="my.cnf";
$slashrootawk['my.cnf']="\"$awkpart\\\mysql\\\bin\\\\";
$slashrootreal['my.cnf']="$partwampp\mysql\bin\\";
$slash[8]="my.nt-cnf";
$slashrootawk['my.nt-cnf']="\"$awkpart\\\mysql\\\bin\\\\";
$slashrootreal['my.nt-cnf']="$partwampp\mysql\bin\\";
$slash[9]="jpgraph.php";
$slashrootawk['jpgraph.php']="\"$awkpart\\\jpgraph\\\\";
$slashrootreal['jpgraph.php']="$partwampp\jpgraph\\";
$slash[10]="python.conf";
$slashrootawk['python.conf']="\"$awkpart\\\apache\\\conf\\\\";
$slashrootreal['python.conf']="$partwampp\apache\conf\\";


$awkexe="$partwampp\install\awk.exe";
$awk="$partwampp\install\config.awk";
$awknewdir="\"".$awkpart."\"";
$awkslashdir="\"".$awkpartslash."\"";

// echo "\r\n\r\n  Now using awk!\r\n\r\n";
// sleep(1);

$count=count($backslash);


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
list ($left, $right) = split ('=', $sysroot[0]);
$right = eregi_replace (" ","",$right);
$right = eregi_replace ("\r\n","",$right);
if (strtolower($partwampp)==strtolower($right))
	{
	$configure=1;
	// echo "\r\n  Sorry! Nothing to do ...\r\n\r\n";
	// sleep(3);
	// exit();
	}
else
	{
$substit = eregi_replace ("\\\\","\\\\\\\\",$right);
$substitslash = eregi_replace("\\\\","/",$right);

set_time_limit(0);
define('STDIN',fopen("php://stdin","r"));
while($BS == "0")
{
echo "\n  Do you want to refresh the superxampp installation?\n";
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
}
// else
// {
global $CS; 
$CS = 0;
set_time_limit(0);
define('NEWSTDIN',fopen("php://stdin","r"));
while($CS == "0")
{
echo "\n  Please select your choice!\n";
echo "  Bitte jetzt auswaehlen!\n\n";
echo "  1) Configuration with MOD_PERL (mit MOD PERL)\n";
echo "  2) Configuration without MOD_PERL (ohne MOD PERL)\n";
echo "  x) Exit (Beenden)\n";

switch(trim(fgets(NEWSTDIN,256)))
{
case 1:
$CS = 1;
echo "\r\n  Starting configure XAMPP with MOD_PERL ...\r\n\r\n";
sleep(1);
break;

case 2:
$CS = 2;
echo "\r\n  Starting configure XAMPP without MOD_PERL ...\r\n\r\n";
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
if ($CS == 2)
	{
	$perl = 0;
	$i=0;

	$confhttpdroot=$partwampp."\apache\\conf\\httpd.conf";
	$include = "# Include conf/perl.conf"; 
	
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
					if (eregi("conf/perl.conf",$newzeile[$z]))
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
	/*$confhttpd = fopen($confhttpdroot,'a');
	$include = "\r\n\r\nInclude conf/perl.conf"; 
	fputs($confhttpd,$include); 
	fclose($confhttpd); */
	}
	if ($CS == 1)
	{
	$perl = 1;
	$i=0;

	$confhttpdroot=$partwampp."\apache\\conf\\httpd.conf";
	$include = "Include conf/perl.conf"; 
	
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
					if (eregi("conf/perl.conf",$newzeile[$z]))
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
	}

// }
if ($configure < 1)
{

/// Your system? /// 
// echo "\r\n  Checking your system: ";
echo "  Configure XAMPP with awk for ";
$system = system ("echo '%os%'");
if ($system!="'Windows_NT'")
{$system = "Windows"; echo "  $system 98/ME/HOME (not NT)";} 
/// Your system END /// 
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

$substit="\"".$substit."\"";
for ($i=1;$i<=$count;$i++)
{
$temp=$backslash[$i];
$awkconfig=$backslashrootawk[$temp].$backslash[$i]."\"";
$awkconfigtemp=$backslashrootawk[$temp].$backslash[$i]."temp\"";
$configreal=$backslashrootreal[$temp].$backslash[$i];
$configtemp=$backslashrootreal[$temp].$backslash[$i]."temp";


$awkrealm=$awkexe." -v DIR=".$awknewdir." -v CONFIG=".$awkconfig. " -v CONFIGNEW=".$awkconfigtemp. "  -v SUBSTIT=".$substit." -f ".$awk;  
$count=count($backslash);

// echo "\r\n".$awkrealm."\r\n";

if (file_exists($awk) && file_exists($awkexe) && file_exists($configreal)) 
{		
	shell_exec("$awkrealm");
	 /* if (shell_exec("$awkrealm"))
	{ echo "\r\n  Sorry ... problems ... must abort!\r\n"; sleep(1); } else { echo "  Installing $configreal ...\r\n  Looks good! DONE!\r\n"; sleep(1); } */
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
for ($i=1;$i<=$count;$i++)
{
$temp=$slash[$i];
$awkconfig=$slashrootawk[$temp].$slash[$i]."\"";
$awkconfigtemp=$slashrootawk[$temp].$slash[$i]."temp\"";
$configreal=$slashrootreal[$temp].$slash[$i];
$configtemp=$slashrootreal[$temp].$slash[$i]."temp";


$awkrealm=$awkexe." -v DIR=".$awkslashdir." -v CONFIG=".$awkconfig. " -v CONFIGNEW=".$awkconfigtemp. "  -v SUBSTIT=".$substitslash." -f ".$awk;  
// echo "$awkrealm\r\n";
$count=count($slash);

// echo "\r\n".$installsysroot."\r\n";

if (file_exists($awk) && file_exists($awkexe) && file_exists($configreal)) 
{
	shell_exec("$awkrealm");
	/* if (shell_exec("$awkrealm"))
	{ echo "\r\n  Sorry ... problems ... must abort!\r\n"; sleep(1); } else { echo "  Installing $configreal ...\r\n  Looks good! DONE!\r\n"; sleep(1); } */
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

	
	
	
	/* if (file_exists($installsysroot)) 
	{
	$substit = eregi_replace ("\\\\","\\\\\\\\",$substit);
	} */
	$awkff = eregi_replace ("\\\\","\\\\",$awkpart);
	$awknewdir="\"".$awkff ."\"";
	$pythoninstallregpath="$partwampp\\python\\pythoninstall.reg";
	$pythoninstallregpathtemp="$partwampp\\python\\pythoninstall.regtemp";
	$pythoninstallregpathawk="\"$awkpart\\\python\\\\pythoninstall.reg";
	$pythoninstallregconfigtemp=$pythoninstallregpathawk."temp\"";
	$pythoninstallregconfig=$pythoninstallregpathawk."\"";	
	
	$awkrealm=$awkexe." -v DIR=".$awknewdir." -v CONFIG=".$pythoninstallregconfig. " -v CONFIGNEW=".$pythoninstallregconfigtemp."  -v SUBSTIT=".$substit. " -f ".$awk;  
	if (file_exists($awk) && file_exists($awkexe) && file_exists($pythoninstallregpath)) 
	{
	shell_exec("$awkrealm");
	if (!@copy($pythoninstallregpathtemp, $pythoninstallregpath)) 
		{		
		}
	else { unlink ($pythoninstallregpathtemp); }
	}
	

}	


	$installsys = fopen($installsysroot,'w');
	$wamppinfo = "DIR = $partwampp\r\nBasis = xampp\r\nVersion = 1.4\r\nPerl = $perl"; 
	fputs($installsys,$wamppinfo); 
	fclose($installsys); 
	
echo "\r\n  Ready!\r\n\r\n";



echo "\r\n  ##### Have fun with ApacheFriends XAMPP! #####\r\n\r\n\r\n";
sleep(3);
exit();
?>
