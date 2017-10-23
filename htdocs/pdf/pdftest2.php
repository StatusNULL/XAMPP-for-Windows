<?
include 'class.ezpdf.php';

// make a new pdf object
$pdf = new Cpdf();
// select the font
$pdf->selectFont('./fonts/Helvetica');
$pdf->addText(30,400,30,'Hello World');
$pdf->stream();


?>
