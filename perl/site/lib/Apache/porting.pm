package Apache::porting;

use strict;
use warnings FATAL => 'all';

use Carp 'croak';

use ModPerl::MethodLookup ();
use Apache::ServerUtil;

use Apache::Const -compile => 'OK';

our $AUTOLOAD;

### methods ###
# handle:
# - removed and replaced methods
# - hinting the package names in which methods reside

my %avail_methods = map { $_ => 1 } 
    (ModPerl::MethodLookup::avail_methods(),
     ModPerl::MethodLookup::avail_methods_compat());

# XXX: unfortunately it doesn't seem to be possible to install
# *UNIVERSAL::AUTOLOAD at the server startup, httpd segfaults,
# child_init seems to be the first stage where it works.
Apache->server->push_handlers(PerlChildInitHandler => \&porting_autoload);

sub porting_autoload {
    *UNIVERSAL::AUTOLOAD = sub {
        # This is a porting module, no compatibility layers are allowed in
        # this zone
        croak("Apache::porting can't be used with Apache::compat")
            if exists $ENV{"Apache/compat.pm"};

        (my $method = $AUTOLOAD) =~ s/.*:://;

        # we skip DESTROY methods
        return if $method eq 'DESTROY';

        # we don't handle methods that we don't know about
        croak "Undefined subroutine $AUTOLOAD called"
            unless defined $method && exists $avail_methods{$method};

        my ($hint, @modules) =
            ModPerl::MethodLookup::lookup_method($method, @_);
        $hint ||= "Can't find method $AUTOLOAD";
        croak $hint;
    };

    return Apache::OK;
}

### packages ###
# handle:
# - removed and replaced packages

my %packages = (
     'Apache::Constants' => [qw(Apache::Const)],
     'Apache::Table'     => [qw(APR::Table)],
     'Apache::File'      => [qw(Apache::Response Apache::RequestRec)],
     'Apache'            => [qw(ModPerl::Util Apache::Module)],
);

BEGIN {
    sub my_require {
        my $package = $_[0];
        $package =~ s|/|::|g;
        $package =~ s|.pm$||;

        # this picks the original require (which could be overriden
        # elsewhere, so we don't lose that) because we haven't
        # overriden it yet
        return require $_[0] unless $packages{$package};

        my $msg = "mod_perl 2.0 API doesn't include package '$package'.";
        my @replacements = @{ $packages{$package}||[] };
        if (@replacements) {
            $msg .= " The package '$package' has moved to " .
                join " ", map qq/'$_'/, @replacements;
        }
        croak $msg;
    };

    *CORE::GLOBAL::require = sub (*) { my_require($_[0])};
}

1;
=head1 NAME

Apache::porting -- a helper module for mod_perl 1.0 to mod_perl 2.0 porting

=head1 Synopsis

  # either add at the very beginning of startup.pl
  use Apache2;
  use Apache::porting;

  # or httpd.conf
  PerlModule Apache2
  PerlModule Apache::porting

  # now issue requests and look at the error_log file for hints

=head1 Description

C<Apache::porting> helps to port mod_perl 1.0 code to run under
mod_perl 2.0. It doesn't provide any back-compatibility functionality,
however it knows trap calls to methods that are no longer in the
mod_perl 2.0 API and tell what should be used instead if at all. If
you attempts to use mod_perl 2.0 methods without first loading the
modules that contain them, it will tell you which modules you need to
load. Finally if your code tries to load modules that no longer exist
in mod_perl 2.0 it'll also tell you what are the modules that should
be used instead.

C<Apache::porting> communicates with users via the I<error_log>
file. Everytime it traps a problem, it logs the solution (if it finds
one) to the error log file. If you use this module coupled with
C<L<Apache::Reload|docs::2.0::api::Apache::Reload>> you will be able
to port your applications quickly without needing to restart the
server on every modification.

It starts to work only when child process start and doesn't work for
the code that gets loaded at the server startup. This limitation is
explained in the L<Culprits|/Culprits> section.

It relies heavily on
C<L<ModPerl::MethodLookup|docs::2.0::api::ModPerl::MethodLookup>>.
which can also be used manually to lookup things.

=head1 Culprits

C<Apache::porting> uses the C<UNIVERSAL::AUTOLOAD> function to provide
its functionality. However it seems to be impossible to create
C<UNIVERSAL::AUTOLOAD> at the server startup, Apache segfaults on
restart. Therefore it performs the setting of C<UNIVERSAL::AUTOLOAD>
only during the I<child_init> phase, when child processes start. As a
result it can't help you with things that get preloaded at the server
startup.

If you know how to resolve this problem, please let us know. To
reproduce the problem try to use an earlier phase,
e.g. C<PerlPostConfigHandler>:

  Apache->server->push_handlers(PerlPostConfigHandler => \&porting_autoload);

=cut
