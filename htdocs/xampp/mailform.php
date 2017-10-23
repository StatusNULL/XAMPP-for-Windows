<html>
<head>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

&nbsp;<p>
<h1><?=$TEXT['mail-head']?></h1>
<a href=mercury-help.php><?=$TEXT['mail-hinweise']?></a><BR><BR>
<form method="POST" action="mailsend.php">
<table width=600 cellpadding=0 cellspacing=0 border=0>

<tr>
  <td align=left width="200"><?=$TEXT['mail-adress']?></td><td align=left width="400">

     <input type="text" name="knownsender" size="40" value="postmaster@localhost">

    </td>
</tr>

<tr>
  <td align=left width="200"><?=$TEXT['mail-adressat']?></td>
  <td align=left width="400"><input type="text" name="recipients" size="40" value="admin@localhost">
</td>
</tr>

<tr>
  <td align=left width="200"><?=$TEXT['mail-cc']?></td>
  <td align=left width="400"><input type="text" name="ccaddress" size="40">
</td>
</tr>
 
  <tr>
    <td align=left width="200"><?=$TEXT['mail-subject']?></td>
    <td align=left width="400"><input type="text" name="subject" size="40">
</td>

  </tr>
  <tr>
    <td align=left width="200">&nbsp;</td><td align=center width="400">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="200"><?=$TEXT['mail-message']?></td><td align=left width="400">

               <textarea rows="6" name="message" cols="34"></textarea>

     </td>
  </tr>
  <tr>
    <td align=left width="200">&nbsp;</td><td align=center width="400">&nbsp;</td>
  </tr>
  <tr>
    <td align=left width="200">&nbsp;</td><td align=left width="400"><input type=submit value="Abschicken"> * <input type=reset value="Zur&uuml;cksetzen"></form></td>
  </tr>
  </table>
</form>

</body>
</html>
