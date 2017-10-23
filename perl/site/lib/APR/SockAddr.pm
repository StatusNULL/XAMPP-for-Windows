# 
# /*
#  * *********** WARNING **************
#  * This file generated by ModPerl::WrapXS/0.01
#  * Any changes made here will be lost
#  * ***********************************
#  * 01: lib/ModPerl/Code.pm:709
#  * 02: lib/ModPerl/WrapXS.pm:626
#  * 03: lib/ModPerl/WrapXS.pm:1175
#  * 04: C:\perl\bin\.cpanplus\5.10.0\build\mod_perl-2.0.4\Makefile.PL:423
#  * 05: C:\perl\bin\.cpanplus\5.10.0\build\mod_perl-2.0.4\Makefile.PL:325
#  * 06: C:\perl\bin\.cpanplus\5.10.0\build\mod_perl-2.0.4\Makefile.PL:56
#  * 07: C:\perl\bin\cpanp-run-perl.bat:21
#  */
# 


package APR::SockAddr;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::SockAddr - Perl API for APR socket address structure




=head1 Synopsis

  use APR::SockAddr ();
  
  my $ip = $sock_addr->ip_get;
  my $port = $sock_addr->port;





=head1 Description

C<APR::SockAddr> provides an access to a socket address structure
fields.

Normally you'd get a socket address object, by calling:

  use Apache2::Connection ();
  my $remote_sock_addr = $c->remote_addr;
  my $local_sock_addr  = $c->remote_local;




=head1 API

C<APR::SockAddr> provides the following functions and/or methods:





=head2 C<ip_get>

Get the IP address of the socket

  $ip = $sock_addr->ip_get();

=over 4

=item obj: C<$sock_addr>
( C<L<APR::SockAddr object|docs::2.0::api::APR::SockAddr>> )

=item ret: C<$ip> ( string )

=item since: 2.0.00

=back

If you are familiar with how perl's C<Socket> works:

  use Socket 'sockaddr_in';
  my ($serverport, $serverip) = sockaddr_in(getpeername($local_sock));
  my ($remoteport, $remoteip) = sockaddr_in(getpeername($remote_sock));

in apr-speak that'd be written as:

  use APR::SockAddr ();
  use Apache2::Connection ();
  my $serverport = $c->local_addr->port;
  my $serverip   = $c->local_addr->ip_get;
  my $remoteport = $c->remote_addr->port;
  my $remoteip   = $c->remote_addr->ip_get;


=head2 C<port>

Get the IP address of the socket

  $port = $sock_addr->port();

=over 4

=item obj: C<$sock_addr>
( C<L<APR::SockAddr object|docs::2.0::api::APR::SockAddr>> )

=item ret: C<$port> ( integer )

=item since: 2.0.00

=back

Example: see C<L<ip_get()|/C_ip_get_>>






=head1 Unsupported API

C<APR::SockAddr> also provides auto-generated Perl interface for a few
other methods which aren't tested at the moment and therefore their
API is a subject to change. These methods will be finalized later as a
need arises. If you want to rely on any of the following methods
please contact the L<the mod_perl development mailing
list|maillist::dev> so we can help each other take the steps necessary
to shift the method to an officially supported API.


=head2 C<equal>

META: Autogenerated - needs to be reviewed/completed

See if the IP addresses in two APR socket addresses are
equivalent.  Appropriate logic is present for comparing
IPv4-mapped IPv6 addresses with IPv4 addresses.

  $ret = $addr1->equal($addr2);

=over 4

=item obj: C<$addr1>
( C<L<APR::SockAddr object|docs::2.0::api::APR::SockAddr>> )

One of the APR socket addresses.

=item arg1: C<$addr2>
( C<L<APR::SockAddr object|docs::2.0::api::APR::SockAddr>> )

The other APR socket address.

=item ret: C<$ret> ( integer )

=item since: subject to change

=back

The return value will be non-zero if the addresses
are equivalent.


=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

