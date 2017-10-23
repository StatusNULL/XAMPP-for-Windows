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


package APR::Status;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::Status - Perl Interface to the APR_STATUS_IS_* macros



=head1 Synopsis

  use APR::Status ();
  eval { $obj->mp_method() };
  if ($@ && $ref $@ eq 'APR::Error' && APR::Status::is_EAGAIN($@)) {
      # APR_STATUS_IS_EAGAIN(s) of apr_errno.h is satisfied
  }






=head1 Description

An interface to F<apr_errno.h> composite error codes.

As discussed in the C<L<APR::Error|docs::2.0::api::APR::Error>>
manpage, it is possible to handle APR/Apache/mod_perl exceptions in
the following way:

  eval { $obj->mp_method() };
  if ($@ && $ref $@ eq 'APR::Error' && $@ == $some_code)
      warn "handled exception: $@";
  }

However, in cases where C<$some_code> is an L<APR::Const
constant|docs::2.0::api::APR::Const>, there may be more than one
condition satisfying the intent of this exception. For this purpose
the APR C library provides in F<apr_errno.h> a series of macros,
C<APR_STATUS_IS_*>, which are the recommended way to check for such
conditions. For example, the C<APR_STATUS_IS_EAGAIN> macro is defined
as

  #define APR_STATUS_IS_EAGAIN(s)         ((s) == APR_EAGAIN \
                  || (s) == APR_OS_START_SYSERR + ERROR_NO_DATA \
                  || (s) == APR_OS_START_SYSERR + SOCEWOULDBLOCK \
                  || (s) == APR_OS_START_SYSERR + ERROR_LOCK_VIOLATION)

The purpose of C<APR::Status> is to provide functions corresponding
to these macros.






=head1 Functions




=head2 C<is_EACCES>

Check if the error is matching C<EACCES> and its variants (corresponds
to the C<APR_STATUS_IS_EACCES> macro).

  $status = APR::Status::is_EACCES($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

An example of using C<is_EACCES> is when reading the contents of a
file where access may be forbidden:

  eval { $obj->slurp_filename(0) };
  if ($@) {
      return Apache2::Const::FORBIDDEN
          if ref $@ eq 'APR::Error' && APR::Status::is_EACCES($@);
      die $@;
   }

Due to possible variants in conditions matching C<EACCES>,
the use of this function is recommended for checking error codes
against this value, rather than just using
C<L<APR::Const::EACCES|docs::2.0::api::APR::Const/C_APR__Const__EACCES_>>
directly.







=head2 C<is_EAGAIN>

Check if the error is matching C<EAGAIN> and its variants (corresponds
to the C<APR_STATUS_IS_EAGAIN> macro).

  $status = APR::Status::is_EAGAIN($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

For example, here is how you may want to handle socket read exceptions
and do retries:

  use APR::Status ();
  # ....
  my $tries = 0;
  my $buffer;
  RETRY: my $rlen = eval { $socket->recv($buffer, SIZE) };
  if ($@ && ref($@) && APR::Status::is_EAGAIN($@)) {
      if ($tries++ < 3) {
          goto RETRY;
      }
      else {
          # do something else
      }
  }
  else {
      die "eval block has failed: $@";
  }

Notice that just checking against
C<L<APR::Const::EAGAIN|docs::2.0::api::APR::Const/C_APR__Const__EAGAIN_>>
may work on some Unices, but then it will certainly break on
win32. Thefore make sure to use this macro and not
C<APR::Const::EAGAIN> unless you know what you are doing.










=head2 C<is_ENOENT>

Check if the error is matching C<ENOENT> and its variants (corresponds
to the C<APR_STATUS_IS_ENOENT> macro).

  $status = APR::Status::is_ENOENT($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

An example of using C<is_ENOENT> is when reading the contents of a
file which may not exist:

  eval { $obj->slurp_filename(0) };
  if ($@) {
      return Apache2::Const::NOT_FOUND
          if ref $@ eq 'APR::Error' && APR::Status::is_ENOENT($@);
      die $@;
  }

Due to possible variants in conditions matching C<ENOENT>,
the use of this function is recommended for checking error codes
against this value, rather than just using
C<L<APR::Const::ENOENT|docs::2.0::api::APR::Const/C_APR__Const__ENOENT_>>
directly.









=head2 C<is_EOF>

Check if the error is matching C<EOF> and its variants (corresponds
to the C<APR_STATUS_IS_EOF> macro).

  $status = APR::Status::is_EOF($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

Due to possible variants in conditions matching C<EOF>,
the use of this function is recommended for checking error codes
against this value, rather than just using
C<L<APR::Const::EOF|docs::2.0::api::APR::Const/C_APR__Const__EOF_>>
directly.














=head2 C<is_ECONNABORTED>

Check if the error is matching C<ECONNABORTED> and its variants (corresponds
to the C<APR_STATUS_IS_ECONNABORTED> macro).

  $status = APR::Status::is_ECONNABORTED($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

Due to possible variants in conditions matching C<ECONNABORTED>,
the use of this function is recommended for checking error codes
against this value, rather than just using
C<L<APR::Const::ECONNABORTED|docs::2.0::api::APR::Const/C_APR__Const__ECONNABORTED_>> directly.







=head2 C<is_ECONNRESET>

Check if the error is matching C<ECONNRESET> and its variants
(corresponds to the C<APR_STATUS_IS_ECONNRESET> macro).

  $status = APR::Status::is_ECONNRESET($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

Due to possible variants in conditions matching C<ECONNRESET>, the use
of this function is recommended for checking error codes against this
value, rather than just using
C<L<APR::Const::ECONNRESET|docs::2.0::api::APR::Const/C_APR__Const__ECONNRESET_>>
directly.










=head2 C<is_TIMEUP>

Check if the error is matching C<TIMEUP> and its variants (corresponds
to the C<APR_STATUS_IS_TIMEUP> macro).

  $status = APR::Status::is_TIMEUP($error_code);

=over 4

=item arg1: C<$error_code> (integer or C<L<APR::Error
object|docs::2.0::api::APR::Error>> )

The error code or to check, normally C<$@> blessed into C<L<APR::Error
object|docs::2.0::api::APR::Error>>.

=item ret: C<$status> ( boolean )

=item since: 2.0.00

=back

Due to possible variants in conditions matching C<TIMEUP>,
the use of this function is recommended for checking error codes
against this value, rather than just using
C<L<APR::Const::TIMEUP|docs::2.0::api::APR::Const/C_APR__Const__TIMEUP_>>
directly.


=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.


=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.



=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut
