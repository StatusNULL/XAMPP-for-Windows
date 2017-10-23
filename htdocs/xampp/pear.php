<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>
&nbsp;<form method="POST" action="../excel/excel.php">
<table width=500 cellpadding=0 cellspacing=0 border=0>


<tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480"><h1><?=$TEXT['pear-head']?></h1></td>
  </tr>
<tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480"><?=$TEXT['pear-text']?></td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
   <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480"><?=$TEXT['pear-cell']?></td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
<tr>
  <td align=left width="20">&nbsp;</td>
  <td align=left width="480">


     <input type="text" name="value" size="40">

    </td>
</tr>
<tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480"><input type=submit> * <input type=reset ></form></td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480"><? if ($source=="in")
		{ include("code.php"); $beispiel = "../excel/excel.php"; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} ?></td>
  </tr>
  <tr>
    <td align=left width="20">&nbsp;</td><td align=left width="480">&nbsp;</td>
  </tr>
  </table>


</body>
</html>
