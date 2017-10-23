<?php
	dl("mmcache.dll");
	//		phpINI I/O v1.3 Beta
	//		Chris Bielinski <chris@converted.net>
	// 		Francis Woodhouse <deathwish@valve-erc.com>
	//		Matt Thomas <matt@myers-thomas.net>
	//		Thomas Kaiser <admin@tommunism.net>
	$argv = $_SERVER["argv"];
	function ini_raw_array($filename,$length=1024) 
	{
		// Do a simple test to see if the file exists, or else it creates an infinite loop in while
		if( $fp = fopen($filename, "r") )
		{
			$sections = 0;
			while(!feof($fp))
			{
				$line = trim(fgets($fp,$length));
				if(substr($line,0,1) == "[")
				{
					$sectionname = substr($line,1,strlen($line)-2);
					if (count($ini_array[$sectionname]))
						$sections=count($ini_array[$sectionname]);
					else
						$sections=0;
				}
				else if(strpos($line,"="))
				{
					$itemname = substr($line,0,strpos($line,"="));
					$itemvalue = substr($line,strpos($line,"=")+1);
					if(count($ini_array[$sectionname][$sections][$itemname]))
						$ini_array[$sectionname][$sections][$itemname][count($ini_array[$sectionname][$sections][$itemname])] = $itemvalue;
					else
						$ini_array[$sectionname][$sections][$itemname][0] = $itemvalue;
				}
			}
		}
		fclose($fp); // Don't forget the fclose!
		return $ini_array;
	}
	
	function ini_getitem($filename,$section,$item,$sectionnum=0,$itemnum=0,$length=1024,$notrim=false)
	{
		$ini_array = ini_raw_array($filename,$length);
		return $ini_array[$section][$sectionnum][$item][$itemnum];
	}
	
	function ini_removesection($filename,$section,$sectionnum=0,$length=1024)
	{
		
		$ini_array = ini_raw_array($filename,$length);
		$keys = array_keys($ini_array);
		for ( $a = 0; $a < count($keys); $a++ )
		{
			$ctr = 0;
			for ( $b = 0; $b < count($ini_array[$keys[$a]]); $b++ )
			{
				
				$keys2 = array_keys($ini_array[$keys[$a]][$b]);
				for ( $c = 0; $c < count($keys2); $c++ )
					for ( $d = 0; $d < count($ini_array[$keys[$a]][$b][$keys2[$c]]); $d++ )
					{
						if ( ! ( $keys[$a] == $section && $b == $sectionnum ) )
							$ini_new_array[$keys[$a]][$ctr][$keys2[$c]][$d] = $ini_array[$keys[$a]][$b][$keys2[$c]][$d];
					}
			}
			$ctr++;
		}
		ini_write_file($filename,$ini_new_array);
	}
	
	function ini_getsections($filename,$length=1024)
	{
		$ini_array = ini_raw_array($filename,$length);
		$keys = array_keys($ini_array);
		for ( $i = 0; $i < count($keys); $i++ )
			if ( count($ini_array[$keys[$i]]) > 1 )
				for ( $x = 0; $x < count($ini_array[$keys[$i]]); $x++ )
					$sections[] = $keys[$i];
			else
				$sections[] = $keys[$i];
		return $sections;
	}
	
	function ini_getitems($filename,$section,$sectionnum=0,$length=1024)
	{	
		$ini_array = ini_raw_array($filename,$length);
		return $ini_array[$section][$sectionnum];
	}
	
	function ini_changeitem($filename,$section,$item,$value,$sectionnum=0,$itemnum=0,$length=1024)
	{
		$ini_array = ini_raw_array($filename,$length);
		$ini_array[$section][$sectionnum][$item][$itemnum] = $value;
		ini_write_file($filename,$ini_array);
	}
	
	function ini_additem($filename,$section,$item,$value,$sectionnum=0,$length=1024)
	{
		$ini_array = ini_raw_array($filename,$length);
		if ( array_key_exists($item,$ini_array[$section][$sectionnum]) )
			$ini_array[$section][$sectionnum][$item][count($ini_array[$section][$sectionnum][$item])] = $value;
		else
			$ini_array[$section][$sectionnum][$item][0] = $value;
		ini_write_file($filename,$ini_array);
	}
	
	function ini_addsection($filename,$section,$item,$value,$length=1024)
	{
		$ini_array = ini_raw_array($filename,$length);
		if( array_key_exists($section,$ini_array) )
			$ini_array[$section][count($ini_array[$section])][$item][0] = $value;
		else
			$ini_array[$section][0][$item][0] = $value;
		ini_write_file($filename,$ini_array);
	}
	
	function ini_write_file($filename,$ini_array)
	{
		// Do a simple test to see if the file exists, or else it kills servers
		if( $fp = fopen($filename,"w") )
		{
			$keys = array_keys($ini_array);
			for ( $a = 0; $a < count($keys); $a++ )
				for ( $b = 0; $b < count($ini_array[$keys[$a]]); $b++ )
				{
					fwrite($fp,"[" . $keys[$a] . "]\r\n");
					$keys2 = array_keys($ini_array[$keys[$a]][$b]);
					for ( $c = 0; $c < count($keys2); $c++ )
						for ( $d = 0; $d < count($ini_array[$keys[$a]][$b][$keys2[$c]]); $d++ )
							fwrite($fp,$keys2[$c] . " = " . $ini_array[$keys[$a]][$b][$keys2[$c]][$d] . "\r\n");
					fwrite($fp,"\r\n");
				}
		}
		fclose($fp);
	}

set_time_limit(0);

if (count($argv) < 2 || in_array($argv[1], array('--help', '-help', '-h', '-?'))) {
	
   
?>
This is a command line utility for "blending" the PHP Parser with
your PHP Code for your sheer executable pleasure
	
Usage: blender.exe <input File> <Output>
     <input File>:  is location of thee code you want "blended"
     <output File>: the name of what you want your blended code executeble
                    once compiled this must be called directly
					(ie output.exe, not just output)                
  
Credits:  Joel Parish <joel@digitallandmarks.com>, J Wynia
   PHPBlender is sponsored by Pragmapool, Inc [http://www.pragmapool.com]     
   makers of Sokkit and other PHP-related products. 
   
   	For more information visit: http://www.phpblender.com
<?

} else {
	$argv1 =$argv[1];
	$argv2 =$argv[2];
	$argv3 =$argv[3];
	$argv4 =$argv[4];
	 if ($argv[3] == "-b") {
		`copy $argv4 $argv2}`;
    } elseif (count($argv) == 3) {
	`copy .\base\pembed.exe $argv2`;
	$fh = fopen($argv[2], "a");
	$code = mmcache_encode($argv[1]);
	echo "Siging {$argv[2]} footer with ({$argv[1]}) compiled code";
	fwrite($fh,"\x00\x00\x00\x00$code");
	fclose($fh);
	} else {
		echo "For Help: blender.bat --help";
	}
}
?>