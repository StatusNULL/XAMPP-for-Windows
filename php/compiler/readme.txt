Welcome to PHPCompiler v0.0.2 Beta
--------------------------------------------

After quiet a no of suggestions, the second version of PHPCompiler is here. For those who do not know what
PHPCompiler is.. it is an Overlay Manager that makes your PHP Scripts to Windows executable files (.EXE) by
tacking the source to end of the custom coded loader. When used with PHP-GTK (http://gtk.php.net) One can create
true GUI applications that can perform any task that is possible in PHP.


	Steps in Compiling a script to Executable file:
	1) Specify the script to be compiled by clicking on "..." button in source section
	2) Specify the destination file with .exe extension
	3) Check the replace "require" and "include" button if you do not wish to include your include'ed or
	   required' files with your programs
	4) Click on Compile Button
	5) If you are creating a Console based app then click on yes when it asks for Build type.. else click on No
	   ie if you are making a PHP-GTK App
	6) Select whether or not the compiler should copy the php4ts.dll run time dll
	7) VOILA! you got a script compiled :)

-----------------------------------------------------------------------------------------------
CHANGE LOG
_______________________________________________________________________________________________

	Following are the new features:
	1) The EXE files now have an icon. That boring windows console icon is now gone :)
	2) Fixed a BUG that made this app crash when no file was specified in destination
	3) Made the destination extension to .exe instead of .php as it was before
	4) Made a prompt to enter the destination file if it isnt specified
	5) Added an option to make apps that dont have that DOS window.. pretty good for PHP-GTK Apps
	6) Changed the "phpcompiler is not a compiler but an encoder" to "PHPCompiler is an overlay manager" on
	   Zeev's request.
	7) Added indenting to source code

If you find a bug or want to request some feature email me at plot@deskmod.com. I would be glad to respond

Website: www.deskcode.com/phpcompiler
Version: 0.0.1 Beta

-------------------------------------------------------------------------------------------------------------
!!NOTE!!
This thing is compiled on PHP4.0.5RC1 and you can get it from http://www.php.net/distributions/RCs/php-4.0.5RC1.tar.gz.. 
to get readymade windows binary you will need to download them from ftp://ftp.phpuk.org/php_binaries

Also you will need to distribute php4ts.dll which is in data directory to the people whom you are sending your exe to.