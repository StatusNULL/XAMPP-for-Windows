<?
//    Copyright (C) 2002/2003 Kai Seidler, oswald@apachefriends.org
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

	if($text=="") $text="ceci n est pas un ami d apache";
	if($egal==0)
	{
		if($art==0)$art=rand(1000,9999);
		$artn=rand(1000,9999);
?>
<html>
<head>
<meta name="author" content="Kai Oswald Seidler, Kay Vogelgesang">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

&nbsp;<p>
<h1><?=$TEXT['iart-head']?></h1>

<img width=520 height=320 src=iart.php?egal=<? echo $art;?>&text=<?=urlencode($text)?>><p class=small>
<?=$TEXT['iart-text1']?><p>
<form name=ff action=iart.php method=get>
<input type=text name=text value="<?=$text?>" size=30> <input type=submit value="<?=$TEXT['iart-ok']?>">
<input type=hidden name=artn value="<?=$artn?>" size=30> 
</form>
<p>
<? if ($source=="in")
		{ include("code.php"); $beispiel = $SCRIPT_FILENAME; pagecode($beispiel);} 
		else
		{ print("<p><br><br><h2><U><a href=\"$PHP_SELF?source=in\">".$TEXT['srccode-in']."</a></U></h2>");} ?>
</body>
</html>
<?
	exit;
	}

	$fontfile=".\AnkeCalligraph.TTF";

	$size=9;
	$h=320;
	$w=520;

	$im  =  ImageCreate ( $w,  $h );

	$fill = ImageColorAllocate ( $im ,  251,  121, 34 );    
	$light = ImageColorAllocate ( $im,  255,  255,  255 );    
	$corners = ImageColorAllocate ( $im ,  153 , 153 ,  102 );    
	$dark = ImageColorAllocate ( $im , 51, 51 , 0 );    
	$black = ImageColorAllocate ( $im , 0, 0 , 0 );    

	$colors[1] = ImageColorAllocate ( $im ,  255 , 255 ,  255 );    
	$colors[2] = ImageColorAllocate ( $im ,  255*0.95 , 255*0.95 ,  255*0.95 );    
	$colors[3] = ImageColorAllocate ( $im ,  255*0.9 , 255*0.9 ,  255*0.9 );    
	$colors[4] = ImageColorAllocate ( $im ,  255*0.85 , 255*0.85 ,  255*0.85 );    

	header("Content-Type: image/png");    

	srand($egal);
	$c=1;
	$anz=10;
	$step=4/$anz;
	for($i=0;$i<$anz;$i+=1)
	{
		$size=rand(7,70);
		$x=rand(-390,390);
		$y=rand(-100,400);
		$color=$colors[$c];
		$c+=$step;
		ImageTTFText ($im, $size, 0, $x, $y, $color, $fontfile, $text);
	}

	ImageLine ( $im , 0 ,0, $w-1, 0, $light );    
	ImageLine ( $im , 0 ,0, 0, $h-2, $light );    
	ImageLine ( $im , $w-1,0, $w-1, $h, $dark );    
	ImageLine ( $im , 0 ,$h-1, $w-1, $h-1, $dark );    
	ImageSetPixel ( $im , 0 ,$h-1, $corners );    
	ImageSetPixel ( $im , $w-1 ,0, $corners );    

	ImagePNG ( $im );
?>
