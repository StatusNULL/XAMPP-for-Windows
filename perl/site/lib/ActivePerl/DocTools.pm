package ActivePerl::DocTools;

use strict;
use warnings;
use Exporter ();

our @ISA = 'Exporter';
our @EXPORT = qw(UpdateHTML);

use ActivePerl::DocTools::TOC::HTML;
use ActivePerl::DocTools::TOC::RDF;

use ActivePerl::DocTools::Tree::HTML;

our $VERSION = 0.04;

our $dirbase = $ActivePerl::DocTools::TOC::dirbase;

sub WriteTOC {
    my $fh;
    unless (open $fh, '>', "$dirbase/perltoc.html") {
	warn "Unable to open $dirbase/perltoc.html for writing: $!\n";
	return undef;
    }

    my $html_toc = ActivePerl::DocTools::TOC::HTML->new();
    print $fh $html_toc->TOC();
}

sub WriteRDF {
    my $rdf_toc = ActivePerl::DocTools::TOC::RDF->new();
    print $rdf_toc->TOC();
}

sub UpdateHTML {
    # if $noisy is false, ignores errors
    # if $noisy is "wait", waits for confirmation
    # else dies if there are errors
    my $noisy = shift;
    eval {
	ActivePerl::DocTools::Tree::HTML::Update();
	WriteTOC();
    };
    if ($@ and $noisy) {
	if ($noisy eq 'wait') {
	    # this is somewhat bletcherous
	    print "Error building documentation: $@\n";
	    print "Press [Enter] to continue\n";
	    <STDIN>;
	    exit 1;
	}
	die $@;
    }
}

1;

__END__

#=head1 NAME

ActivePerl::DocTools - Perl extension for Documentation TOC Generation

#=head1 SYNOPSIS

	use ActivePerl::DocTools;
	
	ActivePerl::DocTools::WriteTOC();

#=head1 DESCRIPTION

Generates the TOC for Perl html docs. Currently used by PPM.

Much of the code that used to be in this module has been moved
out into the ActivePerl::DocTools::TOC packages. However, the
ActivePerl::DocTools::WriteTOC() function has been preserved for
compatibility with PPM.

#=head2 EXPORTS

Nothing.

#=head1 AUTHOR

David Sparks, DaveS@ActiveState.com
Neil Kandalgaonkar, NeilK@ActiveState.com

#=head1 SEE ALSO

The amazing L<PPM>.

L<ActivePerl::DocTools::TOC>

#=cut
