<?php 
// create movie and set parameters 
$movie=new SWFMovie(); 
// $movie->setBackground(0xee,0xee,0xff);  // nice light blue 
$movie->setBackground(0x00, 0x00, 0xff);
$movie->setDimension(800,600); 
// draw rectangles 
for($c=0;$c<5;$c++) 
{ $shape=new SWFShape(); 
  // set line width 20, with blue shade 
  $shape->setLine(20,0x00,0x00,$c*50); 
  $offset=$c*20; 
  $shape->movePenTo(100+$offset,100+$offset); 
  $shape->drawLineTo(700-$offset,100+$offset); 
  $shape->drawLineTo(700-$offset,500-$offset); 
  $shape->drawLineTo(100+$offset,500-$offset); 
  $shape->drawLineTo(100+$offset,100+$offset); 
  // add to canvas 
  $movie->add($shape); 
  } 
// send output 
// header("Content-Type:application/x-shockwave-flash");  
$movie->output(); 
?> 
