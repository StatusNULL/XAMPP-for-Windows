\xampp\server\%1\security 
\xampp\apache\bin\openssl.exe req -config \xampp\apache\bin\openssl.cnf -new -x509 -days %2 -key %1.key -out %1.crt 
