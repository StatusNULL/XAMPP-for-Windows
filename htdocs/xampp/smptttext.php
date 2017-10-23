<?


	   $host = "127.0.0.1";
       $timeout= 4;
	   $port =25;
		if (($handle = @fsockopen($host, $port, $errno, $errstr, $timeout)) == false)
		$smtp="NOK";
		else
		$smtp="OK";

		echo "$smtp"; 
       

?>