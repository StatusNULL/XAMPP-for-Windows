<?	
class hello {
	function hello() {
		echo "Test";
	}
	 function RC4($pwd, $data)
    {
        
        $pwd_length = strlen($pwd);
        for ($i = 0; $i < 255; $i++) {
            $key[$i] = ord(substr($pwd, ($i % $pwd_length) + 1, 1));
            $counter[$i] = $i;
        } 

        for ($i = 0; $i < 255; $i++) {
            $x = ($x + $counter[$i] + $key[$i]) % 256;
            $temp_swap = $counter[$i];
            $counter[$i] = $counter[$x];
            $counter[$x] = $temp_swap;
        } 

        for ($i = 0; $i < strlen($data); $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $counter[$a]) % 256;
            $temp = $counter[$a];
            $counter[$a] = $counter[$j];
            $counter[$j] = $temp;
            $k = $counter[(($counter[$a] + $counter[$j]) % 256)];
            $Zcipher = ord(substr($data, $i, 1)) ^ $k;
            $Zcrypt .= chr($Zcipher);
        } 
        return $Zcrypt;
    } 

}
echo "\nTesting Functions\n\nPHP is more than you think...(RC4):\n";
$test = (hello::rc4("3.1415926", "PHP is more than you think..."));
echo "$test\n\n$test(RC4):\n";
echo (hello::rc4("3.1415926", $test). "\n")
?>