<?
// include("lang/".file_get_contents("lang.tmp").".php"); 
// global $TEXT;
function pagecode($beispiel)
	{
	   //  print("<p><br><br><h2>".$TEXT['srccode-header']."</h2>");
	    print("<p><br><br><h3><U>SOURCE CODE</h3>");
	    print("<textarea name=\"beispiel\" cols=\"80\" rows=\"18\" wrap=\"PHYSICAL\">");
		
	    if (file_exists($beispiel))
			{	
			$fp = fopen($beispiel, "r");
			while (!feof($fp))
				{
				$get= fgets($fp,4096);
				$get=ereg_replace("\\\\\"","\"",$get);
				 $get=ereg_replace("\\\\'","'",$get);
				 $get = ereg_replace( "\"","\"",$get); 
				//  $get = ereg_replace( "[\]","",$get);
				//  $get = ereg_replace( "\\\"","",$get); 
				print($get);
				// echo "$get";
				}
			fclose($fp);
			}
		print("</textarea><p>");
	} 

/* For Including in the Example 
if ($source=="in")
		{ include("code.php"); $beispiel = $SCRIPT_FILENAME; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} 
*/
?>

