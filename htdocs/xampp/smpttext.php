<?

function smtp_connect($host, $port, $timeout=30, $echo_command=False, $echo_response=False, $nl2br=False)
   {
       $errno = 0;
       $errstr = 0;
       if($echo_command)
       {
           if($nl2br) { echo nl2br("CONNECTING TO $host\r\n"); }
           else { echo "CONNECTING TO $host\r\n"; }
       }
       $handle = fsockopen($host, $port, $errno, $errstr, $timeout);
       if(!$handle)
       {
           if($echo_command)
           {
               if($nl2br) { echo nl2br("CONNECTION FAILED\r\n"); }
               else { echo "CONNECTION FAILED\r\n"; }
           }
           return False;
       }
       if($echo_command)
       {
           if($nl2br) { echo nl2br("SUCCESS\r\n"); }
           else { echo "SUCCESS\r\n"; }
       }
       $response = fgets($handle,1);
       $bytes_left = socket_get_status($handle);
       if ($bytes_left > 0) { $response .= fread($handle, $bytes_left["unread_bytes"]); }
       if($echo_response)
       {
           if($nl2br) { echo nl2br($response); }
           else { echo $response; }
       }
       return $handle;
   }

   function smtp_command($handle, $command, $echo_command=False, $nl2br=False)
   {
       if($echo_command)
       {
           if($nl2br) { echo nl2br($command); }
           else { echo $command; }
       }
       fputs($handle, $command);
       $response = fgets($handle,1);
       $bytes_left = socket_get_status($handle);
       if ($bytes_left > 0) { $response .= fread($handle, $bytes_left["unread_bytes"]); }
       if($nl2br) { return nl2br($response); }
       else { return $response; }
   }
   
   function smtp_close($handle)
   {
       fclose($handle);
   }

$smtp_server="127.0.0.1";
if (smtp_connect($smtp_server, 25, 30, 1, 1, 1))
$smtp="OK";
else
$smtp="NOK";

echo "$smtp"; 

?>