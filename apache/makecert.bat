@echo off
set OPENSSL_CONF=./bin/openssl.cnf
if not exist .\conf\ssl.crt (
	mkdir .\conf\ssl.crt
)
if not exist .\conf\ssl.key (
	mkdir .\conf\ssl.key
)
openssl req -new -out server.csr
openssl rsa -in privkey.pem -out server.key
openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 365
set OPENSSL_CONF=
del privkey.pem
del server.csr
move /y server.crt .\conf\ssl.crt
move /y server.key .\conf\ssl.key
echo.
echo -----
echo Das Zertifikat wurde erstellt.
echo The certificate was provided.
echo.
pause