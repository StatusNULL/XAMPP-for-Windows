<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<meta name="author" content="Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</HEAD>

<body>
&nbsp;<p>
<table width=500 cellpadding=0 cellspacing=0 border=0>
<tr><td>
<h1>Mercury versendet nun die E-Mail ...</h1><p>
</td></tr>
<tr><td>&nbsp;<p>
<?
$schluessel="Mein Schluessel";
$text="Mein Text";

function encrypt($key, $plain_text) {
// returns encrypted text
// incoming: should be the $key that was encrypt
// with and the $plain_text that wants to be encrypted

  $plain_text = trim($plain_text);

  /* Quoting Mcrypt:
      "You must (in CFB and OFB mode) or can (in CBC mode)
       supply an initialization vector (IV) to the respective
       cipher function. The IV must be unique and must be the
       same when decrypting/encrypting."

     Meaning, we need a way to generate a _unique_ initialization vector
     but at the same time, be able to know how to gather our IV at both
     encrypt/decrypt stage.  My personal recommendation would be
     (if you are working with files) is to get the md5() of the file.
     In this example, however, I want more of a broader scope, so I chose
     to md5() the key, which should be the same both times. Note that the IV
     needs to be the size of our algorithm, hence us using substr.
  */

  $iv = substr(md5($key), 0,mcrypt_get_iv_size (MCRYPT_CAST_256,MCRYPT_MODE_CFB));
  $c_t = mcrypt_cfb (MCRYPT_CAST_256, $key, $plain_text, MCRYPT_ENCRYPT, $iv);

    return trim(chop(base64_encode($c_t)));
}
function decrypt($key, $c_t) {
// incoming: should be the $key that you encrypted
// with and the $c_t (encrypted text)
// returns plain text

  // decode it first :)
  $c_t =  trim(chop(base64_decode($c_t)));

  $iv = substr(md5($key), 0,mcrypt_get_iv_size (MCRYPT_CAST_256,MCRYPT_MODE_CFB));
  $p_t = mcrypt_cfb (MCRYPT_CAST_256, $key, $c_t, MCRYPT_DECRYPT, $iv);

         return trim(chop($p_t));
}



encrypt($schluessel,$text);
echo "$c_t";
decrypt($schluessel,$c_t);
echo "<p>$p_t";

?>
</td></tr>
<tr><td>&nbsp;<p>
<a href="javascript:history.back()">Zurück zum Formular</a>
</td></tr>
</table>
</BODY>
</HTML>