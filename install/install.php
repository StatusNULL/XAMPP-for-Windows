<?php

/* 
#### Install 0.9 (alpha) #### 
#### Author: Kay Vogelgesang for www.apachefriends.org 2003 ####  
*/    



$fn = "os.txt";
if (file_exists($fn))
{
$fp = fopen($fn, "r");
$os= fgets($fp,20);
fclose($fp);
}
unlink ($fn);

$nt="Windows_NT";
if ($os != $nt)
	{
	$os="Windows";
	}

/// Where I stand? ///

$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = split ('\\\install', $curdir);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";


/// Where I stand END ///

/// Configs///

$httpd_ini="$partwampp\apache\conf\httpd.conf";
$ssl_ini="$partwampp\apache\conf\ssl.conf";
$php_ini="$partwampp\apache\bin\php.ini";
$phpcgi_ini="$partwampp\php\php.ini";
$moddav_ini="$partwampp\apache\conf\moddav.conf";
$mysql_ini="$partwampp\mysql\bin\my.cnf";
$mysqlnt_ini="$partwampp\mysql\bin\my.nt-cnf";
$filezilla_ini="$partwampp\FileZillaFTP\FileZilla Server.xml";
$mercury_ini="$partwampp\MercuryMail\MERCURY.INI";
$perlppm_ini="$partwampp\perl\site\lib\ppm.xml";
$webalizer_ini="$partwampp\webalizer\webalizer.conf";
$wampp_lib="$partwampp\install\wampp.sys";
$test_cgi="$partwampp\cgi-bin\perltest.cgi";
$printenv_pl="$partwampp\cgi-bin\printenv.pl";
$drivers_pl="$partwampp\cgi-bin\drivers.pl";
$htaccess_moddav="$partwampp\webdav\.htaccess";
// $install_bat="$partwampp\install_xampp.bat";
// $setup_bat="$partwampp\update_xampp_config.bat";
$apache_start="$partwampp\apache_start.bat";
$mysql_start="$partwampp\mysql_start.bat";
$mysql_stop="$partwampp\mysql_stop.bat";
$filezilla_start="$partwampp\filezilla_start.bat";
$filezilla_stop="$partwampp\filezilla_stop.bat";
$mercury_start="$partwampp\mercury_start.bat";
$my_example="$partwampp\my_example.cnf";
$jpgraph_one="$partwampp\jpgraph\jpgraph.php";
$jpgraph_two="$partwampp\php\pear\jpgraph.php";


/// Configs END //

print "\n  ########################################################################\n
  # ApacheFriends XAMPP win32 Version 0.9                                #\n
  #----------------------------------------------------------------------#\n
  # Copyright (c) 2002-2003 Apachefriends                                #\n
  #----------------------------------------------------------------------#\n
  # Authors: Kay Vogelgesang <kvo@apachefriends.org>                     #\n
  #          Oswald Kai Seidler <oswald@apachefriends.org>               #\n
  ########################################################################\n\n";



/// WAMPP LIB READ //


if(file_exists($wampp_lib)) 
{ 
$i=0;
$datei = fopen($wampp_lib,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$wamppzeile[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split ('=', $wamppzeile[0]);
$right = ereg_replace ("\n","",$right);
$oldpartition = "$right";
list ($left, $right) = split ('=', $wamppzeile[1]);
$right = ereg_replace ("\n","",$right);
$oldwampproot = "$right";
$oldwampproot_rp  = ereg_replace ("\\\\","'''", $oldwampproot);
$right = ereg_replace ("\\\\","/",$right);
$ooldwampproot = "$right";
list ($left, $right) = split ('=', $wamppzeile[2]);
$right = ereg_replace ("\n","",$right);
$oldos = "$right";

print "\n\n  ATTENTION! An update can damage some\n";  
print "  individually modified config files!!!\n";   
print "  ACHTUNG! Die Aktualisierung bereits individuell veraenderter\n"; 
print "  Konfig-Dateien koennten diese unvorgesehen modifizieren!!!";
}
else
{
$oldpartition = "$partition";
$oldwampproot = "$partwampp";
$ooldwampproot= $dir;
$oldos = "$os";
} 
/// WAMPP LIB READ END //

/// Function Warning ///

function warning($ininame,$inipath)
{
global $mistake;
$mistake=1;
echo "\n\n  Could not use \"$ininame\" in $inipath!\n";
echo "  Configuration \"$ininame\" failed. Continue ...\n";
echo "  Konnte die \"$ininame\" in $test_cgi nicht benutzen!\n";
echo "  Konfiguration der \"$ininame\" fehlt! Weiter ...\n\n";
echo "  Perhaps file is NOT WRITEABLE! Vielleicht SCHREIBGESCHUETZT!\n\n";
sleep(3);
}

/// Function Warning END///

/// Function FIRST HTTPD CONFIG ///

function httpconfig($ini,$BS)
{
$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = split ('\\\install', $curdir);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";

$wampp_lib="$partwampp\install\wampp.sys";
if(file_exists($wampp_lib)) 
{ 
$i=0;
$datei = fopen($wampp_lib,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$wamppzeile[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split ('=', $wamppzeile[0]);
$right = ereg_replace ("\n","",$right);
$oldpartition = "$right";
list ($left, $right) = split ('=', $wamppzeile[1]);
$right = ereg_replace ("\n","",$right);
$oldwampproot = "$right";
$oldwampproot_rp  = ereg_replace ("\\\\","'''", $oldwampproot);
$right = ereg_replace ("\\\\","/",$right);
$ooldwampproot = "$right";
list ($left, $right) = split ('=', $wamppzeile[2]);
$right = ereg_replace ("\n","",$right);
$oldos = "$right";
	}
else
	{
$oldpartition = "$partition";
$oldwampproot = "$partwampp";
$ooldwampproot= $dir;
$oldos = "$os";
}
$perl58="perl58";
$libxml2="libxml2";
$perl_module="perl_module";
$raute="#";

unset($newzeile);
$i=0;
$datei = fopen($ini,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$newzeile[]=$zeile; 
$i+=1; 
	}
// fclose($datei);

$oldini="$ini.old";
$old = fopen($oldini,'w');
for($z=0;$z<$i+1;$z++) 
{ 
fputs($old,$newzeile[$z]); 
}
fclose($old); 
	         
      $datei = fopen($ini,'w'); 
       if($datei) 
           { 
                for($z=0;$z<$i+1;$z++) 
                { 
					
					if (eregi("xampp",$newzeile[$z]))
					{
					if ($oldwampproot != $partwampp)
						{
						list ($left, $right) = split ($ooldwampproot, $newzeile[$z]);
						 $newline = "$left$dir$right";

						if ($BS==2)
							{	
						if (eregi("perl58",$newline))
								{
						list ($left, $right) = split ('perl58', $newline);
						 $newline = "$raute$left$perl58$right";
							fputs($datei, $newline);
								}
							elseif (eregi("libxml2",$newline))
								{
						list ($left, $right) = split ('libxml2', $newline);
						 $newline = "$raute$left$libxml2$right";
							fputs($datei, $newline);
								}
								elseif (eregi("modules/mod_perl",$newline))
								{
								if (!eregi("#",$newline))
									{
					list ($left, $right) = split ('perl_module', $newline);
					  $newline = "$raute$left$perl_module$right";
							fputs($datei, $newline);
									}
									else
									{
									fputs($datei, $newline);	
									}
								}
							}				
							else
							{

						    fputs($datei, $newline);
							}
						
						
						}
						else

						{
						
						if (ereg($ppartition,$newzeile[$z]))
							{
list ($left, $right) = split ($ppartition, $newzeile[$z]);
  $newline = "$left$ppartition$right";
							
							if ($BS==2)
							{	
						if (eregi("perl58",$newline))
								{
						list ($left, $right) = split ('perl58', $newline);
						 $newline = "$raute$left$perl58$right";
							fputs($datei, $newline);
								}
							elseif (eregi("libxml2",$newline))
								{
						list ($left, $right) = split ('libxml2', $newline);
						 $newline = "$raute$left$libxml2$right";
							fputs($datei, $newline);
								}
								elseif (eregi("modules/mod_perl",$newline))
								{
								if (!eregi("#",$newline))
									{
					list ($left, $right) = split ('perl_module', $newline);
					  $newline = "$raute$left$perl_module$right";
							fputs($datei, $newline);
									}
									else
									{
									fputs($datei, $newline);	
									}
								}
							}				
							else
							{
						    fputs($datei, $newline);
							}
							
						}

							
 
  else
							{
list ($left, $right) = split ('/xampp', $newzeile[$z]);
 $newline = "$left$dir$right";
							if ($BS==2)
							{	
						if (eregi("perl58",$newline))
								{
						list ($left, $right) = split ('perl58', $newline);
						 $newline = "$raute$left$perl58$right";
							fputs($datei, $newline);
								}
							elseif (eregi("libxml2",$newline))
								{
						list ($left, $right) = split ('libxml2', $newline);
						 $newline = "$raute$left$libxml2$right";
							fputs($datei, $newline);
								}
								else
								{
								fputs($datei, $newline);
								}
							}				
							else
							{
						    fputs($datei, $newline);
							}

						 }
						}
					}
					
					else { 
						
						if ($BS==2)
							{	
								if (eregi("modules/mod_perl",$newzeile[$z]))
								{
								if (!eregi("#",$newzeile[$z]))
									{
					list ($left, $right) = split ('perl_module', $newzeile[$z]);
					  $newline = "$raute$left$perl_module$right";
							fputs($datei, $newline);
									}
								}
							else
							{			
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
      }
}

/// Function FIRST HTTPD CONFIG end///

function slashconfig($ini)
{
$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = split ('\\\install', $curdir);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";

$wampp_lib="$partwampp\install\wampp.sys";
if(file_exists($wampp_lib)) 
{ 
$i=0;
$datei = fopen($wampp_lib,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$wamppzeile[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split ('=', $wamppzeile[0]);
$right = ereg_replace ("\n","",$right);
$oldpartition = "$right";
list ($left, $right) = split ('=', $wamppzeile[1]);
$right = ereg_replace ("\n","",$right);
$oldwampproot = "$right";
$oldwampproot_rp  = ereg_replace ("\\\\","'''", $oldwampproot);
$right = ereg_replace ("\\\\","/",$right);
$ooldwampproot = "$right";
list ($left, $right) = split ('=', $wamppzeile[2]);
$right = ereg_replace ("\n","",$right);
$oldos = "$right";
}
else
{
$oldpartition = "$partition";
$oldwampproot = "$partwampp";
$ooldwampproot= $dir;
$oldos = "$os";
}

unset($newzeile);
$i=0;
$datei = fopen($ini,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$newzeile[]=$zeile; 
$i+=1; 
	}
// fclose($datei);

$oldini="$ini.old";
$old = fopen($oldini,'w');
for($z=0;$z<$i+1;$z++) 
{ 
fputs($old,$newzeile[$z]); 
}
fclose($old); 
	         
      $datei = fopen($ini,'w'); 
       if($datei) 
           { 
                for($z=0;$z<$i+1;$z++) 
                { 
					
					if (eregi("xampp",$newzeile[$z]))
					{
					if ($oldwampproot != $partwampp)
						{
						list ($left, $right) = split ($ooldwampproot, $newzeile[$z]);
						 $newline = "$left$dir$right";
						
							fputs($datei, $newline);
							
						}
						else

						{
						
						if (ereg($ppartition,$newzeile[$z]))
							{
list ($left, $right) = split ($ppartition, $newzeile[$z]);
  $newline = "$left$ppartition$right";
fputs($datei, $newline);

							}

							
 
  else
							{
list ($left, $right) = split ('/xampp', $newzeile[$z]);
 $newline = "$left$dir$right";
fputs($datei, $newline); 

						 }
						}
					}
					
					else { 
						fputs($datei,$newzeile[$z]); 
                 
						} 
                
            } 
        fclose($datei); 
      }
}

/// Function SLASH CONFIG end///


/// Function BACKSLASH CONFIG ///

function backslashconfig($ini)
{
$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = split ('\\\install', $curdir);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";

$wampp_lib="$partwampp\install\wampp.sys";
if(file_exists($wampp_lib)) 
{ 
$i=0;
$datei = fopen($wampp_lib,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$wamppzeile[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split ('=', $wamppzeile[0]);
$right = ereg_replace ("\n","",$right);
$oldpartition = "$right";
list ($left, $right) = split ('=', $wamppzeile[1]);
$right = ereg_replace ("\n","",$right);
$oldwampproot = "$right";
$oldwampproot_rp  = ereg_replace ("\\\\","'''", $oldwampproot);
$right = ereg_replace ("\\\\","/",$right);
$ooldwampproot = "$right";
list ($left, $right) = split ('=', $wamppzeile[2]);
$right = ereg_replace ("\n","",$right);
$oldos = "$right";
}
else
{
$oldpartition = "$partition";
$oldwampproot = "$partwampp";
$ooldwampproot= $dir;
$oldos = "$os";
}

unset($newzeile);
$i=0;

$datei = fopen($ini,'r');
while(!feof($datei)) 
{
$zeile = fgets($datei,255);
$newzeile[]=$zeile; 
$i+=1; 
}

fclose($datei);

	
$oldini="$ini.old";
$old = fopen($oldini,'w');
for($z=0;$z<$i+1;$z++) 
{ 
fputs($old,$newzeile[$z]); 
}
fclose($old); 
      
      
        
        $datei = fopen($ini,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi("xampp",$newzeile[$z]))
					{
						if ($oldwampproot != $partwampp)
						{
						$newzeile[$z] = ereg_replace ("\\\\","'''", $newzeile[$z]);
						list ($left, $right) = split ($oldwampproot_rp, $newzeile[$z]);
						 $newline = "$left$partwampp$right";
						 $newline = ereg_replace ("'''","\\", $newline);
							fputs($datei, $newline);
						}
						else
						{
						if (ereg($ppartition,$newzeile[$z]))
	{
list ($left, $right) = split ($ppartition, $newzeile[$z]);
  $newline = "$left$ppartition$right";
fputs($datei, $newline);

	}
 
  else
	{
list ($left, $right) = split ('\\\xampp', $newzeile[$z]);
  $newline = "$left$partwampp$right";
fputs($datei, $newline); 

	 }
	}
}
					
					else { 
						fputs($datei,$newzeile[$z]); 
                        // fputs($datei,$tmp);
						} 
                
            } 
        fclose($datei); 
      } 
}

/// Function BACKSLASH CONFIG END ///


/// Function ETC. CONFIG ///

function etc($ini)
{
$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = split ('\\\install', $curdir);
$phpdir = $partwampp;
$dir = ereg_replace ("\\\\","/",$partwampp);
$ppartition="$partition:";

$wampp_lib="$partwampp\install\wampp.sys";
if(file_exists($wampp_lib)) 
{ 
$i=0;
$datei = fopen($wampp_lib,'r');
while(!feof($datei)) 
	{
$zeile = fgets($datei,255);
$wamppzeile[]=$zeile; 
$i+=1; 
	}
fclose($datei);
list ($left, $right) = split ('=', $wamppzeile[0]);
$right = ereg_replace ("\n","",$right);
$oldpartition = "$right";
list ($left, $right) = split ('=', $wamppzeile[1]);
$right = ereg_replace ("\n","",$right);
$oldwampproot = "$right";
$oldwampproot_rp  = ereg_replace ("\\\\","'''", $oldwampproot);
$right = ereg_replace ("\\\\","/",$right);
$ooldwampproot = "$right";
list ($left, $right) = split ('=', $wamppzeile[2]);
$right = ereg_replace ("\n","",$right);
$oldos = "$right";
}
else
{
$oldpartition = "$partition";
$oldwampproot = "$partwampp";
$ooldwampproot= $dir;
$oldos = "$os";
}

unset($newzeile);
$i=0;

$datei = fopen($ini,'r');
while(!feof($datei)) 
{
$zeile = fgets($datei,255);
$newzeile[]=$zeile; 
$i+=1; 
}

fclose($datei);

	      
      
        
        $datei = fopen($ini,'w'); 
        if($datei) 
            { 
                for($z=0;$z<$i+1;$z++) 
                { 
					if (eregi("xampp",$newzeile[$z]))
					{
						if ($oldwampproot != $partwampp)
						{
						$newzeile[$z] = ereg_replace ("\\\\","'''", $newzeile[$z]);
						list ($left, $right) = split ($oldwampproot_rp, $newzeile[$z]);
						 $newline = "$left$partwampp$right";
						 $newline = ereg_replace ("'''","\\", $newline);
							fputs($datei, $newline);
						}
						else
						{
						if (ereg($ppartition,$newzeile[$z]))
	{
list ($left, $right) = split ($ppartition, $newzeile[$z]);
  $newline = "$left$ppartition$right";
fputs($datei, $newline);

	}
 
  else
	{
list ($left, $right) = split ('\\\xampp', $newzeile[$z]);
  $newline = "$left$partwampp$right";
fputs($datei, $newline); 

	 }
	}
}
					
					else { 
						fputs($datei,$newzeile[$z]); 
                        // fputs($datei,$tmp);
						} 
                
            } 
        fclose($datei); 
      } 
}

/// Function ETC. CONFIG END ///



if(file_exists($wampp_lib)) 
{
global $BS; 
$BS = 0;

set_time_limit(0);
define('STDIN',fopen("php://stdin","r"));
while($BS == "0")
{
echo "\n  Do you want to refresh the xampp installation?\n";
echo "  Soll die xampp Installation jetzt aktualisiert werden?\n\n";
echo "  1) Refresh now! (Jetzt aktualisieren!)\n";
echo "  x) Exit (Beenden)\n";

switch(trim(fgets(STDIN,256)))
{
case 1:
$BS = 1;
echo "\n  XAMPP is refreshing now ...\n";
echo "  XAMPP wird nun aktualisiert ...\n";
sleep(1);
break;

case "x":
echo "\n  The refresh is terminating on demand ...  exit\n";
echo "  Die Aktualisierung wurde auf Wunsch abgebrochen ...\n";
sleep(3);
exit();

default: 
exit();
}
}
fclose(STDIN);
}
else
{
global $BS; 
$BS = 0;

set_time_limit(0);
define('STDIN',fopen("php://stdin","r"));
while($BS == "0")
{
echo "\n  Do you want to start the xampp installation?\n";
echo "  Soll die xampp Installation jetzt gestartet werden?\n\n";
echo "  1) Install with MOD PERL (mit MOD PERL)\n";
echo "  2) Install without MOD PERL (ohne MOD PERL)\n";
echo "  x) Exit (Beenden)\n";

switch(trim(fgets(STDIN,256)))
{
case 1:
$BS = 1;
echo "\n  Installation with MOD_PERL is starting now.\n";
echo "  Installation mit MOD_PERL nun gestartet.\n";
sleep(1);
break;

case 2:
$BS = 2;
echo "\n  Installation without MOD_PERL is starting now.\n";
echo "  Installation ohne MOD_PERL nun gestartet.\n";
sleep(1);
break;

case "x":
echo "\n  The installation is terminating on demand ...  exit\n";
echo "  Die Installation wurde auf Wunsch abgebrochen ...\n";
sleep(3);
exit();

default: 
exit();
}
}
fclose(STDIN);
}
//   APACHE HTTPD CONFIG START ///

if(file_exists($httpd_ini) && fopen($httpd_ini,'a+')) 
{ 
print "\n  Configure Apache HTTPD in $httpd_ini ...";
sleep(1);

if(file_exists($wampp_lib)) 
{
slashconfig($httpd_ini);
}
else
{
httpconfig($httpd_ini,$BS);
}

print "\n  Done!";
sleep(1);      
}

else
{
warning('httpd.conf',$httpd_ini);
}
//  APACHE HTTPD CONFIG END ///

//   APACHE SSL CONFIG START ///

if(file_exists($ssl_ini) && fopen($ssl_ini,'a+')) 
{ 
print "\n\n  Configure Apache SSL in $ssl_ini ...";
sleep(1);

slashconfig($ssl_ini);

print "\n  Done!";
sleep(1);      
}

else
{
warning('ssl.conf',$ssl_ini);
}
//  APACHE SSL CONFIG END ///


//   APACHE MOD_DAV CONFIG START ///

if(file_exists($moddav_ini) && fopen($moddav_ini,'a+')) 
{ 

print "\n\n  Configure Apache MOD_DAV in $moddav_ini ...";
sleep(1);

slashconfig($moddav_ini);

print "\n  Done!";
sleep(1);   
}

else
{
warning('moddav.conf',$moddav_ini);
}
//  APACHE MOD_DAV CONFIG END ///



///   PHP CONFIG START ///

if(file_exists($php_ini) && fopen($php_ini,'a+')) 
{ 

print "\n\n  Configure PHP for MOD_PHP in $php_ini ...";
sleep(1);

backslashconfig($php_ini);

print "\n  Done!";
sleep(1);  
}

	  else
{
warning('php.ini',$php_ini);
}
//   PHP CONFIG END ///


///   PHP CGI CONFIG START ///

if(file_exists($phpcgi_ini) && fopen($phpcgi_ini,'a+')) 
{ 
print "\n\n  Configure PHP for CGI in $phpcgi_ini ...";
sleep(1);

backslashconfig($phpcgi_ini);

print "\n  Done!";
sleep(1);   
}

	  else
{
warning('php.ini',$phpcgi_ini);
}
//   PHP CGI CONFIG END ///


/// MYSQL CONFIG START ///

if(file_exists($mysql_ini) && fopen($mysql_ini,'a+')) 
{ 

print "\n\n  Configure MySQL DEFAULT in $mysql_ini ...";
sleep(1);

slashconfig($mysql_ini);

print "\n  Done!";
sleep(1);  
}

else
{
warning('my.cnf',$mysql_ini);
}
/// MYSQL CONFIG END ///


/// MYSQL NT CONFIG START ///

if(file_exists($mysqlnt_ini) && fopen($mysqlnt_ini,'a+')) 
{ 

print "\n\n  Configure MySQL NT in $mysqlnt_ini ...";
sleep(1);

slashconfig($mysqlnt_ini);

print "\n  Done!";
sleep(1);  
}

else
{
warning('my.nt-cnf',$mysqlnt_ini);
}
/// MYSQL NT CONFIG END ///

///   FileZilla FTP CONFIG START ///

if(file_exists($filezilla_ini) && fopen($filezilla_ini,'a+')) 
{ 
print "\n\n  Configure FileZilla FTP Server in $filezilla_ini ...";
sleep(1);

backslashconfig($filezilla_ini);

print "\n  Done!";
sleep(1);   
}

	  else
{
warning('FileZilla Server.xml',$filezilla_ini);
}
//   FileZilla FTP CONFIG END ///

///   MERCURY MAILSEVRER CONFIG START ///

if(file_exists($mercury_ini) && fopen($mercury_ini,'a+')) 
{ 
print "\n\n  Configure Mercury Mail Server in $mercury_ini ...";
sleep(1);

backslashconfig($mercury_ini);

print "\n  Done!";
sleep(1);   
}

	  else
{
warning('MERCURY.INI',$mercury_ini);
}
//   MERCURY MAILSEVRER CONFIG END ///

/// Perl PPM CONFIG START ///

if(file_exists($perlppm_ini) && fopen($perlppm_ini,'a+')) 
{ 
print "\n\n  Configure Perl PPM in $perlppm_ini ...";
sleep(1);

backslashconfig($perlppm_ini);

print "\n  Done!";
sleep(1);   
}

	  else
{
warning('ppm.xml',$perlppm_ini);
}
//   Perl PPM CONFIG END ///

/// WEBALIZER CONFIG START ///

if(file_exists($webalizer_ini) && fopen($webalizer_ini,'a+')) 
{ 
print "\n\n  Configure Webalizer in $webalizer_ini ...";
sleep(1);

backslashconfig($webalizer_ini);

print "\n  Done!";
sleep(1);   
}

	  else
{
warning('webalizer.conf',$webalizer_ini);
}
//   WEBALIZER CONFIG END ///

/// TEST.CGI CONFIG START ///
if(file_exists($test_cgi) && fopen($test_cgi,'a+')) 
{ 
print "\n\n  Configure all other (cgi, .htaccess, ...)";
sleep(1);

etc($test_cgi);
}
/// TEST.CGI CONFIG END ///

//  DRIVERS.PL CONFIG START ///
if(file_exists($drivers_pl) && fopen($drivers_pl,'a+')) 
{ 
etc($drivers_pl);
}
//  DRIVERS.PL CONFIG END ///


//   PRINTENV.PL CONFIG START ///
if(file_exists($printenv_pl) && fopen($printenv_pl,'a+')) 
{ 
etc($printenv_pl);
}
//   PRINTENV.PL CONFIG END ///

//   JPGRAPH CONFIG START ///
if(file_exists($jpgraph_one) && fopen($jpgraph_one,'a+')) 
{ 
slashconfig($jpgraph_one);
}
if(file_exists($jpgraph_two) && fopen($jpgraph_two,'a+')) 
{ 
slashconfig($jpgraph_two);
}
//   JPGRAPH CONFIG END ///

//  MOD DAV .HTACCESS CONFIG START ///
if(file_exists($htaccess_moddav) && fopen($htaccess_moddav,'a+')) 
{ 
slashconfig($htaccess_moddav);
print "\n  Done!";
sleep(1);
}
//  MOD DAV .HTACCESS CONFIG END ///


/// WAMPP LIB ///
$new_lib = fopen($wampp_lib,'w');
$wamppinfo = "Partition=$partition\nCurrent=$partwampp\nOS=$os"; 
fputs($new_lib,$wamppinfo); 
fclose($new_lib); 
// WAMPP LIB END///

if ($mistake > 0)
{
echo "\n\n  -----------------------------------------------------------\n";
echo "  The installation was incorrect! Copies of\n";
echo "  all old config files are provided as .old\n";
echo "  Bei der Installation sind Fehler aufgetreten! Kopien der\n";
echo "  alten Konfiguration mit den Endungen .old erstellt.\n";
echo "  -----------------------------------------------------------\n\n";
sleep(3);
}
else
{
print "\n\n  ####################################################\n";
print "  #   XAMPP installation successfully done!          #\n";
print "  #   Thank you for using XAMPP ApacheFriends!       #\n";
print "  #   XAMPP Installation erfolgreich beendet!        #\n";
print "  # Danke fuer das Interesse an XAMPP ApacheFriends! #\n";
print "  ####################################################\n\n";

if (!file_exists($apache_start))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo Diese Eingabeforderung nicht waehrend des Running beenden\r\n";
$value .= "echo Bitte erst bei einem gewollten Shutdown schliessen\r\n";
$value .= "echo Please close this command only for Shutdown\r\n";
$value .= "echo Apache 2 is starting ...\r\n";
$value .= "apache\bin\apache.exe\r\n";
$newbat = fopen($apache_start,'w');
fputs($newbat,$value); 
fclose($newbat);  
}

if (!file_exists($mysql_start))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo Diese Eingabeforderung nicht waehrend des Running beenden\r\n";
$value .= "echo Please dont close Window while MySQL is running\r\n";
$value .= "echo MySQL is trying to start\r\necho Please wait  ...\r\n";
$value .= "echo MySQL is starting with mysql\bin\my.cnf (console)\r\n";
$value .= "mysql\bin\mysqld --defaults-file=mysql\bin\my.cnf --standalone\r\n";
$newbat = fopen($mysql_start,'w');
fputs($newbat,$value); 
fclose($newbat);
}

if (!file_exists($mysql_stop))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo Mysql shutdowm ...\r\n";
$value .= "mysql\bin\mysqladmin shutdown\r\n";
$newbat = fopen($mysql_stop,'w');
fputs($newbat,$value); 
fclose($newbat);  
}
if (file_exists($mysql_ini))
{
copy ($mysql_ini,$my_example);
}


if (!file_exists($filezilla_start))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo FileZilla FTP Server is starting ... \r\n";
$value .= "echo Starte FileZilla FTP Server ... \r\n";
$value .= "FileZillaFTP\FileZillaServer.exe /start\r\n";
$newbat = fopen($filezilla_start,'w');
fputs($newbat,$value); 
fclose($newbat);  
}

if (!file_exists($filezilla_stop))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo FileZilla FTP Server is stopping ... \r\n";
$value .= "echo Stoppe FileZilla FTP Server ... \r\n";
$value .= "FileZillaFTP\FileZillaServer.exe /stop\r\n";
$newbat = fopen($filezilla_stop,'w');
fputs($newbat,$value); 
fclose($newbat);  
}

if (!file_exists($mercury_start))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "echo Mercury Mail Server is starting ... \r\n";
$value .= "echo Starte Mercury Mail Server ... \r\n";
$value .= "MercuryMail\mercury.exe\r\n";
$value .= "exit\r\n";
$newbat = fopen($mercury_start,'w');
fputs($newbat,$value); 
fclose($newbat);  
}

print "\n  APACHE START => \"apache_start.bat\"";
print "\n  MySQL START => \"mysql_start.bat\"\n\n";
sleep(6);
}

/* if (!file_exists($setup_bat))
{
unset($value);
$value .= "@echo off\r\n";
$value .= "set PHP_BIN=install\php.exe\r\n";
$value .= "set INSTALL_BIN=install\install.php\r\n";
$value .= "%PHP_BIN% -n -d output_buffering=0 -r \"echo '%os%'\"; > os.txt\r\n";
$value .= "%PHP_BIN% -n -d output_buffering=0 %INSTALL_BIN%\r\n";
$value .= "pause\r\n";
$newbat = fopen($setup_bat,'w');
fputs($newbat,$value); 
fclose($newbat); 
} 
if (file_exists($install_bat))
{
unlink ($install_bat);
} */

shell_exec("exit");
exit();
?>