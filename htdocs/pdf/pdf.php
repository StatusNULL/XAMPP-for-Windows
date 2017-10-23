<?
if ($value2 != "" || $value2 != " ")
{ $co="c/o $value2"; }

include 'class.ezpdf.php';
	$pdf =& new Cezpdf();
	$pdf->addJpegFromFile('logo.jpg',250,770,100);
	$pdf->selectFont('./fonts/Helvetica');
	$pdf->ezText('',12);
	$pdf->addText(60,720,5,'ApacheFriends · WAMPP · www.apachefriends.org');
	$pdf->addText(60,700,9,$value1);
	$pdf->addText(60,690,9,$co);
	$pdf->addText(60,680,9,$value3);
	$pdf->addText(60,670,9,$value4);
	$pdf->addText(60,640,10,'Vielen Dank für Ihre Daten! Ein dynamisches PDF Dokument wurde eben erstellt.');
	$pdf->addText(60,620,10,'Thank you for your address! A new pdf document is provided.');
	$pdf->ezStream();
?>
