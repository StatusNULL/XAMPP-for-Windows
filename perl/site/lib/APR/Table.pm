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


package APR::Table;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::Table - Perl API for manipulating APR opaque string-content tables



=head1 Synopsis

  use APR::Table ();
  
  $table = APR::Table::make($pool, $nelts);
  $table_copy = $table->copy($pool);
  
  $table->clear();
  
  $table->set($key => $val);
  $table->unset($key);
  $table->add($key, $val);
  
  $val = $table->get($key);
  @val = $table->get($key);
  
  $table->merge($key => $val);
  
  use APR::Const -compile qw(:table);
  $table_overlay = $table_base->overlay($table_overlay, $pool);
  $table_overlay->compress(APR::Const::OVERLAP_TABLES_MERGE);
  
  $table_a->overlap($table_b, APR::Const::OVERLAP_TABLES_SET);
  
  $table->do(sub {print "key $_[0], value $_[1]\n"}, @valid_keys);
  
  #Tied Interface
  $value = $table->{$key};
  $table->{$key} = $value;
  print "got it" if exists $table->{$key};
  
  foreach my $key (keys %{$table}) {
      print "$key = $table->{$key}\n";
  }





=head1 Description

C<APR::Table> allows its users to manipulate opaque string-content
tables.

On the C level the "opaque string-content" means: you can put in
'\0'-terminated strings and whatever you put in your get out.

On the Perl level that means that we convert scalars into strings and
store those strings. Any special information that was in the Perl
scalar is not stored. So for example if a scalar was marked as utf8,
tainted or tied, that information is not stored. When you get the data
back as a Perl scalar you get only the string.

The table's structure is somewhat similar to the Perl's hash
structure, but allows multiple values for the same key.  An access to
the records stored in the table always requires a key.

The key-value pairs are stored in the order they are added.

The keys are case-insensitive.

However as of the current implementation if more than value for the
same key is requested, the whole table is lineary searched, which is
very inefficient unless the table is very small.

C<APR::Table> provides a L<TIE Interface|/TIE_Interface>.

See I<apr/include/apr_tables.h> in ASF's I<apr> project for low level
details.





=head1 API

C<APR::Table> provides the following functions and/or methods:




=head2 C<add>

Add data to a table, regardless of whether there is another element
with the same key.

  $table->add($key, $val);

=over 4

=item obj: C<$table> ( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to add to.

=item arg1: C<$key> ( string )

The key to use.

=item arg2: C<$val> ( string )

The value to add.

=item ret: no return value

=item since: 2.0.00

=back

When adding data, this function makes a copy of both the key and the
value.





=head2 C<clear>

Delete all of the elements from a table.

  $table->clear();

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to clear.

=item ret: no return value

=item since: 2.0.00

=back






=head2 C<compress>

Eliminate redundant entries in a table by either overwriting or
merging duplicates:

  $table->compress($flags);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to compress.

=item arg1: C<$flags>
(C<L<APR::Const constant|docs::2.0::api::APR::Const>>)

  APR::Const::OVERLAP_TABLES_MERGE -- to merge
  APR::Const::OVERLAP_TABLES_SET   -- to overwrite

=item ret: no return value

=item since: 2.0.00

=back

Converts multi-valued keys in C<$table> into single-valued keys.  This
function takes duplicate table entries and flattens them into a single
entry.  The flattening behavior is controlled by the (mandatory)
C<$flags> argument.

When C<$flags> == C<APR::Const::OVERLAP_TABLES_SET>, each key will be set to
the last value seen for that key.  For example, given key/value pairs
'foo =E<gt> bar' and 'foo =E<gt> baz', 'foo' would have a final value
of 'baz' after compression -- the 'bar' value would be lost.

When C<$flags> == C<APR::Const::OVERLAP_TABLES_MERGE>, multiple values for
the same key are flattened into a comma-separated list.  Given
key/value pairs 'foo =E<gt> bar' and 'foo =E<gt> baz', 'foo' would
have a final value of 'bar, baz' after compression.

Access the constants via:

  use APR::Const -compile qw(:table);

or an explicit:

  use APR::Const -compile qw(OVERLAP_TABLES_SET OVERLAP_TABLES_MERGE);

C<compress()> combined with C<L<overlay()|/C_overlay_>> does the same
thing as C<L<overlap()|/C_overlap_>>.

Examples:

=over

=item * C<APR::Const::OVERLAP_TABLES_SET>

Start with table C<$table>:

  foo => "one"
  foo => "two"
  foo => "three"
  bar => "beer"

which is done by:

  use APR::Const    -compile => ':table';
  my $table = APR::Table::make($r->pool, TABLE_SIZE);
  
  $table->set(bar => 'beer');
  $table->set(foo => 'one');
  $table->add(foo => 'two');
  $table->add(foo => 'three');

Now compress it using C<APR::Const::OVERLAP_TABLES_SET>:

  $table->compress(APR::Const::OVERLAP_TABLES_SET);

Now table C<$table> contains:

  foo => "three"
  bar => "beer"

The value I<three> for the key I<foo>, that was added last, took over
the other values.




=item * C<APR::Const::OVERLAP_TABLES_MERGE>

Start with table C<$table>:

  foo => "one"
  foo => "two"
  foo => "three"
  bar => "beer"

as in the previous example, now compress it using
C<APR::Const::OVERLAP_TABLES_MERGE>:

  $table->compress(APR::Const::OVERLAP_TABLES_MERGE);

Now table C<$table> contains:

  foo => "one, two, three"
  bar => "beer"

All the values for the same key were merged into one value.

=back





=head2 C<copy>

Create a new table and copy another table into it.

  $table_copy = $table->copy($p);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to copy.

=item arg1: C<$p>
( C<L<APR::Pool object|docs::2.0::api::APR::Pool>> )

The pool to allocate the new table out of.

=item ret: C<$table_copy>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

A copy of the table passed in.

=item since: 2.0.00

=back







=head2 C<do>

Iterate over all the elements of the table, invoking provided
subroutine for each element.  The subroutine gets passed as argument,
a key-value pair.

  $table->do(sub {...}, @filter);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to operate on.

=item arg1: C<$sub> ( CODE ref/string )

A subroutine reference or name to be called on each item in the table.
The subroutine can abort the iteration by returning 0 and should
always return 1 otherwise.

=item opt arg3: C<@filter> ( ARRAY )

If passed, only keys matching one of the entries in fC<@filter> will be
processed.

=item ret: no return value

=item since: 2.0.00

=back


Examples:

=over

=item *

This filter simply prints out the key/value pairs and counts how many
pairs did it see.

  use constant TABLE_SIZE => 20;
  our $filter_count;
  my $table = APR::Table::make($r->pool, TABLE_SIZE);
  
  # populate the table with ascii data
  for (1..TABLE_SIZE) {
      $table->set(chr($_+97), $_);
  }
  
  $filter_count = 0;
  $table->do("my_filter");
  print "Counted $filter_count elements";
  
  sub my_filter {
      my ($key, $value) = @_;
      warn "$key => $value\n";
      $filter_count++;
      return 1;
  }

Notice that C<my_filter> always returns 1, ensuring that C<do()> will
pass all the key/value pairs.


=item *

This filter is similar to the one from the previous example, but this
time it decides to abort the filtering after seeing half of the table,
by returning 0 when this happens.

  sub my_filter {
      my ($key, $value) = @_;
      $filter_count++;
      return $filter_count == int(TABLE_SIZE)/2 ? 0 : 1;
  }

=back






=head2 C<get>

Get the value(s) associated with a given key.  After this call, the
data is still in the table.

  $val = $table->get($key);
  @val = $table->get($key);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to search for the key.

=item arg1: C<$key> ( string )

The key to search for.

=item ret: C<$val> or C<@val>

In the scalar context the first matching value returned (the oldest in
the table, if there is more than one value). If nothing matches
C<undef> is returned.

In the list context the whole table is traversed and all matching
values are returned. An empty list is returned if nothing matches.

=item since: 2.0.00

=back








=head2 C<make>

Make a new table.

  $table = APR::Table::make($p, $nelts);

=over 4

=item obj: C<$p>
( C<L<APR::Pool object|docs::2.0::api::APR::Pool>> )

The pool to allocate the pool out of.

=item arg1: C<$nelts> ( integer )

The number of elements in the initial table. At least 1 or more. If 0
is passed APR will still allocate 1.

=item ret: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The new table.

=item since: 2.0.00

=back

This table can only store text data.





=head2 C<merge>

Add data to a table by merging the value with data that has already
been stored using ", " as a separator:

  $table->merge($key, $val);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to search for the data.

=item arg1: C<$key> ( string )

The key to merge data for.

=item arg2: C<$val> ( string )

The data to add.

=item ret: no return value

=item since: 2.0.00

=back

If the key is not found, then this function acts like
C<L<add()|/C_add_>>.

If there is more than one value for the same key, only the first (the
oldest) value gets merged.

Examples:

=over

=item *

Start with a pair:

  merge => "1"

and merge "a" to the value:

  $table->set(  merge => '1');
  $table->merge(merge => 'a');
  $val = $table->get('merge');

Result:

  $val == "1, a";




=item *

Start with a multivalued pair:

  merge => "1"
  merge => "2"

and merge "a" to the first value;

  $table->set(  merge => '1');
  $table->add(  merge => '2');
  $table->merge(merge => 'a');
  @val = $table->get('merge');

Result:

  $val[0] == "1, a";
  $val[1] == "2";

Only the first value for the same key is affected.



=item *

Have no entry and merge "a";

  $table->merge(miss => 'a');
  $val = $table->get('miss');

Result:

  $val == "a";

=back





=head2 C<overlap>

For each key/value pair in C<$table_b>, add the data to
C<$table_a>. The definition of C<$flags> explains how C<$flags> define
the overlapping method.

  $table_a->overlap($table_b, $flags);

=over 4

=item obj: C<$table_a>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to add the data to.

=item arg1: C<$table_b>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to iterate over, adding its data to table C<$table_a>

=item arg2: C<$flags> ( integer )

How to add the table to table C<$table_a>.

When C<$flags> == C<APR::Const::OVERLAP_TABLES_SET>, if another element
already exists with the same key, this will over-write the old data.

When C<$flags> == C<APR::Const::OVERLAP_TABLES_MERGE>, the key/value pair
from C<$table_b> is added, regardless of whether there is another
element with the same key in C<$table_a>.

=item ret: no return value

=item since: 2.0.00

=back

Access the constants via:

  use APR::Const -compile qw(:table);

or an explicit:

  use APR::Const -compile qw(OVERLAP_TABLES_SET OVERLAP_TABLES_MERGE);

This function is highly optimized, and uses less memory and CPU cycles
than a function that just loops through table C<$table_b> calling
other functions.

Conceptually, C<overlap()> does this:

  apr_array_header_t *barr = apr_table_elts(b);
  apr_table_entry_t *belt = (apr_table_entry_t *)barr-E<gt>elts;
  int i;
  
  for (i = 0; i < barr->nelts; ++i) {
      if (flags & APR_OVERLAP_TABLES_MERGE) {
          apr_table_mergen(a, belt[i].key, belt[i].val);
      }
      else {
          apr_table_setn(a, belt[i].key, belt[i].val);
      }
  }

Except that it is more efficient (less space and cpu-time) especially
when C<$table_b> has many elements.

Notice the assumptions on the keys and values in C<$table_b> -- they
must be in an ancestor of C<$table_a>'s pool.  In practice C<$table_b>
and C<$table_a> are usually from the same pool.

Examples:

=over

=item * C<APR::Const::OVERLAP_TABLES_SET>

Start with table C<$base>:

  foo => "one"
  foo => "two"
  bar => "beer"

and table C<$add>:

  foo => "three"

which is done by:

  use APR::Const    -compile => ':table';
  my $base = APR::Table::make($r->pool, TABLE_SIZE);
  my $add  = APR::Table::make($r->pool, TABLE_SIZE);
  
  $base->set(bar => 'beer');
  $base->set(foo => 'one');
  $base->add(foo => 'two');
  
  $add->set(foo => 'three');

Now overlap using C<APR::Const::OVERLAP_TABLES_SET>:

  $base->overlap($add, APR::Const::OVERLAP_TABLES_SET);

Now table C<$add> is unmodified and table C<$base> contains:

  foo => "three"
  bar => "beer"

The value from table C<add> has overwritten all previous values for
the same key both had (I<foo>).  This is the same as doing
C<L<overlay()|/C_overlay_>> followed by C<L<compress()|/C_compress_>>
with C<APR::Const::OVERLAP_TABLES_SET>.


=item * C<APR::Const::OVERLAP_TABLES_MERGE>

Start with table C<$base>:

  foo => "one"
  foo => "two"

and table C<$add>:

  foo => "three"
  bar => "beer"

which is done by:

  use APR::Const    -compile => ':table';
  my $base = APR::Table::make($r->pool, TABLE_SIZE);
  my $add  = APR::Table::make($r->pool, TABLE_SIZE);
  
  $base->set(foo => 'one');
  $base->add(foo => 'two');
  
  $add->set(foo => 'three');
  $add->set(bar => 'beer');

Now overlap using C<APR::Const::OVERLAP_TABLES_MERGE>:

  $base->overlap($add, APR::Const::OVERLAP_TABLES_MERGE);

Now table C<$add> is unmodified and table C<$base> contains:

  foo => "one, two, three"
  bar => "beer"

Values from both tables for the same key were merged into one
value. This is the same as doing C<L<overlay()|/C_overlay_>> followed
by C<L<compress()|/C_compress_>> with C<APR::Const::OVERLAP_TABLES_MERGE>.

=back





=head2 C<overlay>

Merge two tables into one new table. The resulting table may have more
than one value for the same key.

  $table = $table_base->overlay($table_overlay, $p);

=over 4

=item obj: C<$table_base>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to add at the end of the new table.

=item arg1: C<$table_overlay>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The first table to put in the new table.

=item arg2: C<$p>
( C<L<APR::Pool object|docs::2.0::api::APR::Pool>> )

The pool to use for the new table.

=item ret: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

A new table containing all of the data from the two passed in.

=item since: 2.0.00

=back


Examples:

=over

=item *

Start with table C<$base>:

  foo => "one"
  foo => "two"
  bar => "beer"

and table C<$add>:

  foo => "three"

which is done by:

  use APR::Const    -compile => ':table';
  my $base = APR::Table::make($r->pool, TABLE_SIZE);
  my $add  = APR::Table::make($r->pool, TABLE_SIZE);
  
  $base->set(bar => 'beer');
  $base->set(foo => 'one');
  $base->add(foo => 'two');
  
  $add->set(foo => 'three');

Now overlay using C<APR::Const::OVERLAP_TABLES_SET>:

  my $overlay = $base->overlay($add, APR::Const::OVERLAP_TABLES_SET);

That resulted in a new table C<$overlay> (tables C<add> and C<$base>
are unmodified) which contains:

  foo => "one"
  foo => "two"
  foo => "three"
  bar => "beer"

=back







=head2 C<set>

Add a key/value pair to a table, if another element already exists
with the same key, this will over-write the old data.

  $table->set($key, $val);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to add the data to.

=item arg1: C<$key> ( string )

The key to use.

=item arg2: C<$val> ( string )

The value to add.

=item ret: no return value

=item since: 2.0.00

=back

When adding data, this function makes a copy of both the key and the
value.



=head2 C<unset>

Remove data from the table.

  $table->unset($key);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

The table to remove data from.

=item arg1: C<$key> ( string )

The key of the data being removed.

=item ret: no return value

=item since: 2.0.00

=back




=head1 TIE Interface

C<APR::Table> also implements a tied interface, so you can work with the
C<$table> object as a hash reference.

The following tied-hash function are supported: C<FETCH>, C<STORE>,
C<DELETE>, C<CLEAR>, C<EXISTS>, C<FIRSTKEY>, C<NEXTKEY> and
C<DESTROY>.

Note regarding the use of C<values()>. C<APR::Table> can hold more
than one key-value pair sharing the same key, so when using a table
through the tied interface, the first entry found with the right key
will be used, completely disregarding possible other entries with the
same key.  With Perl 5.8.0 and higher C<values()> will correctly list
values the corresponding to the list generated by C<keys()>. That
doesn't work with Perl 5.6. Therefore to portably iterate over the
key-value pairs, use C<each()> (which fully supports multivalued
keys), or C<APR::Table::do>.





=head2 C<EXISTS>

  $ret = $table->EXISTS($key);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

=item arg1: C<$key> ( string )

=item ret: C<$ret> ( integer )

true or false

=item since: 2.0.00

=back





=head2 C<CLEAR>

  $table->CLEAR();

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

=item ret: no return value

=item since: 2.0.00

=back





=head2 C<STORE>

  $table->STORE($key, $val);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

=item arg1: C<$key> ( string )

=item arg2: C<$val> ( string )

=item ret: no return value

=item since: 2.0.00

=back





=head2 C<DELETE>

  $table->DELETE($key);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

=item arg1: C<$key> ( string )

=item ret: no return value

=item since: 2.0.00

=back





=head2 C<FETCH>

  $ret = $table->FETCH($key);

=over 4

=item obj: C<$table>
( C<L<APR::Table object|docs::2.0::api::APR::Table>> )

=item arg1: C<$key> ( string )

=item ret: C<$ret> ( string )

=item since: 2.0.00

=back

When iterating through the table's entries with C<each()>, C<FETCH>
will return the current value of a multivalued key.  For example:

  $table->add("a" => 1);
  $table->add("b" => 2);
  $table->add("a" => 3);
  
  ($k, $v) = each %$table; # (a, 1)
  print $table->{a};       # prints 1
  
  ($k, $v) = each %$table; # (b, 2)
  print $table->{a};       # prints 1
  
  ($k, $v) = each %$table; # (a, 3)
  print $table->{a};       # prints 3 !!!
  
  ($k, $v) = each %$table; # (undef, undef)
  print $table->{a};       # prints 1






=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

