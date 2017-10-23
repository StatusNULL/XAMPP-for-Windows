<?php

/* 
#### Installer PHP  1.4 RC2  #### 
#### Author: Kay Vogelgesang for www.apachefriends.org 2004 ####  
*/    

print "\r\n  ########################################################################\n
  # ApacheFriends XAMPP PHP Switch win32 Version 1.0                     #\r\n
  #----------------------------------------------------------------------#\r\n
  # Copyright (c) 2002-2004 Apachefriends                                #\r\n
  #----------------------------------------------------------------------#\r\n
  # Authors: Kay Vogelgesang <kvo@apachefriends.org>                     #\r\n
  #          Oswald Kai Seidler <oswald@apachefriends.org>               #\r\n
  ########################################################################\r\n\r\n"; 

$host="127.0.0.1";
$timeout="1";
if (($handle = @fsockopen($host, 80, $errno, $errstr, $timeout)) == true)
{
@fclose($handle);
echo "   The Apache is running! Please stop the Apache before make this procedure!\r\n";
echo "   Der Apache laeuft gerade! Bitte den Apache fuer diese Prozedur stoppen!\r\n";
echo "   PHP Switch exit ...\r\n\r\n";
exit();
}
else
{
@fclose($handle);

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
$phpversionfile=".phpversion";
$phpversionfileroot=$partwampp."\install\\".$phpversionfile;

$phpcurrent=$partwampp."\apache\bin\php.ini";
$php5safety=$partwampp."\php\php5.ini";
$php4safety=$partwampp."\php\php4\php4.ini";
$php4dir=$partwampp."\php\php4";
$php5dir=$partwampp."\php";
$apachebin=$partwampp."\apache\bin";
$php4exe=$partwampp."\php\php4\php.exe";
$php5exe=$partwampp."\php\php.exe";
$phpexe=$partwampp."\apache\bin\php.exe";
$httpconf5=$partwampp."\php\httpd5.conf";
$httpconf4=$partwampp."\php\php4\httpd4.conf";
$httpconf=$partwampp."\apache\conf\httpd.conf";

/// XAMPP main directrory is ... 
$substit="\\\\\\\\xampp";
$substitslash="/xampp";

/// Globale variables
global $BS; 
$BS = 0;
global $CS; 
$CS = 0;
global $phpcurrentv;

$awkexe=".\install\awk.exe";
$awk=".\install\config.awk";

$awknewdir="\"".$awkpart."\"";
$awkslashdir="\"".$awkpartslash."\"";

if (file_exists($phpversionfileroot)) 
{
	$datei = fopen($phpversionfileroot,'r');
		while(!feof($datei)) 
	{
	$phpcurrentv = fgets($datei,255);
	}
	fclose($datei);
}
else
{
echo "   Cannot find $phpversionfileroot! So i cannot select the current PHP version.\r\n";
echo "   Die $phpversionfileroot! Kann nicht die akuelle PHP Version bestimmen.\r\n";
echo "   PHP Switch exit ...\r\n\r\n";
exit();
}

if ($phpcurrentv!="4" && $phpcurrentv!="5")
{
echo "   The PHP version number is not valid.\r\n";
echo "   Die PHP Version Nummer ist ungueltig.\r\n";
echo "   PHP Switch exit ...\r\n\r\n";
exit();
} 



print "\r\n\r\n  The working version in XAMPP is => PHP $phpcurrentv <=\r\n";
print "  The verwendete Version in XAMPP ist => PHP $phpcurrentv <=\r\n\r\n";


set_time_limit(0);
define('NEWSTDIN',fopen("php://stdin","r"));
while($CS == "0")
{
echo "\n  Type number or 'x' (exit) for selecting your choice!\n";
echo "  Gebe nun Nummer oder 'x' (exit) zum auswaehlen ein!\n\n";
if ($phpcurrentv =="5")
	{
	echo "  4) Switching to PHP 4 (zu PHP 4 wechseln)\n";
	}
	elseif ($phpcurrentv=="4")
	{
	echo "  5) Switching to PHP 5 (zu PHP 5 wechseln)\n";
	}
	else
	{
	echo "  5) Switching to PHP 5 (zu PHP 5 wechseln)\n";
	echo "  4) Switching to PHP 4 (zu PHP 4 wechseln)\n";
	}
	echo "  x) Exit (Beenden)\n";

switch(trim(fgets(NEWSTDIN,256)))
{
case 4:
$CS = 4;
echo "\r\n  Starting configure XAMPP with PHP 4 ...\r\n\r\n";
sleep(1);
break;

case 5:
$CS = 5;
echo "\r\n  Starting configure XAMPP without PHP 5 ...\r\n\r\n";
sleep(1);
break;

case "x":
echo "\r\n  PHP Switch is terminating on demand ...  exit\r\n";
echo "  PHP Switch wurde auf Wunsch abgebrochen ...\r\n\r\n";
sleep(3);
exit();

default: 
exit();
}
}
fclose(NEWSTDIN);

if ($CS=="4" && $phpcurrentv=="5")
{
	
echo "  Installing PHP4 in XAMPP now!\r\n\r\n";
sleep(1);

if (file_exists($phpcurrent)) 
		{
		echo "  Copy the current php.ini to $php5safety ... ";
		copy($phpcurrent,$php5safety);
		echo "done!\r\n";
		}



if (file_exists($php4safety)) 
		{
		echo "  Copy the php4.ini to $phpcurrent ... ";
		copy($php4safety,$phpcurrent);
		echo "done!\r\n\r\n";
		}



if (file_exists($httpconf)) 
		{
	    echo "  Safe the $httpconf as $httpconf5 ... ";
		copy($httpconf,$httpconf5);
		echo "done!\r\n\r\n";
		}


if (file_exists($httpconf4)) 
		{
		echo "  Copy the $httpconf4 to $httpconf ... ";
		copy($httpconf4,$httpconf);
		echo "done!\r\n\r\n";
		}


echo "  Copy now all php4 dlls to $apachebin\r\n\r\n";

$dh= opendir($php4dir);
while($file = readdir ($dh))
{
if (eregi ("\.dll", $file))
{
$php4file=$partwampp."\php\php4\\".$file;
$phpcpfile=$partwampp."\apache\bin\\".$file;
if (file_exists($php4file)) 
		{
		copy($php4file,$phpcpfile);
		echo "$php4file => $phpcpfile\r\n";
		}
}
}
closedir($dh);


if (file_exists($php4exe)) 
		{
		echo "\r\n  Copy the $php4exe as $phpexe ... ";
		copy($php4exe,$phpexe);
		echo "done!\r\n";
		}

echo "  Write the new PHP main version in $phpversionfileroot\r\n";  
	$datei = fopen($phpversionfileroot,'w');
	fputs($datei, "4");
	fclose($datei);
}







if ($CS=="5" && $phpcurrentv=="4")
{
echo "  Installing PHP5 in XAMPP now!\r\n\r\n";
sleep(1);

if (file_exists($phpcurrent)) 
		{
		echo "  Copy the current php.ini to $php4safety ... ";
		copy($phpcurrent,$php4safety);
		echo "done!\r\n";
		}



if (file_exists($php5safety)) 
		{
		echo "  Copy the php5.ini to $phpcurrent ... ";
		copy($php5safety,$phpcurrent);
		echo "done!\r\n\r\n";
		}



if (file_exists($httpconf)) 
		{
	    echo "  Safe the $httpconf as $httpconf4 ... ";
		copy($httpconf,$httpconf4);
		echo "done!\r\n\r\n";
		}


if (file_exists($httpconf5)) 
		{
		echo "  Copy the $httpconf5 to $httpconf ... ";
		copy($httpconf5,$httpconf);
		echo "done!\r\n\r\n";
		}


echo "  Copy now all php5 dlls to $apachebin\r\n\r\n";

$dh= opendir($php5dir);
while($file = readdir ($dh))
{
if (eregi ("\.dll", $file))
{
$php5file=$partwampp."\php\\".$file;
$phpcpfile=$partwampp."\apache\bin\\".$file;
if (file_exists($php5file)) 
		{
		copy($php5file,$phpcpfile);
		echo "$php5file => $phpcpfile\r\n";
		}
}
}
closedir($dh);


if (file_exists($php5exe)) 
		{
		echo "\r\n  Copy the $php5exe as $phpexe ... ";
		copy($php5exe,$phpexe);
		echo "done!\r\n";
		}

echo "  Write the new PHP main version in $phpversionfileroot\r\n";  
	$datei = fopen($phpversionfileroot,'w');
	fputs($datei, "5");
	fclose($datei);

}

echo "\r\n  OKAY ... PHP SWITCHING WAS SUCCESSFUL";
echo "\r\n\r\n  Now you can start the Apache with PHP $CS !";
echo "\r\n  Nun kannst du den Apache mit PHP $CS starten!";
sleep(1);

echo "\r\n\r\n  :-) Kay Vogelgesang (www.apachefriends.org)\r\n\r\n";
exit();
}
?>
