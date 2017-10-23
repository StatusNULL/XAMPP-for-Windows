@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl -w
#line 15

require 5.004;

use strict;

use DBIx::XML_RDB;
use Getopt::Long;
use vars qw($datasource $driver $userid $password $table $outputfile $help $dbname $verbose @fields);

sub usage;

# Options to variables mapping
my %optctl = (
	'sn' => \$datasource,
	'uid' => \$userid,
	'pwd' => \$password,
	'table' => \$table,
	'output' => \$outputfile,
	'help' => \$help,
	'db' => \$dbname,
	'driver' => \$driver,
	'verbose' => \$verbose );

# Option types
my @options = (
			"sn=s",
			"uid=s",
			"pwd=s",
			"table=s",
			"output=s",
			"db=s",
			"driver=s",
			"help",
			"verbose"
			);

GetOptions(\%optctl, @options) || die "Get Options Failed";

usage if $help;

unless ($datasource && $userid && $table && $outputfile) {
	usage;
}

$driver = $driver || "ODBC"; # ODBC is the default. Change this if you wish.

my $xmlout = DBIx::XML_RDB->new($datasource, $driver, $userid, $password, $dbname)
	|| die "Failed to make new xmlout";

$xmlout->DoSql("SELECT * FROM $table ORDER BY 1");

use IO::File;

my $output = IO::File->new(">". $outputfile);

print $output $xmlout->GetData;

# End

sub usage {
	print <<EOF;
Usage:
    sql2xls.pl {Options}

    where options are:

        Option   ParamName     ParamDesc
        -sn      servername    Data source name
        [-driver dbi_driver]   Driver that DBI uses. Default is ODBC
        -uid     username      Username
        [-pwd     password]    Password
        -table   tablename     Table to extract
        -output  outputfile    File to place output in (excel file)
        [-db     dbname]       Sybase database name
        [-v or --verbose]      Verbose output
EOF
	exit;
}

__END__
:endofperl
