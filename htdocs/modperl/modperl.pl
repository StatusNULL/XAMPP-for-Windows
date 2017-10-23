print "Content-Type: text/html\n\n";

print '<html>';
print '<head>';
print '<meta name="author" content="Kay Vogelgesang">';
print '<link href="../xampp/xampp.css" rel="stylesheet" type="text/css">';
print '</head>';

print '<body>';
print '&nbsp;<p><h1>PERL 5.8.2 + MOD_PERL 1.99_12</h1><br>';
print 'Directory for MOD PERL => [..] \xampp\htdocs\modperl => <a href=/perl/modperl.pl>http://localhost/perl/modperl.pl</a><br><br>';
print 'Directory for PERL ASP => [..] \xampp\htdocs\perlasp =>  <a href=/asp/loop.asp>http://localhost/asp/loop.asp</a><br><br>&nbsp;<br>&nbsp;<br>';
use DBI;

@drivers = DBI ->available_drivers;
print "<b>Available drivers are:</b><p>";
foreach (@drivers) {
print "$_<br>";
}
print '<br>&nbsp;<br>&nbsp;<br><a href=http://www.perl.org target=top><IMG SRC=../xampp/img/powered_by_perl.gif border=0></a>';
print "</body>";
print "</html>";