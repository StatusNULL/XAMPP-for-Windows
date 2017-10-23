/*    patchlevel.h
 *
 *    Copyright (C) 1993, 1995, 1996, 1997, 1998, 1999,
 *    2000, 2001, 2002, 2003, by Larry Wall and others
 *
 *    You may distribute under the terms of either the GNU General Public
 *    License or the Artistic License, as specified in the README file.
 *
 */

#ifndef __PATCHLEVEL_H_INCLUDED__

#include "BuildInfo.h"

/* do not adjust the whitespace! Configure expects the numbers to be
 * exactly on the third column */

#define PERL_REVISION	5		/* age */
#define PERL_VERSION	8		/* epoch */
#define PERL_SUBVERSION	2		/* generation */

/* The following numbers describe the earliest compatible version of
   Perl ("compatibility" here being defined as sufficient binary/API
   compatibility to run XS code built with the older version).
   Normally this should not change across maintenance releases.

   Note that this only refers to an out-of-the-box build.  Many non-default
   options such as usemultiplicity tend to break binary compatibility
   more often.

   This is used by Configure et al to figure out 
   PERL_INC_VERSION_LIST, which lists version libraries
   to include in @INC.  See INSTALL for how this works.
*/
#define PERL_API_REVISION	5	/* Adjust manually as needed.  */
#define PERL_API_VERSION	8	/* Adjust manually as needed.  */
#define PERL_API_SUBVERSION	0	/* Adjust manually as needed.  */
/*
   XXX Note:  The selection of non-default Configure options, such
   as -Duselonglong may invalidate these settings.  Currently, Configure
   does not adequately test for this.   A.D.  Jan 13, 2000
*/

#define __PATCHLEVEL_H_INCLUDED__
#endif

/*
	local_patches -- list of locally applied less-than-subversion patches.
	If you're distributing such a patch, please give it a name and a
	one-line description, placed just before the last NULL in the array
	below.  If your patch fixes a bug in the perlbug database, please
	mention the bugid.  If your patch *IS* dependent on a prior patch,
	please place your applied patch line after its dependencies. This
	will help tracking of patch dependencies.

	Please either use 'diff --unified=0' if your diff supports
	that or edit the hunk of the diff output which adds your patch
	to this list, to remove context lines which would give patch
	problems. For instance, if the original context diff is

	   *** patchlevel.h.orig	<date here>
	   --- patchlevel.h	<date here>
	   *** 38,43 ***
	   --- 38,44 ---
	     	,"FOO1235 - some patch"
	     	,"BAR3141 - another patch"
	     	,"BAZ2718 - and another patch"
	   + 	,"MINE001 - my new patch"
	     	,NULL
	     };
	
	please change it to 
	   *** patchlevel.h.orig	<date here>
	   --- patchlevel.h	<date here>
	   *** 41,43 ***
	   --- 41,44 ---
	   + 	,"MINE001 - my new patch"
	     	,NULL
	     };
	
	(Note changes to line numbers as well as removal of context lines.)
	This will prevent patch from choking if someone has previously
	applied different patches than you.

        History has shown that nobody distributes patches that also
        modify patchlevel.h. Do it yourself. The following perl
        program can be used to add a comment to patchlevel.h:

#!perl
die "Usage: perl -x patchlevel.h comment ..." unless @ARGV;
open PLIN, "patchlevel.h" or die "Couldn't open patchlevel.h : $!";
open PLOUT, ">patchlevel.new" or die "Couldn't write on patchlevel.new : $!";
my $seen=0;
while (<PLIN>) {
    if (/\t,NULL/ and $seen) {
       while (my $c = shift @ARGV){
            print PLOUT qq{\t,"$c"\n};
       }
    }
    $seen++ if /local_patches\[\]/;
    print PLOUT;
}
close PLOUT or die "Couldn't close filehandle writing to patchlevel.new : $!";
close PLIN or die "Couldn't close filehandle reading from patchlevel.h : $!";
unlink "patchlevel.bak" or warn "Couldn't unlink patchlevel.bak : $!"
  if -e "patchlevel.bak";
rename "patchlevel.h", "patchlevel.bak" or
  die "Couldn't rename patchlevel.h to patchlevel.bak : $!";
rename "patchlevel.new", "patchlevel.h" or
  die "Couldn't rename patchlevel.new to patchlevel.h : $!";
__END__

Please keep empty lines below so that context diffs of this file do
not ever collect the lines belonging to local_patches() into the same
hunk.

 */




#if !defined(PERL_PATCHLEVEL_H_IMPLICIT) && !defined(LOCAL_PATCH_COUNT)
static	char	*local_patches[] = {
        NULL
	,ACTIVEPERL_LOCAL_PATCHES_ENTRY
        ,"21846 Configure gets d_u32align wrong"
        ,"21739 [perl #24493] install.html not working"
        ,"21737 Ooops. left an XXX comment in, and worse still it's a // comment"
        ,"21735 utf8 keys now work for tied hashes"
        ,"21734 Accessing unicode keys in tie hashes via hv_exists was broken"
        ,"21733 ext/threads/t/problem.t"
        ,"21732 Config::myconfig() fails under ithreads"
        ,"21728 Update perlhist with 5.6.2"
        ,"21723 Include 'SCCS' in the list of dir names ignored by installperl"
        ,"21718 Empty subroutine as object method segfaults in 5.8.2 (sometimes)"
        ,"21714 Fix bug #24380: assigning list with duplicated keys to a hash"
        ,"21706 [perl #24460] [DOC PATCH] the begincheck program"
        ,"21693 must copy changes from win32/makeifle.mk to wince/makefile.ce"
        ,"21691 Update the list of pumpkings in perlhist.pod"
        ,"21687 [PATCH 5.6.2-RC1 pod/perlhist.pod]  Updated"
        ,"21677 OS/2 docu"
        ,"21676 Bug #24407: key for shared hash got stringified into wrong pool"
        ,"21673 Be sure to use -fPIC not -fpic on Linux/SPARC"
        ,"21672 extending the hash attack test"
        ,"21671 Benchmark.pm cmpthese segfault"
        ,"21662 'make minitest' fails for op/cproto and op/pat"
        ,"21586 Comment that this 'optimisation' is actually a necessary fixup"
        ,"21548 Sync with Pod::Perldoc 3.12"
        ,"21540 Fix backward-compatibility issues in if.pm"
	,NULL
};



/* Initial space prevents this variable from being inserted in config.sh  */
#  define	LOCAL_PATCH_COUNT	\
	(sizeof(local_patches)/sizeof(local_patches[0])-2)

/* the old terms of reference, add them only when explicitly included */
#define PATCHLEVEL		PERL_VERSION
#undef  SUBVERSION		/* OS/390 has a SUBVERSION in a system header */
#define SUBVERSION		PERL_SUBVERSION
#endif
