--TEST--
UUID validation
--SKIPIF--
<?php if (!extension_loaded("uuid")) print "skip"; ?>
--POST--
--GET--
--INI--
--FILE--
<?php
echo (int)uuid_is_valid("this is not an UUID string")."\n";
echo (int)uuid_is_valid("b691c99c-7fc5-11d8-9fa8-00065b896488")."\n";
echo (int)uuid_is_valid("878b258c-a9f1-467c-8e1d-47d79ca2c01b")."\n";
echo (int)uuid_is_valid("00000000-0000-0000-0000-000000000000")."\n";
echo (int)uuid_is_valid("FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")."\n";
?>
--EXPECT--
0
1
1
1
1


