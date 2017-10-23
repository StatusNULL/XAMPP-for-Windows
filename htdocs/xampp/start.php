<html>
<head>
<? include("lang/".file_get_contents("lang.tmp").".php"); ?>

<meta name="author" content="Kay Vogelgesang, Kai Oswald Seidler">
<link href="xampp.css" rel="stylesheet" type="text/css">
</head>

<body>

&nbsp;<br>
<h1><?=$TEXT['start-head']?> <?include(".version")?></h1>
<b><?=$TEXT['start-subhead']?></b><p>

<?=$TEXT['start-text1']?><p>
<? 
if ($TEXT['start-text-newest'])
{ echo "<p style=\"LEFT\">".$TEXT['start-text-newest']."</p>"; }
?>
<?=$TEXT['start-text2']?><p>
<?=$TEXT['start-text3']?><p>
<?=$TEXT['start-text4']?><p>
<?=$TEXT['start-text5']?><p>
<?=$TEXT['start-text6']?>

<? echo "<p>&nbsp;<br><i>".getenv("SERVER_SOFTWARE")."</i><br>"; ?>
<?
/* if (file_get_contents("lang.tmp")=="de")
{
include("lang/wisdoms-de.php");
$zufall=mt_rand(0,45);
 echo "<br>&nbsp;<h3><font size=2>Eine ganz kleine Weisheit:<br><cite>".$WISDOM[$zufall]."</cite></font></h3>";
} */
?>

</body>
</html>
