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


package APR::Bucket;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::Bucket - Perl API for manipulating APR Buckets




=head1 Synopsis

  use APR::Bucket ();
  my $ba = $c->bucket_alloc;
  
  $b1 = APR::Bucket->new($ba, "aaa");
  $b2 = APR::Bucket::eos_create($ba);
  $b3 = APR::Bucket::flush_create($ba);
  
  $b2->is_eos;
  $b3->is_flush;
  
  $len = $b1->length;
  $len = $b1->read($data);
  $type = $b1->type;
  
  $b1->insert_after($b2);
  $b1->insert_before($b3);
  $b1->remove;
  $b1->destroy;
  
  $b2->delete; # remove+destroy
  
  $b4 = APR::Bucket->new($ba, "to be setaside");
  $b4->setaside($pool);





=head1 Description

C<APR::Bucket> allows you to create, manipulate and delete APR
buckets.

You will probably find the various insert methods confusing, the tip
is to read the function right to left. The following code sample helps
to visualize the operations:

  my $bb = APR::Brigade->new($r->pool, $ba);
  my $d1 = APR::Bucket->new($ba, "d1");
  my $d2 = APR::Bucket->new($ba, "d2");
  my $f1 = APR::Bucket::flush_create($ba);
  my $f2 = APR::Bucket::flush_create($ba);
  my $e1 = APR::Bucket::eos_create($ba);
                           # head->tail
  $bb->insert_head(  $d1); # head->d1->tail
  $d1->insert_after( $d2); # head->d1->d2->tail
  $d2->insert_before($f1); # head->d1->f1->d2->tail
  $d2->insert_after( $f2); # head->d1->f1->d2->f2->tail
  $bb->insert_tail(  $e1); # head->d1->f1->d2->f2->e1->tail








=head1 API

C<APR::Bucket> provides the following functions and/or methods:






=head2 C<delete>

Tell the bucket to remove itself from the bucket brigade it belongs
to, and destroy itself.

  $bucket->delete();

=over 4

=item obj: C<$bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: no return value

=item since: 2.0.00

=back

If the bucket is not attached to any bucket brigade then this
operation just destroys the bucket.

C<delete> is a convenience wrapper, internally doing:

  $b->remove;
  $b->destroy;

Examples:

Assuming that C<$bb> already exists and filled with buckets, replace
the existing data buckets with new buckets with upcased data;

  for (my $b = $bb->first; $b; $b = $bb->next($b)) {
     if ($b->read(my $data)) {
          my $nb = APR::Bucket->new($bb->bucket_alloc, uc $data);
          $b->insert_before($nb);
          $b->delete;
          $b = $nb;
      }
  }





=head2 C<destroy>

Free the resources used by a bucket. If multiple buckets refer to the
same resource it is freed when the last one goes away.

  $bucket->destroy();

=over 4

=item obj: C<$bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: no return value

=item since: 2.0.00

=back

A bucket needs to be destroyed if it was L<removed|/C_remove_> from a
bucket brigade, to avoid memory leak.

If a bucket is linked to a bucket brigade, it needs to be
L<removed|/C_remove_> from it, before it can be destroyed.

Usually instead of calling:

  $b->remove;
  $b->destroy;

it's better to call C<L<delete|/C_delete_>> which does exactly that.









=head2 C<eos_create>

Create an I<EndOfStream> bucket.

  $b = APR::Bucket::eos_create($ba);

=over 4

=item arg1: C<$ba>
( C<L<APR::BucketAlloc object|docs::2.0::api::APR::BucketAlloc>> )

The freelist from which this bucket should be allocated

=item ret: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The new bucket

=item since: 2.0.00

=back

This bucket type indicates that there is no more data coming from down
the filter stack.  All filters should flush any buffered data at this
point.

Example:

  use APR::Bucket ();
  use Apache2::Connection ();
  my $ba = $c->bucket_alloc;
  my $eos_b = APR::Bucket::eos_create($ba);





=head2 C<flush_create>

Create a flush bucket.

  $b = APR::Bucket::flush_create($ba);

=over 4

=item arg1: C<$ba>
( C<L<APR::BucketAlloc object|docs::2.0::api::APR::BucketAlloc>> )

The freelist from which this bucket should be allocated

=item ret: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The new bucket

=item since: 2.0.00

=back

This bucket type indicates that filters should flush their data.
There is no guarantee that they will flush it, but this is the best we
can do.






=head2 C<insert_after>

Insert a list of buckets after a specified bucket

  $after_bucket->insert_after($add_bucket);

=over 4

=item obj: C<$after_bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The bucket to insert after

=item arg1: C<$add_bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The buckets to insert. It says buckets, since C<$add_bucket> may have
more buckets attached after itself.

=item ret: no return value

=item since: 2.0.00

=back





=head2 C<insert_before>

Insert a list of buckets before a specified bucket

  $before_bucket->insert_before($add_bucket);

=over 4

=item obj: C<$before_bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The bucket to insert before

=item arg1: C<$add_bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The buckets to insert. It says buckets, since C<$add_bucket> may have
more buckets attached after itself.

=item ret: no return value

=item since: 2.0.00

=back





=head2 C<is_eos>

Determine if a bucket is an EOS bucket

  $ret = $bucket->is_eos();

=over 4

=item obj: C<$bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$ret> ( boolean )

=item since: 2.0.00

=back





=head2 C<is_flush>

Determine if a bucket is a FLUSH bucket

  $ret = $bucket->is_flush();

=over 4

=item obj: C<$bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$ret> ( boolean )

=item since: 2.0.00

=back








=head2 C<length>

Get the length of the data in the bucket.

  $len = $b->length;

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$len> ( integer )

If the length is unknown, C<$len> value will be -1.

=item since: 2.0.00

=back






=head2 C<new>

Create a new bucket and initialize it with data:

  $nb = APR::Bucket->new($ba, $data);
  $nb =          $b->new($ba, $data);
  $nb = APR::Bucket->new($ba, $data, $offset);
  $nb = APR::Bucket->new($ba, $data, $offset, $len);

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object or class|docs::2.0::api::APR::Bucket>> )

=item arg1: C<$ba>
( C<L<APR::BucketAlloc object|docs::2.0::api::APR::BucketAlloc>> )

=item arg2: C<$data> ( string )

The data to initialize with.

B<Important:> in order to avoid unnecessary data copying the variable
is stored in the bucket object. That means that if you modify C<$data>
after passing it to C<new()> you will modify the data in the bucket as
well. To avoid that pass to C<new()> a copy which you won't modify.

=item opt arg3: C<$offset> ( number )

Optional offset inside C<$data>. Default: 0.

=item opt arg4: C<$len> ( number )

Optional partial length to read.

If C<$offset> is specified, then:

  length $buffer - $offset;

will be used. Otherwise the default is to use:

  length $buffer;

=item ret: C<$nb>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

a newly created bucket object

=item since: 2.0.00

=back

Examples:

=over

=item *

Create a new bucket using a whole string:

  use APR::Bucket ();
  my $data = "my data";
  my $b = APR::Bucket->new($ba, $data);

now the bucket contains the string I<'my data'>.

=item *

Create a new bucket using a sub-string:

  use APR::Bucket ();
  my $data   = "my data";
  my $offset = 3;
  my $b = APR::Bucket->new($ba, $data, $offset);

now the bucket contains the string I<'data'>.

=item *

Create a new bucket not using the whole length and starting from an
offset:

  use APR::Bucket ();
  my $data   = "my data";
  my $offset = 3;
  my $len    = 3;
  my $b = APR::Bucket->new($ba, $data, $offset, $len);

now the bucket contains the string I<'dat'>.

=back





=head2 C<read>

Read the data from the bucket.

  $len = $b->read($buffer);
  $len = $b->read($buffer, $block);

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

The bucket to read from

=item arg1: C<$buffer> ( SCALAR )

The buffer to fill. All previous data will be lost.

=item opt arg2: C<$block> ( C<L<APR::Const :read_type
constant|docs::2.0::api::APR::Const/C__read_type_>> )

optional reading mode constant.

By default the read is blocking, via C<L<APR::Const::BLOCK_READ
constant|docs::2.0::api::APR::Const/C_APR__Const__BLOCK_READ_>>.

=item ret: C<$len> ( number )

How many bytes were actually read

C<$buffer> gets populated with the string that is read. It will
contain an empty string if there was nothing to read.

=item since: 2.0.00

=item excpt: C<L<APR::Error|docs::2.0::api::APR::Error>>

=back

It's important to know that certain bucket types (e.g. file bucket),
may perform a split and insert extra buckets following the current
one. Therefore never call C<L<$b-E<gt>remove|/C_remove_>>, before
calling C<$b-E<gt>read>, or you may lose data.

Examples:

Blocking read:

  my $len = $b->read(my $buffer);

Non-blocking read:

  use APR::Const -compile 'NONBLOCK_READ';
  my $len = $b->read(my $buffer, APR::Const::NONBLOCK_READ);






=head2 C<remove>

Tell the bucket to remove itself from the bucket brigade it belongs
to.

  $bucket->remove();

=over 4

=item obj: C<$bucket>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: no return value

=item since: 2.0.00

=back

If the bucket is not attached to any bucket brigade then this
operation doesn't do anything.

When the bucket is removed, it's not not destroyed. Usually this is
done in order to move the bucket to another bucket brigade. Or to copy
the data way before destroying the bucket.  If the bucket wasn't moved
to another bucket brigade it must be L<destroyed|/C_destroy_>.

Examples:

Assuming that C<$bb1> already exists and filled with buckets, move
every odd bucket number to C<$bb2> and every even to C<$bb3>:

  my $bb2 = APR::Brigade->new($c->pool, $c->bucket_alloc);
  my $bb3 = APR::Brigade->new($c->pool, $c->bucket_alloc);
  my $count = 0;
  while (my $bucket = $bb->first) {
      $count++;
      $bucket->remove;
      $count % 2
          ? $bb2->insert_tail($bucket)
          : $bb3->insert_tail($bucket);
  }






=head2 C<setaside>

Ensure the bucket's data lasts at least as long as the given pool:

  my $status = $b->setaside($pool);

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item arg1: C<$pool>
( C<L<APR::Pool object|docs::2.0::api::APR::Pool>> )

=item ret: ( C<L<APR::Const status
constant|docs::2.0::api::APR::Const>> )

On success,
C<L<APR::Const::SUCCESS|docs::2.0::api::APR::Const/C_APR__Const__SUCCESS_>> is
returned. Otherwise a failure code is returned.

=item excpt: C<L<APR::Error|docs::2.0::api::APR::Error>>

when your code deals only with mod_perl buckets, you don't have to ask
for the return value. If this method is called in the C<VOID> context,
i.e.:

  $b->setaside($pool);

mod_perl will do the error checking on your behalf, and if the return
code is not
C<L<APR::Const::SUCCESS|docs::2.0::api::APR::Const/C_APR__Const__SUCCESS_>>, an
C<L<APR::Error exception|docs::2.0::api::APR::Error>> will be thrown.

However if your code doesn't know which bucket types it may need to
setaside, you may want to check the return code and deal with any
errors. For example one of the possible error codes is
C<L<APR::Const::ENOTIMPL|docs::2.0::api::APR::Const/C_APR__Const__ENOTIMPL_>>. As of
this writing the pipe and socket buckets can't C<setaside()>, in which
case you may want to look at the C<ap_save_brigade()> implementation.

=item since: 2.0.00

=back

Usually setaside is called by certain output filters, in order to
buffer socket writes of smaller buckets into a single write. This
method works on all bucket types (not only the mod_perl bucket type),
but as explained in the exceptions section, not all bucket types
implement this method.

When a mod_perl bucket is setaside, its data is detached from the
original perl scalar and copied into a pool bucket. That allows
downstream filters to deal with the data originally owned by a Perl
interpreter, making it possible for that interpreter to go away and do
other things, or be destroyed.








=head2 C<type>

Get the type of the data in the bucket.

  $type = $b->type;

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$type>
( C<L<APR::BucketType object|docs::2.0::api::APR::BucketType>> )

=item since: 2.0.00

=back

You need to invoke
C<L<APR::BucketType|docs::2.0::api::APR::BucketType>> methods to
access the data.

Example:

Create a flush bucket and read its type's name:

  use APR::Bucket ();
  use APR::BucketType ();
  my $b = APR::Bucket::flush_create($ba);
  my $type = $b->type;
  my $type_name =  $type->name; # FLUSH

The type name will be I<'FLUSH'> in this example.


=head1 Unsupported API

C<APR::Socket> also provides auto-generated Perl interface for a few
other methods which aren't tested at the moment and therefore their
API is a subject to change. These methods will be finalized later as a
need arises. If you want to rely on any of the following methods
please contact the L<the mod_perl development mailing
list|maillist::dev> so we can help each other take the steps necessary
to shift the method to an officially supported API.





=head2 C<data>

  $data = $b->data;

Gives a C pointer to the address of the data in the bucket. I can't
see what use can be done of it in Perl.

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$data> ( C pointer )

=item since: subject to change

=back


=head2 C<start>

  $start = $b->start;

It gives the offset to when a new bucket is created with a non-zero
offset value:

  my $b = APR::Bucket->new($ba, $data, $offset, $len);

So if the offset was 3. C<$start> will be 3 too.

I fail to see what it can be useful for to the end user (it's mainly
used internally).

=over 4

=item obj: C<$b>
( C<L<APR::Bucket object|docs::2.0::api::APR::Bucket>> )

=item ret: C<$start> ( offset number )

=item since: subject to change

=back


=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

