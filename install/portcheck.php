<?php

$host="127.0.0.1";
$timeout= 1;
$i=1;

$curdir = getcwd();
list ($partition, $nonpartition) = split (':', $curdir);
list ($partwampp, $directorwampp) = spliti ('\\\install', $curdir);
$portchecklog=$partwampp."\install\\portcheck.ini";
// $portchecklog="$curdir\portcheck.log";

// if ($argc != 2 || in_array($argv[1], array('--80', '-80', '-?'))) {
$port=ereg_replace('-', '', $argv[1]);
$werte=substr_count($port, ',');
$ports= explode(',', $port);
$anzahl= count($ports);
// $port=ereg_replace('', '', $argv[1]); 
// settype($port, "integer");
$datei = fopen($portchecklog,'w+');
fputs($datei, "[Ports]\r\n");
while ($i <= $anzahl)
{
$a=$i-1;

settype($ports[$a], "integer");
	if (($handle = @fsockopen($host, $ports[$a], $errno, $errstr, $timeout)) == false)
	{ $print="Port".$ports[$a]."=FREE\r\n";
	// print "$print"; 
	}
		else
	{ $print="Port".$ports[$a]."=BLOCKED\r\n";
		// print "$print"; 
		}
		fputs($datei, $print);
		@fclose($handle);	
		$i++;
		
	}
fclose($datei);
exit;
?>


<?php
/*} else {
   echo $argv[1];
}*/
?> 