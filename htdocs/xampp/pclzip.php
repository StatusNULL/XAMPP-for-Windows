<?php

$archivename="xamppinstall.zip"; 

  require_once('pclzip/pclzip.lib.php');
  
  $archive = new PclZip($archivename);
  if ($archive->create('\xampp\install') == 0) {
    die('Error : '.$archive->errorInfo(true));
  }

$location="http://localhost/xampp/$archivename";
header("Location: ".$location);  

?> 

