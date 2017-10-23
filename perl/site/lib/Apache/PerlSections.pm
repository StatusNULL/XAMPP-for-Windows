package Apache::PerlSections;

use strict;
use warnings FATAL => 'all';

our $VERSION = '0.01';

use Apache::CmdParms ();
use Apache::Directive ();
use APR::Table ();
use Apache::Server ();
use Apache::ServerUtil ();
use Apache::Const -compile => qw(OK);

use constant SPECIAL_NAME => 'PerlConfig';
use constant SPECIAL_PACKAGE => 'Apache::ReadConfig';

sub new {
    my($package, @args) = @_;
    return bless { @args }, ref($package) || $package;
}

sub server     { return shift->{'parms'}->server() }
sub directives { return shift->{'directives'} ||= [] }
sub package    { return shift->{'args'}->{'package'} }

sub handler : method {
    my($self, $parms, $args) = @_;

    unless (ref $self) {
        $self = $self->new('parms' => $parms, 'args' => $args);
    }

    my $special = $self->SPECIAL_NAME;

    for my $entry ($self->symdump()) {
        if ($entry->[0] !~ /$special/) {
            $self->dump(@$entry);
        }
    }

    {
        no strict 'refs';
        my $package = $self->package;

        $self->dump_special(${"${package}::$special"},
          @{"${package}::$special"} );
    }

    $self->post_config();

    Apache::OK;
}

sub symdump {
    my($self) = @_;

    unless ($self->{symbols}) {
        no strict;
        
        $self->{symbols} = [];
        
        #XXX: Here would be a good place to warn about NOT using 
        #     Apache::ReadConfig:: directly in <Perl> sections
        foreach my $pack ($self->package, $self->SPECIAL_PACKAGE) {
            #XXX: Shamelessly borrowed from Devel::Symdump;
            while (my ($key, $val) = each(%{ *{"$pack\::"} })) {
                #We don't want to pick up stashes...
                next if ($key =~ /::$/);
                local (*ENTRY) = $val;
                if (defined $val && defined *ENTRY{SCALAR}) {
                    push @{$self->{symbols}}, [$key, $ENTRY];
                }
                if (defined $val && defined *ENTRY{ARRAY}) {
                    push @{$self->{symbols}}, [$key, \@ENTRY];
                }
                if (defined $val && defined *ENTRY{HASH} && $key !~ /::/) {
                    push @{$self->{symbols}}, [$key, \%ENTRY];
                }
            }
        }
    }

    return @{$self->{symbols}};
}

sub dump_special {
    my($self, @data) = @_;
    $self->add_config(@data);
}

sub dump {
    my($self, $name, $entry) = @_;
    my $type = ref $entry;

    if ($type eq 'ARRAY') {
        $self->dump_array($name, $entry);
    }
    elsif ($type eq 'HASH') {
        $self->dump_hash($name, $entry);
    }
    else {
        $self->dump_entry($name, $entry);
    }
}

sub dump_hash {
    my($self, $name, $hash) = @_;

    for my $entry (sort keys %{ $hash || {} }) {
        my $item = $hash->{$entry};
        my $type = ref($item);

        if ($type eq 'HASH') {
            $self->dump_section($name, $entry, $item);
        }
        elsif ($type eq 'ARRAY') {
            for my $e (@$item) {
                $self->dump_section($name, $entry, $e);
            }
        }
    }
}

sub dump_section {
    my($self, $name, $loc, $hash) = @_;

    $self->add_config("<$name $loc>\n");

    for my $entry (sort keys %{ $hash || {} }) {
        $self->dump_entry($entry, $hash->{$entry});
    }

    $self->add_config("</$name>\n");
}

sub dump_array {
    my($self, $name, $entries) = @_;

    for my $entry (@$entries) {
        $self->dump_entry($name, $entry);
    }
}

sub dump_entry {
    my($self, $name, $entry) = @_;
    my $type = ref $entry;

    if ($type eq 'SCALAR') {
        $self->add_config("$name $$entry\n");
    }
    elsif ($type eq 'ARRAY') {
        $self->add_config("$name @$entry\n");
    }
    elsif ($type eq 'HASH') {
        $self->dump_hash($name, $entry);
    }
    elsif ($type) {
        #XXX: Could do $type->can('httpd_config') here on objects ???
        die "Unknown type '$type' for directive $name";
    }
    elsif (defined $entry) {
        $self->add_config("$name $entry\n");
    }
}

sub add_config {
    my($self, $config) = @_;
    return unless defined $config;
    chomp($config);
    push @{ $self->directives }, $config;
}

sub post_config {
    my($self) = @_;
    my $errmsg = $self->server->add_config($self->directives);
    die $errmsg if $errmsg;
}

1;
__END__
=head1 NAME

Apache::PerlSections - Default Handler for Perl sections

=head1 Synopsis

  <Perl >
  @PerlModule = qw(Mail::Send Devel::Peek);
  
  #run the server as whoever starts it
  $User  = getpwuid(>) || >;
  $Group = getgrgid()) || ); 
  
  $ServerAdmin = $User;
  
  </Perl>

=head1 Description

With C<E<lt>Perl E<gt>>...C<E<lt>/PerlE<gt>> sections, it is possible
to configure your server entirely in Perl.

C<E<lt>Perl E<gt>> sections can contain I<any> and as much Perl code as
you wish. These sections are compiled into a special package whose
symbol table mod_perl can then walk and grind the names and values of
Perl variables/structures through the Apache core configuration gears.

Block sections such as C<E<lt>LocationE<gt>>..C<E<lt>/LocationE<gt>>
are represented in a C<%Location> hash, e.g.:

  <Perl>
  
  $Location{"/~dougm/"} = {
    AuthUserFile   => '/tmp/htpasswd',
    AuthType       => 'Basic',
    AuthName       => 'test',
    DirectoryIndex => [qw(index.html index.htm)],
    Limit          => {
        METHODS => 'GET POST',
        require => 'user dougm',
    },
  };
  
  </Perl>

If an Apache directive can take two or three arguments you may push
strings (the lowest number of arguments will be shifted off the
C<@list>) or use an array reference to handle any number greater than
the minimum for that directive:

  push @Redirect, "/foo", "http://www.foo.com/";
  
  push @Redirect, "/imdb", "http://www.imdb.com/";
  
  push @Redirect, [qw(temp "/here" "http://www.there.com")];

Other section counterparts include C<%VirtualHost>, C<%Directory> and
C<%Files>.

To pass all environment variables to the children with a single
configuration directive, rather than listing each one via C<PassEnv>
or C<PerlPassEnv>, a C<E<lt>Perl E<gt>> section could read in a file and:

  push @PerlPassEnv, [$key => $val];

or

  Apache->httpd_conf("PerlPassEnv $key $val");

These are somewhat simple examples, but they should give you the basic
idea. You can mix in any Perl code you desire. See I<eg/httpd.conf.pl>
and I<eg/perl_sections.txt> in the mod_perl distribution for more
examples.

Assume that you have a cluster of machines with similar configurations
and only small distinctions between them: ideally you would want to
maintain a single configuration file, but because the configurations
aren't I<exactly> the same (e.g. the C<ServerName> directive) it's not
quite that simple.

C<E<lt>Perl E<gt>> sections come to rescue. Now you have a single
configuration file and the full power of Perl to tweak the local
configuration. For example to solve the problem of the C<ServerName>
directive you might have this C<E<lt>Perl E<gt>> section:

  <Perl >
  $ServerName = `hostname`;
  </Perl>

For example if you want to allow personal directories on all machines
except the ones whose names start with I<secure>:

  <Perl >
  $ServerName = `hostname`;
  if ($ServerName !~ /^secure/) {
      $UserDir = "public.html";
  }
  else {
      $UserDir = "DISABLED";
  }
  </Perl>

=head1 Configuration Variables

There are a few variables that can be set to change the default
behaviour of C<E<lt>Perl E<gt>> sections.

=head2 C<$Apache::Server::SaveConfig>

By default, the namespace in which C<E<lt>Perl E<gt>> sections are
evaluated is cleared after each block closes. By setting it to a true
value, the content of those namespaces will be preserved and will be
available for inspection by modules like
C<L<Apache::Status|docs::2.0::api::Apache::Status>>.

=head2 C<$Apache::Server::StrictPerlSections>

By default, compilation and run-time errors within C<E<lt>Perl E<gt>>
sections will cause a warning to be printed in the error_log. By
setting this variable to a true value, code in the sections will be
evaluated as if "use strict" was in usage, and all warning and errors
will cause the server to abort startup and report the first error.

=head1 Advanced API

mod_perl 2.0 now introduces the same general concept of handlers to
C<E<lt>Perl E<gt>> sections.  Apache::PerlSections simply being the
default handler for them.

To specify a different handler for a given perl section, an extra
handler argument must be given to the section:

  <Perl handler="My::PerlSection::Handler" somearg="test1">
    $foo = 1;
    $bar = 2; 
  </Perl>

And in My/PerlSection/Handler.pm:

  sub My::Handler::handler : handler {
      my($self, $parms, $args) = @_;
      #do your thing!
  }

So, when that given C<E<lt>Perl E<gt>> block in encountered, the code
within will first be evaluated, then the handler routine will be
invoked with 3 arguments

C<$self> is self-explanatory

C<$parms> is the
C<L<Apache::CmdParms|docs::2.0::api::Apache::CmdParms>> for this
Container, for example, you might want to call C<$parms>-E<gt>server()
to get the current server.

C<$args> is an C<L<APR::Table|docs::2.0::api::APR::Table>> object of
the section arguments, the 2 guaranteed ones will be:

  $args->{'handler'} = 'My::PerlSection::Handler';
  
  $args->{'package'} = 'Apache::ReadConfig'; 

Other C<name="value"> pairs given on the C<E<lt>Perl E<gt>> line will
also be included.

At this point, it's up to the handler routing to inspect the namespace
of the C<$args>-E<gt>{'package'} and chooses what to do.

The most likely thing to do is to feed configuration data back into
apache. To do that, use Apache::Server-E<gt>add_config("directive"),
for example:

  $parms->server->add_config("Alias /foo /bar");

Would create a new alias. The source code of C<Apache::PerlSections>
is a good place to look for a practical example.

=head1 Bugs

=head2 E<lt>PerlE<gt> directive missing closing 'E<gt>'

httpd-2.0.47 and earlier had a bug in the configuration parser which
caused the startup failure with the following error:

  Starting httpd:
  Syntax error on line ... of /etc/httpd/conf/httpd.conf:
  <Perl> directive missing closing '>'     [FAILED]

This has been fixed in httpd-2.0.48. If you can't upgrade to this or a
higher version, please add a space before the closing 'E<gt>' of the
opening tag as a workaround. So if you had:

  <Perl>
  # some code
  </Perl>

change it to be:

  <Perl >
  # some code
  </Perl>

=cut
