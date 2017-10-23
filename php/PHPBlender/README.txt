+--------------------------------------------+
| PHPBlender: PHP Freed From The Interpretor |
+--------------------------------------------+
TODO: Add More Coherent Readme

What is it ?
------------

PHPBlender is a tool to let you distribute your PHP scripts as an executable EXE. It is
similar to the PHPCompiler that was available for a couple of months a year or 2 ago.

Does it Compile Scripts?
------------------------

PHPBlender isn't a true compiler in the computer science sense of the term. True compilers
take the high-level code and turn it into machine/assembly code. 

Instead, PHPBlender takes your PHP code and the PHP interpretor itself and blends them into
standalone, PHP executable goodness.

Useage:
-------
Usage: blender.exe <input File> <Output>
     <input File>:  is location of thee code you want "blended". This can be a relative or absolute.
     <output File>: the name of what you want your blended code executeble
                    once compiled this must be called directly
                    (ie output.exe, not just output). Currently, this can not be any sort of path, just the filename. 

Bundling:
---------------
Take the resulting EXE and the files in the "bundle" directory. If your script requires any extensions, 
you'll also need to add those DLL files as well. You can either call them directly with a dl() or add them
to the blender.ini file. Distribute all of these files together.

