<?php
// php -f pear-installall.php
$lines = file ('pearlist.txt');
$list="pearlist.txt";
$pkt=@file($list);
if(is_array($pkt)) {
  foreach($pkt as $package) {
	$package=trim($package);
    system('pear install -a '.$package);
  }
}
?>
