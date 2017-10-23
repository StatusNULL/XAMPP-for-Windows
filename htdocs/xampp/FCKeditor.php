<? 
include("../FCKeditor/fckeditor.php"); 
global $zeile;
?>

<?	

if ($fkcsend=="Submit")
	{	
		// echo "okay";
		$postArray = &$_POST;
		$text=$postArray[EditorAccessibility];
		$text=ereg_replace("\\\\\"","\"",$text);
	    $text=ereg_replace("\\\\'","'",$text);
		// $text = ereg_replace( "['\"\]", "", $text ); 
		// $text = ereg_replace( "'", "", $text );
	   // $text = ereg_replace( "\"", "", $text );
		$text= eregi_replace( "\\\\\\\\","\\", $text );

		// $text="GUT";
		// $postedValue = htmlspecialchars( stripslashes( $postArray ) ) ;
		$datei = fopen('guest-FCKeditor/FCKtext.txt','w'); 
        if($datei) 
            { 
				fputs($datei,$text); 
			}
		fclose($datei);
	}
?>

<html>
<head>
<meta name="author" content="Kay Vogelgesang, Kai Oswald Seidler">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>

<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
<?
if(file_exists('guest-FCKeditor/FCKtext.txt')) 
{ 
$i=0;
$datei = fopen('guest-FCKeditor/FCKtext.txt','r');
while(!feof($datei)) 
	{

$zeile = fgets($datei,255);
 $nValue[]=$zeile; 
 $i++; 
	}
fclose($datei);
}
?>

<? echo "<form action=\"$PHP_SELF\" method=\"post\" language=\"javascript\">"; ?>

&nbsp;<br>
<table border="0" width="100%">
<tr>
<td width="20">&nbsp;</td>
<td width="*"><h1><?=$TEXT['guest1-name']?></h1>
<?=$TEXT['guest1-text1']?> <?=$TEXT['guest1-text2']?><BR>&nbsp;<BR>
<?=$TEXT['guest1-text3']?>
<BR>


</td>
</tr>
<tr>
<td width="20">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="20">&nbsp;</td>
<td width="*">
<table border="2" width="100%" bordercolor="#000000">
<tr>
<td width="*">
<? 
$oFCKeditor = new FCKeditor ;
# $oFCKeditor->ToolbarSet = 'Accessibility' ;

foreach ($nValue as $value)
{ 
$readzeile .= $value; 
}
$oFCKeditor->Value = $readzeile; 
$oFCKeditor->CanUpload = false ;	// Overrides fck_config.js default configuration
$oFCKeditor->CanBrowse = false ;	// Overrides fck_config.js default configuration
$oFCKeditor->CreateFCKeditor( 'EditorAccessibility', '100%', 420 ) ;
?>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td width="20">&nbsp;</td>
<td width="*">&nbsp;</td>
</tr>
<tr>
<td width="20">&nbsp;</td>
<td width="*"><input name="fkcsend" type=submit value="Submit"></td>
</tr>
</table>

</form>


</body>
</html>
