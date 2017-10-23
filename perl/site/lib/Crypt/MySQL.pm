package Crypt::MySQL;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT_OK = qw(password);

$VERSION = '0.02';

bootstrap Crypt::MySQL $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Crypt::MySQL - emulate MySQL PASSWORD() function.

=head1 SYNOPSIS

  use Crypt::MySQL qw(password);

  my $encrypted = password("foobar");

=head1 DESCRIPTION

Crypt::MySQL emulates MySQL PASSWORD() SQL function, without libmysqlclient.
You can compare encrypted passwords, without real MySQL environment.

=head1 AUTHOR

IKEBE Tomohiro E<lt>ikebe@edge.co.jpE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<DBD::mysql>

=cut
