package Class::MakeMethods::Autoload;

use strict;
use Carp;
require Exporter;

use Class::MakeMethods;
use Class::MakeMethods::Utility::Inheritable 'get_vvalue';

use vars qw( $VERSION @ISA @EXPORT_OK );

$VERSION = 1.000;
@ISA = qw(Exporter);
@EXPORT_OK = qw( AUTOLOAD );

########################################################################

use vars qw( $AUTOLOAD %DefaultType );

sub import {
  my $class = shift;
  my $target_class = ( caller(0) )[0];
  
  if ( scalar @_ and $_[0] =~ m/^\d/ ) {
    Class::MakeMethods::_import_version( $class, shift );
  }
  
  if ( scalar @_ == 1 ) {
    $DefaultType{ $target_class } = shift;
  }
  
  __PACKAGE__->Exporter::export_to_level(1, $class, 'AUTOLOAD');
}

sub AUTOLOAD {
  my $sym = $AUTOLOAD;
  my ($package, $func) = ($sym =~ /(.*)::([^:]+)$/);
  
  unless ( $DefaultType{$package} ) {
    local $_ = get_vvalue( \%DefaultType, $package );
    $DefaultType{$package} = $_ if ( $_ );
  }
  
  my $type = $DefaultType{$package} 
      or croak(__PACKAGE__ . ": No default method type for $package; can't auto-generate $func");
  
  if ( ref $type eq 'HASH' ) { 
    my $n_type = $type->{ $func } ||
	( map $type->{$_}, grep { $func =~ m/\A$_\Z/ } sort { length($b) <=> length($a) } keys %$type )[0] ||
	$type->{ '' } 
      or croak(__PACKAGE__ . ": Can't find best match for '$func' in type map (" . join(', ', keys %$type ) . ")");
    $type = $n_type;
  } elsif ( ref $type eq 'CODE' ) {
    $type = &$type( $func )
      or croak(__PACKAGE__ . ": Can't find match for '$func' in type map ($type)");
  }
  
  # warn "Autoload $func ($type)";
  Class::MakeMethods->make( 
    -TargetClass => $package,
    -ForceInstall => 1, 
    $type => $func
  );
  
  if ( my $sub = $package->can( $func ) ) {
    goto &$sub;
  } else {
    croak(__PACKAGE__ . ": Construction of $type method ${package}::$func failed to produce usable method")
  }
}

1;

__END__

=head1 NAME

Class::MakeMethods::Autoload - Declare generated subs with AUTOLOAD

=head1 SYNOPSIS

  package MyObject;
  use Class::MakeMethods::Autoload 'Standard::Hash::scalar';
  
  package main;
  my $obj = bless {}, 'MyObject';
  
  $obj->foo("Foozle");
  print $obj->foo();

=head1 DESCRIPTION

This package provides a generate-on-demand interface to Class::MakeMethods. 

When your class uses this package, it imports an AUTOLOAD function that resolves missing methods by using Class::MakeMethods to generate and install a standard type of method.

You must specify the type of method to be generated by passing a single argument to your use Class::MakeMethods::Autoload statement, which can take any of these forms:

=over 4

=item *

A Class::MakeMethods generator name and method type.

Here are three examples:

  use Class::MakeMethods::Autoload 'Standard::Hash:scalar';
  
  use Class::MakeMethods::Autoload 'Basic::Universal::no_op';
  
  use Class::MakeMethods::Autoload 
		'::Class::MakeMethod::Composite::Global:array';

=item *

A reference to a subroutine which will be called for each requested function name and which is expected to return the name of the method generator to use.

Here's a contrived example which generates scalar accessors for methods except those with a digit in their name, which are treated as globals.

  use Class::MakeMethods::Autoload sub { 
    my $name = shift;
    ( $name =~ /\d/ ) ? 'Standard::Global::scalar' 
		      : 'Standard::Hash::scalar'
  };

=item *

A reference to a hash which defines which method type to use based on the name of the requested method. If a key exists which is an exact match for the requested function name, the associated value is used; otherwise, each of the keys is used as a regular expression, and the value of the first one that matches the function name is used. (For regular expression matching, the keys are tested in reverse length order, longest to shortest.)

Here's an example which provides a new() constructor, a DESTROY() method that does nothing, and a wildcard match that provides scalar accessors for all other Autoloaded methods:

  use Class::MakeMethods::Autoload { 
    'new'     => 'Standard::Hash::new', 
    '.*'      => 'Standard::Hash::scalar',
    'DESTROY' => 'Standard::Universal::no_op',
  };

Here's a more sophisticated example which causes all-upper-case method names to be generated as globals, those with a leading upper-case letter to be generated as inheritable data methods, and others to be normal accessors:

  use Class::MakeMethods::Autoload { 
    'new'     => 'Standard::Hash::new', 
    '.*'      => 'Standard::Hash::scalar',
    '[A-Z].*' => 'Standard::Inheritable::scalar',
    '[A-Z0-9]+' => 'Standard::Global::scalar',
    'DESTROY' => 'Standard::Universal::no_op',
  };

=back

=head1 DIAGNOSTICS

The following warnings and errors may be produced when using
Class::MakeMethods::Attribute to generate methods. (Note that this
list does not include run-time messages produced by calling the
generated methods, or the standard messages produced by
Class::MakeMethods.)

=over

=item No default method type; can't autoload

You must declare a default method type, generally by passing its
name to a C<use Class::MakeMethods::Autoload> statement, prior to
autoloading any methods.

=item Construction of %s method %s failed to produce usable method

Indicates that Autoload succesfully called Class::MakeMethods->make
to generate the requested method, but afterwards was not able to
invoke the generated method. You may have selected an incompatible
method type, or the method may not have been installed sucesfully.

=back

=head1 SEE ALSO

See L<Class::MakeMethods> for general information about this distribution. 

=cut
