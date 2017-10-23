@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl 
#line 15

require 5.006;	# require 5.6.0
use strict;

# A command-line shell implementation. The code which invokes it is at the
# bottom of this file.
package PPMShell;
use base qw(PPM::Term::Shell);

use Data::Dumper;
use Text::Autoformat qw(autoformat form);
use Getopt::Long;

# These must come _after_ the options parsing.
require PPM::UI;
require PPM::Trace;
PPM::Trace->import(qw(trace));

my $NAME	= q{PPM - Programmer's Package Manager};
my $SHORT_NAME	= q{PPM};
our $VERSION	= '3.1';

sub dictsort(@);

#=============================================================================
# Output Methods
#
# PPM behaves differently under different calling circumstances. Here are the
# various classes of messages it prints out:
# 1. error/warning	- an error or "bad thing" has occurred
# 2. informational	- required information like search results
# 3. verbose		- verbose that's only needed in interactive mode
#
# Here are the cases:
# 1. PPM is in interactive mode: everything gets printed.
# 2. PPM is in batch mode: everything minus 'verbose' gets printed.
#=============================================================================
sub error {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{error};
    CORE::print STDERR @_;
}
sub errorf {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{error};
    CORE::printf STDERR @_;
}
sub warn { goto &error }
sub warnf { goto &errorf }
sub inform {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{inform};
    CORE::print @_;
}
sub informf {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{inform};
    CORE::printf @_;
}
sub verbose {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{verbose};
    CORE::print @_;
}
sub verbosef {
    my $o = shift;
    return 1 unless $o->{SHELL}{output}{verbose};
    CORE::printf @_;
}
sub assertw {
    my $o = shift;
    my $cond = shift;
    my $msg = shift;
    $o->warn("Warning: $msg\n") unless $cond;
    return $cond;
}
sub assert {
    my $o = shift;
    my $cond = shift;
    my $msg = shift;
    $o->error("Error: $msg\n") unless $cond;
    return $cond;
}

sub mode {
    my $o = shift;
    $o->{SHELL}{mode};
}
sub setmode {
    my $o = shift;
    my $newmode = shift || '';
    my $oldmode = $o->{SHELL}{mode};
    if ($newmode eq 'SHELL') {
	$o->{SHELL}{output}{error}   = 1;
	$o->{SHELL}{output}{inform}  = 1;
	$o->{SHELL}{output}{verbose} = 1;
    }
    elsif ($newmode eq 'BATCH') {
	$o->{SHELL}{output}{error}   = 1;
	$o->{SHELL}{output}{inform}  = 1;
	$o->{SHELL}{output}{verbose} = 0;
    }
    elsif ($newmode eq 'SCRIPT') {
	$o->{SHELL}{output}{error}   = 1;
	$o->{SHELL}{output}{inform}  = 1;
	$o->{SHELL}{output}{verbose} = 0;
    }
    elsif ($newmode eq 'SILENT') {
	$o->{SHELL}{output}{error}   = 1;
	$o->{SHELL}{output}{inform}  = 0;
	$o->{SHELL}{output}{verbose} = 0;
    }
    $o->{SHELL}{mode} = $newmode;
    return $oldmode;
}

# Older versions of PPM3 had one "Active" repository. This code reads
# $o->conf('repository') if it exists, and moves it into
# $o->conf('active_reps'), which is a list. The old one is deleted -- old PPMs
# will reset it if needed, but it will be ignored if 'active_reps' exists.
sub init_active_reps {
    my $o = shift;

    if ($o->conf('repository') and not $o->conf('active_reps')) {
	my @active = $o->conf('repository');
	delete $o->{SHELL}{conf}{DATA}{repository};
	$o->conf('active_reps', \@active);
    }
    elsif (not defined $o->conf('active_reps')) {
	my @active = $o->reps_all; # enable all repositories
	$o->conf('active_reps', \@active);
    }
}

sub init {
    my $o = shift;
    $o->cache_clear('query');
    $o->cache_clear('search');
    $o->{API}{case_ignore} = 1;

    # Load the configuration;
    $o->{SHELL}{conf} = PPM::Config::load_config_file('cmdline');
    $o->init_active_reps;

    # check whether there's a target in the parent's perl that hasn't been
    # installed in the "targets" file:
    my $ppmsitelib = $ENV{PPM3_PERL_SITELIB};
    if ($ppmsitelib and opendir(PPMDIR, "$ppmsitelib/ppm-conf")) {
        my @files = map  { "$ppmsitelib/ppm-conf/$_" }
	            grep { /^ppminst/i && !/(~|\.bak)\z/ } readdir PPMDIR;
	closedir PPMDIR;
	my $found = 0;
	if (@files == 1) {
	    my @targets = PPM::UI::target_list()->result_l;
	    for my $target (@targets) {
		my $info = PPM::UI::target_raw_info($target);
		next unless $info and $info->is_success;
		++$found and last
		    if path_under($info->result->{path}, $files[0]);
	    }
	    unless ($found) {
		# We're going to add a new target:
		# 1. if we can find ppm3-bin.cfg, use that
		# 2. if not, guess lots of stuff
		my $ppm3_bin_cfg = "$ENV{PPM3_PERL_PREFIX}/bin/ppm3-bin.cfg";
		my $r = PPM::UI::target_add(undef, From => $ppm3_bin_cfg)
		    if -f $ppm3_bin_cfg;
		unless ($r and $r->is_success) {
		    PPM::UI::target_add(
			'TEMP',
			type => 'Local',
			path => $files[0],
		    );
		}
	    }
	}
    }

    # set the initial target:
    if (defined $o->{API}{args}{target}) {
	my $t = $o->{API}{args}{target};
	my $prefix = $ENV{PPM3_PERL_PREFIX};
	if ($t ne 'auto') {
	    # A full name or number given:
	    $o->run('target', 'select', $o->{API}{args}{target});
	}
	elsif ($prefix) {
	    # Auto-select target, based on where we came from:
	    my @l = $o->conf('target');
	    push @l, PPM::UI::target_list()->result_l;
	    for my $target (@l) {
		next unless $target;
		my $info = PPM::UI::target_raw_info($target);
		next unless $info and $info->is_success;
		next unless path_under($info->result->{path}, "$prefix/");
		my $mode = $o->setmode('SILENT');
		$o->run('target', 'select', $target);
		$o->setmode($mode);
		last;
	    }
	}
    }
}

sub preloop {
    my $o = shift;

    if ($o->conf('verbose-startup') and $o->mode eq 'SHELL') {
	my $profile_track = $o->conf('profile-track');
	chomp (my $startup = <<END);
$NAME version $VERSION.
Copyright (c) 2001 ActiveState SRL. All Rights Reserved.

Entering interactive shell.
END

	my $file = PPM::Config::get_license_file();
	my $license;
	if (open (my $LICENSE, $file)) {
	    $license = do { local $/; <$LICENSE> };
	}
	my $aspn = $license =~ /ASPN/;
	my $profile_tracking_warning = ($profile_track || !$aspn) ? '' : <<'END';

Profile tracking is not enabled. If you save and restore profiles manually,
your profile may be out of sync with your computer. See 'help profile' for
more information.
END
	$o->inform($startup);
	$o->inform(<<END);
 Using $o->{API}{readline} as readline library.
$profile_tracking_warning
Type 'help' to get started.

END
    }
    else {
	$o->inform("$NAME ($VERSION). Type 'help' to get started.\n");
    }

    $o->term->SetHistory(@{$o->conf('history') || []})
	if $o->term->Features->{setHistory};
}

sub postloop {
    my $o = shift;
    trace(1, "PPM: exiting...\n");
    if ($o->mode eq 'SHELL' and $o->term->Features->{getHistory}) {
	my @h = $o->term->GetHistory;
	my $max_history = $o->conf('max_history') || 100;
	splice @h, 0, (@h - $max_history)
	    if @h > $max_history;
	my $old = $o->setmode('SILENT');
	$o->conf('history', \@h);
	$o->setmode($old);
    }
}

#============================================================================
# Cache of search and query results
#============================================================================
sub cache_set_current {
    my $o = shift;
    my $type = shift;
    my $set = shift;
    $set = $o->{SHELL}{CACHE}{$type}{current} unless defined $set;
    $o->{SHELL}{CACHE}{$type}{current} = $set;
    return $o->{SHELL}{CACHE}{$type}{current};
}

sub cache_set_index {
    my $o = shift;
    my $type = shift;
    my $index = shift;
    $index = $o->{SHELL}{CACHE}{$type}{index} unless defined $index;
    $o->{SHELL}{CACHE}{$type}{index} = $index;
    return $o->{SHELL}{CACHE}{$type}{index};
}

sub cache_set_add {
    my $o = shift;
    my $type = shift;
    my $query = shift;
    my $entries = shift;
    my $sort_field = $o->conf('sort-field');
    my @sorted = $o->sort_pkgs($sort_field, @$entries);
    my $set = {
		  query => $query,
		  raw => $entries,
		  $sort_field => \@sorted,
		};
    push @{$o->{SHELL}{CACHE}{$type}{sets}}, $set;
}

sub cache_entry {
    my $o = shift;
    my $type = shift;		# 'query' or 'cache';
    my $index = shift;		# defaults to currently selected index
    my $set = shift;		# defaults to currently selected set

    $index = $o->{SHELL}{CACHE}{$type}{index} unless defined $index;

    my $src = $o->cache_set($type, $set);
    return undef unless $src and bounded(0, $index, $#$src);

    # Make sure we display only valid entries:
    my $tar = $o->conf('target');
    $src->[$index]->make_complete($tar);
    return $src->[$index];
}

sub cache_set {
    my $o = shift;
    my $type = shift;		# 'query' or 'cache'
    my $set = shift;		# defaults to currently selected set
    my $entry = shift;		# defaults to 'results';

    $entry = $o->conf('sort-field') unless defined $entry;
    return undef unless grep { lc($entry) eq $_ } (sort_fields(), 'query');

    $set = $o->{SHELL}{CACHE}{$type}{current} unless defined $set;
    my $src = $o->{SHELL}{CACHE}{$type}{sets};

    return undef unless defined $set;
    return undef unless bounded(0, $set, $#$src);

    # We've changed sort-field at some point -- make sure the sorted data
    # exists, or else build it:
    unless (defined $src->[$set]{$entry}) {
	my $raw = $src->[$set]{raw};
	my @sorted = $o->sort_pkgs($entry, @$raw);
	$src->[$set]{$entry} = \@sorted;
    }
    
    return wantarray ? @{$src->[$set]{$entry}} : $src->[$set]{$entry};
}

sub cache_clear {
    my $o = shift;
    my $type = shift;		# 'query' or 'cache'
    $o->{SHELL}{CACHE}{$type}{sets} = [];
    $o->{SHELL}{CACHE}{$type}{current} = -1;
    $o->{SHELL}{CACHE}{$type}{index} = -1;
}

sub cache_sets {
    my $o = shift;
    my $type = shift;
    @{$o->{SHELL}{CACHE}{$type}{sets}};
}

# This sub searches for an entry in the cache whose name matches that thing
# passed in. It searches in the current cache first. If the name isn't found,
# it searches in all caches. If the name still isn't found, it returns undef.
sub cache_find {
    my $o = shift;
    my $type = shift;
    my $name = shift;

    my $ncaches = $o->cache_sets($type);
    my $current = $o->cache_set_current($type);

    # First, search the current set:
    my @pkgs = map { $_ ? $_->name : '' } $o->cache_set($type);
    my $ind  = find_index($name, 0, @pkgs);
    return ($current, $ind) if $ind >= 0;

    # Now try to find in all the sets:
    for my $s (0 .. $ncaches - 1) {
	next if $s == $current;
	@pkgs = map { $_ ? $_->name : '' } $o->cache_set($type, $s);
	$ind  = find_index($name, 0, @pkgs);
	return ($s, $ind) if $ind >= 0;
    }
    return (-1, -1);
}

# A pretty separator to print between logically separate items:
my $SEP;
BEGIN {
    $SEP = '=' x 20;
}

# Useful functions:
sub max (&@) {
    my $code = shift;
    my $max;
    local $_;
    for (@_) {
	my $res = $code->($_);
	$max = $res if not defined $max or $max < $res;
    }
    $max || 0;
}

sub min (&@) {
    my $code = shift;
    my $min;
    local $_;
    for (@_) {
	my $res = $code->($_);
	$min = $res if not defined $min or $min > $res;
    }
    $min || 0;
}

sub sum (&@) {
    my $code = shift;
    my $sum = 0;
    local $_;
    for (@_) {
	my $res = $code->($_);
	$sum += $res if defined $res;
    }
    $sum || 0;
}

#============================================================================
# Repository:
# rep			# displays repositories
# rep add http://...	# adds a new repository
# rep del <\d+>		# deletes the specified repository
# rep [set] 1		# sets the specified repository active
#============================================================================
sub smry_repository { "adds, removes, or sets repositories" }
sub help_repository { <<'END' }

END
sub comp_repository {
    my $o = shift;
    my ($word, $line, $start) = @_;
    my @words = $o->line_parsed($line);
    my $words = scalar @words;
    my @reps = PPM::UI::repository_list()->result_l;
    my $reps = @reps;
    my @compls = qw(add delete describe rename set select);
    push @compls, ($reps ? (1 .. $reps) : ()); 

    if ($words == 1 or $words == 2 and $start != length($line)) {
	return $o->completions($word, \@compls);
    }
    if ($words == 2 or $words == 3 and $start != length($line)) {
	return (readline::rl_filename_list($word))
	  if $words[1] eq 'add';
	return $o->completions($word, [1 .. $reps])
	  if $o->completions($words[1], [qw(delete describe rename set select)]) == 1;
    }
    ();
}
sub reps_all {
    my $o = shift;
    my $l = PPM::UI::repository_list();
    unless ($l->is_success) {
	$o->warn($l->msg);
	return () unless $l->ok;
    }
    $l->result_l;
}
sub reps_on {
    my $o = shift;
    return @{$o->conf('active_reps')};
}
sub reps_off {
    my $o = shift;
    my @reps = $o->reps_all;
    my @reps_on = $o->reps_on;
    my @off;
    for my $r (@reps) {
	push @off, $r unless grep { $_ eq $r } @reps_on;
    }
    @off;
}
sub rep_on {
    my $o = shift;
    my $rep = shift;
    my @reps = ($o->reps_on, $rep);
    my $m = $o->setmode('SILENT');
    $o->conf('active_reps', \@reps);
    $o->setmode($m);
}
sub rep_off {
    my $o = shift;
    my $rep = shift;
    my @reps = grep { $_ ne $rep } $o->reps_on;
    my $m = $o->setmode('SILENT');
    $o->conf('active_reps', \@reps);
    $o->setmode($m);
}
sub rep_ison {
    my $o = shift;
    my $rep = shift;
    scalar grep { $_ eq $rep } $o->reps_on;
}
sub rep_isoff {
    my $o = shift;
    my $rep = shift;
    scalar grep { $_ eq $rep } $o->reps_off;
}
sub rep_exists {
    my $o = shift;
    my $rep = shift;
    scalar grep { $_ eq $rep } $o->reps_all;
}
sub rep_uniq {
    my $o = shift;
    my $rep = shift;
    unless ($o->rep_exists($rep) or $rep =~ /^\d+$/) {
	/\Q$rep\E/i and return $_ for $o->reps_all;
    }
    $rep;
}
sub rep_up {
    my $o = shift;
    my $rep = shift;
    my @reps = $o->reps_on;
    my $ind = find_index($rep, 0, @reps);
    if (bounded(1, $ind, $#reps)) {
	@reps = (
	    @reps[0 .. $ind - 2],
	    $rep,
	    $reps[$ind - 1],
	    @reps[$ind + 1 .. $#reps]
	);
    }
    my $m = $o->setmode('SILENT');
    $o->conf('active_reps', \@reps);
    $o->setmode($m);
}
sub rep_down {
    my $o = shift;
    my $rep = shift;
    my @reps = $o->reps_on;
    my $ind = find_index($rep, 0, @reps);
    if (bounded(0, $ind, $#reps - 1)) {
	@reps = (
	    @reps[0 .. $ind - 1],
	    $reps[$ind + 1],
	    $rep,
	    @reps[$ind + 2 .. $#reps]
	);
    }
    my $m = $o->setmode('SILENT');
    $o->conf('active_reps', \@reps);
    $o->setmode($m);
}
sub run_repository {
    my $o = shift;
    my @args = @_;
    my (@reps, @reps_off, @reps_on);
    my $refresh = sub {
	@reps = $o->reps_all;
	@reps_off = $o->reps_off;
	@reps_on = $o->reps_on;
    };
    &$refresh;
    trace(1, "PPM: repository @args\n");

    if (@args) {
	my $cmd = shift @args;
	#=====================================================================
	# add, delete, describe, rename commands:
	#=====================================================================
	if (matches($cmd, "add")) {
	    # Support for usernames and passwords.
	    my ($user, $pass);
	    {
		local *ARGV;
		@ARGV = @args;
		GetOptions(
		    "username=s"	=> \$user,
		    "password=s"	=> \$pass,
		);
		@args = @ARGV;
	    }
	    $o->warn(<<END) and return unless @args;
repository: invalid 'add' command arguments. See 'help repository'.
END
	    my $url  = pop @args;
	    my $name = join(' ', @args);
	    unless ($name) {	# rep add http://...
		$name = 'Autonamed';
		for (my $i=1; $i<=@reps; $i++) {
		    my $tmp = "$name $i";
		    $name = $tmp and last
		      unless (grep { $tmp eq $_ } @reps);
		}
	    }
	    my $ok = PPM::UI::repository_add($name, $url, $user, $pass);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    $o->rep_on($name);
	    $o->cache_clear('search');
	}
	elsif (matches($cmd, "del|ete")) {
	    my $arg = join(' ', @args);
	    my $gonner = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$gonner = $reps_on[$arg - 1];
	    }
	    else {
		$gonner = $o->rep_uniq($gonner);
		return unless $o->assert(
		    $o->rep_exists($gonner),
		    "no such repository '$gonner'"
		);
	    }
	    my $ok = PPM::UI::repository_del($gonner);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    $o->rep_off($gonner);
	    $o->cache_clear('search');
	}
	elsif (matches($cmd, "des|cribe")) {
	    my $arg = join(' ', @args) || 1;
	    my $rep = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$rep = $reps_on[$arg - 1];
	    }
	    else {
		$rep = $o->rep_uniq($rep);
		return unless $o->assert(
		    $o->rep_exists($rep),
		    "no such repository '$rep'"
		);
	    }
	    my $info = PPM::UI::repository_info($rep);
	    unless ($info->is_success) {
		$o->warn($info->msg);
		return unless $info->ok;
	    }
	    my $type = $o->rep_ison($rep) ? "Active" : "Inactive";
	    my $num  = (
		$o->rep_ison($rep)
		? " " . find_index($rep, 1, @reps_on)
		: ""
	    );
	    my @info = $info->result_l;
	    my @keys = qw(Name Location Type);
	    push @keys, qw(Username) if @info >= 4;
	    push @keys, qw(Password) if @info >= 5;
	    $o->inform("Describing $type Repository$num:\n");
	    $o->print_pairs(\@keys, \@info);
	    return 1;
	}
	elsif (matches($cmd, 'r|ename')) {
	    my $name = pop @args;
	    my $arg = join(' ', @args);
	    my $rep = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$rep = $reps_on[$arg - 1];
	    }
	    else {
		$rep = $o->rep_uniq($rep);
		return unless $o->assert(
		    $o->rep_exists($rep),
		    "no such repository '$rep'"
		);
	    }
	    my $ok = PPM::UI::repository_rename($rep, $name);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    $o->rep_on($name) if $o->rep_ison($rep);
	    $o->rep_off($rep);
	    $o->cache_clear('search');
	}

	#=====================================================================
	# On, off, up, and down commands:
	#=====================================================================
	elsif (matches($cmd, 'on')) {
	    my $rep = $o->rep_uniq(join(' ', @args));
	    return unless $o->assert(
		$o->rep_isoff($rep),
		"no such inactive repository '$rep'"
	    );
	    $o->rep_on($rep);
	    $o->cache_clear('search');
	}
	elsif (matches($cmd, 'of|f')) {
	    my $arg = join(' ', @args);
	    my $rep = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$rep = $reps_on[$arg - 1];
	    }
	    else {
		$rep = $o->rep_uniq($rep);
		return unless $o->assert(
		    $o->rep_exists($rep),
		    "no such repository '$rep'"
		);
	    }
	    $o->rep_off($rep);
	    $o->cache_clear('search');
	}
	elsif (matches($cmd, 'up')) {
	    my $arg = join(' ', @args);
	    my $rep = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$rep = $reps_on[$arg - 1];
	    }
	    else {
		$rep = $o->rep_uniq($rep);
		return unless $o->assert(
		    $o->rep_exists($rep),
		    "no such repository '$rep'"
		);
	    }
	    $o->rep_up($rep);
	}
	elsif (matches($cmd, 'do|wn')) {
	    my $arg = join(' ', @args);
	    my $rep = $arg;
	    if ($arg =~ /^\d+$/) {
		return unless $o->assert(
		    bounded(1, $arg, scalar @reps_on),
		    "no such active repository $arg"
		);
		$rep = $reps_on[$arg - 1];
	    }
	    else {
		$rep = $o->rep_uniq($rep);
		return unless $o->assert(
		    $o->rep_exists($rep),
		    "no such repository '$rep'"
		);
	    }
	    $o->rep_down($rep);
	}

	else {
	    $o->warn(<<END) and return;
No such repository command '$cmd'; see 'help repository'.
END
	}
    }
    &$refresh;
    unless(@reps) {
	$o->warn("No repositories. Use 'rep add' to add a repository.\n");
    }
    else {
	my $i = 0;
	my $count = @reps_on;
	my $l = length($count);
	$o->inform("Repositories:\n");
	for my $r (@reps_on) {
	    my $n = sprintf("%${l}d", $i + 1);
	    $o->inform("[$n] $r\n");
	    $i++;
	}
	for my $r ($o->dictsort(@reps_off)) {
	    my $s = ' ' x $l;
	    $o->inform("[$s] $r\n");
	}
    }
    1;
}

#============================================================================
# Search:
# search		# displays previous searches
# search <\d+>		# displays results of previous search
# search <terms>	# executes a new search on the current repository
#============================================================================
sub smry_search { "searches for packages in a repository" }
sub help_search { <<'END' }

END
sub comp_search {()}
sub run_search {
    my $o = shift;
    my @args = @_;
    my $query = $o->raw_args || join ' ', @args;
    trace(1, "PPM: search @args\n\tquery='$query'\n");
    return unless $o->assert(
	scalar $o->reps_on,
	"you must activate a repository before searching."
    );

    # No args: show cached result sets
    unless (@args) {
	my @search_results = $o->cache_sets('search');
	my $search_result_current = $o->cache_set_current('search');
	if (@search_results) {
	    $o->inform("Search Result Sets:\n");
	    my $i = 0;
	    for (@search_results) {
		$o->informf("%s%2d",
		       $search_result_current == $i ? "*" : " ",
		       $i + 1);
		$o->inform(". $_->{query}\n");
		$i++;
	    }
	}
	else {
	    $o->warn("No search result sets -- provide a search term.\n");
	    return;
	}
    }

    # Args:
    else {
	# Show specified result set
	if ($query =~ /^\d+/) {
	    my $set = int($query);
	    my $s = $o->cache_set('search', $set - 1);
	    unless ($set > 0 and defined $s) {
		$o->warn("No such search result set '$set'.\n");
		return;
	    }

	    $query = $o->cache_set('search', $set-1, 'query');
	    $o->inform("Search Results Set $set ($query):\n");
	    $o->print_formatted($s, $o->cache_set_index('search'));
	    $o->cache_set_current('search', $set-1);
	    $o->cache_set_index('search', -1);
	}
       
	# Query is the same as a previous query on the same repository: 
	# Use cached results and set them as default
	elsif(grep { $_->{query} eq $query } $o->cache_sets('search')) {
	    my @entries = $o->cache_sets('search');
	    for (my $i=0; $i<@entries; $i++) {
		if ($o->cache_set('search', $i, 'query') eq $query) {
		    $o->inform("Using cached search result set ", $i+1, ".\n");
		    $o->cache_set_current('search', $i);
		    my $set = $o->cache_set('search');
		    $o->print_formatted($set);
		}
	    }
	}

	# Perform a new search
	else {
	    my @rlist = $o->reps_on;
	    my $targ = $o->conf('target');
	    my $case = not $o->conf('case-sensitivity');

	    $o->inform("Searching in Active Repositories\n");
	    my $ok = PPM::UI::search(\@rlist, $targ, $query, $case);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    my @matches = $ok->result_l;
	    unless (@matches) {
		$o->warn("No matches for '$query'; see 'help search'.\n");
		return 1;
	    }
	    $o->cache_set_index('search', -1);
	    $o->cache_set_add('search', $query, \@matches);
	    $o->cache_set_current('search', scalar($o->cache_sets('search')) - 1);
	    my @set = $o->cache_set('search');
	    $o->print_formatted(\@set);
	}
    }
    1;
}
sub alias_search { qw(s) }

#============================================================================
# tree
# tree		# shows the dependency tree for the default/current pkg
# tree <\d+>	# shows dep tree for numbered pkg in current search set
# tree <pkg>	# shows dep tree for given package
# tree <url>	# shows dep tree for package located at <url>
# tree <glob>	# searches for matches
#============================================================================
sub smry_tree { "shows package dependency tree" }
sub help_tree { <<'END' }

END
sub comp_tree { goto &comp_describe }
sub run_tree {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: tree @args\n");

    # Check for anything that looks like a query. If it does, just
    # send it to search() instead.
    my $query = $o->raw_args || join ' ', @args;
    $query ||= '';
    if ($query and not PPM::UI::is_pkg($args[0]) and not parse_range($query)) {
	$o->inform("Wildcards detected; using 'search' instead...\n");
	return $o->run('search', @_);
    }

    # No Args: describes current index of current result set, or 1.
    unless (@args) {
	my @search_results = $o->cache_sets('search');
	my $search_result_current = $o->cache_set_current('search');
	unless (@search_results and
		bounded(0, $search_result_current, $#search_results)) {
	    $o->warn("No search results to show dependency tree for -- " . 
	      "use 'search' to find a package.\n");
	    return;
	}
	else {
	    my @res = $o->cache_set('search');
	    my $npkgs = @res;
	    $o->inform("$SEP\n");
	    if ($o->cache_entry('search')) {
		my $n = $o->cache_set_index('search') + 1;
		$o->inform("Package $n:\n");
		$o->tree_pkg($o->cache_entry('search'));
	    }
	    elsif (defined $o->cache_entry('search', 0)) {
		$o->inform("Package 1:\n");
		$o->tree_pkg($o->cache_entry('search', 0));
		$o->cache_set_index('search', 0);
	    }
	    else {
		$o->inform("Search Results are empty -- use 'search' again.\n");
	    }
	    $o->inform("$SEP\n");
	}
    }

    # Args provided
    else {

	# Describe a particular number:
	if (my @r = parse_range(@args)) {
	    my @search_results = $o->cache_sets('search');
	    my $search_result_current = $o->cache_set_current('search');
	    unless (bounded(0, $search_result_current, $#search_results)) {
		$o->inform("No search results to show dependency tree for -- " . 
		  "use 'search' to find a package.\n");
		return;
	    }
	    else {
		for my $n (@r) {
		    my $sr = $o->cache_set('search');
		    $o->inform("$SEP\n");
		    if (bounded(1, $n, scalar @$sr)) {
			$o->inform("Package $n:\n");
			$o->tree_pkg($o->cache_entry('search', $n-1));
		    }
		    else {
			$o->inform("No such package $n in result set.\n");
		    }
		    $o->cache_set_index('search', $n - 1);
		}
		$o->inform("$SEP\n");
	    }
	}

	# Describe a particular package
	else {
	    return unless $o->assert(
		scalar $o->reps_on,
		"No repositories -- use 'rep add' to add a repository.\n"
	    );
	    my $pkg =
	      PPM::UI::describe([$o->reps_on], $o->conf('target'), $args[0]);
	    unless ($pkg->is_success) {
		$o->warn($pkg->msg);
		return unless $pkg->ok;
	    }
	    if ($pkg->ok) {
		$o->inform("$SEP\n");
		$o->tree_pkg($pkg->result);
		$o->inform("$SEP\n");
	    }
	}
    }
    1;
}

#============================================================================
# Describe:
# des		# describes default or current package
# des <\d+>	# describes numbered package in the current search set
# des <pkg>	# describes the named package (bypasses cached results)
# des <url>	# describes the package located at <url>
#============================================================================
sub smry_describe { "describes packages in detail" }
sub help_describe { <<'END' }

END
sub comp_describe {
    my $o = shift;
    my ($word, $line, $start) = @_;

    # If no search results
    my $n_results = $o->cache_sets('search');
    my $n_current = $o->cache_set_current('search');
    return ()
      unless ($n_results and bounded(0, $n_current, $n_results - 1));
    my @words = $o->line_parsed($line);

    # If the previous word isn't a number or the command, stop.
    return ()
      if ($#words > 0 and
	  $words[$#words] !~ /^\d+/ and
	  $start == length($line) or 
	  $#words > 1);

    # This is the most optimistic list:
    my @results = $o->cache_set('search');
    my $npkgs = @results;
    my @compls = (1 .. $npkgs);

    # If the previous word is a number, return only other numbers:
    return $o->completions($word, \@compls)
      if $words[$#words] =~ /^\d+/;

    # Either a number or the names of the packages
    push @compls, map { $_->name } @results;
    return $o->completions($word, \@compls);
}
sub run_describe {
    my $o = shift;
    my @args = @_;
    
    # Check for options:
    my $ppd;
    {
	local @ARGV = @args;
	GetOptions(ppd => \$ppd, dump => \$ppd);
	@args = @ARGV;
    }

    trace(1, "PPM: describe @args\n");

    # Check for anything that looks like a query. If it does, just
    # send it to search() instead.
    my $query = $o->raw_args || join ' ', @args;
    if ($query and not PPM::UI::is_pkg($args[0]) and not parse_range($query)) {
	$o->inform("Wildcards detected; using 'search' instead...\n");
	return $o->run('search', @_);
    }

    my $dumper = sub {
	my $o = shift;
	my $pkg_obj = shift;
	my $ppd = $pkg_obj->getppd($o->conf('target'))->result;
	$o->page($ppd);
    };
    my $displayer = $ppd ? $dumper : \&describe_pkg;

    # No Args: describes current index of current result set, or 1.
    unless (@args) {
	my @search_results = $o->cache_sets('search');
	my $search_result_current = $o->cache_set_current('search');
	unless (@search_results and
		bounded(0, $search_result_current, $#search_results)) {
	    $o->warn("No search results to describe -- " . 
	      "use 'search' to find a package.\n");
	    return;
	}
	else {
	    my @res = $o->cache_set('search');
	    my $npkgs = @res;
	    $o->inform("$SEP\n");
	    if ($o->cache_entry('search')) {
		my $n = $o->cache_set_index('search') + 1;
		$o->inform("Package $n:\n");
		$o->$displayer($o->cache_entry('search'));
	    }
	    elsif (defined $o->cache_entry('search', 0)) {
		$o->inform("Package 1:\n");
		$o->$displayer($o->cache_entry('search', 0));
		$o->cache_set_index('search', 0);
	    }
	    else {
		$o->warn("Search Results are empty -- use 'search' again.\n");
	    }
	    $o->inform("$SEP\n");
	}
    }

    # Args provided
    else {

	# Describe a particular number:
	if (my @r = parse_range(@args)) {
	    my @search_results = $o->cache_sets('search');
	    my $search_result_current = $o->cache_set_current('search');
	    unless (bounded(0, $search_result_current, $#search_results)) {
		$o->warn("No search results to describe -- " . 
		  "use 'search' to find a package.\n");
		return;
	    }
	    else {
		for my $n (@r) {
		    my $sr = $o->cache_set('search');
		    $o->inform("$SEP\n");
		    if (bounded(1, $n, scalar @$sr)) {
			$o->inform("Package $n:\n");
			$o->$displayer($o->cache_entry('search', $n-1));
		    }
		    else {
			$o->inform("No such package $n in result set.\n");
		    }
		    $o->cache_set_index('search', $n - 1);
		}
		$o->inform("$SEP\n");
	    }
	}

	# Describe a particular package
	else {
	    return unless $o->assert(
		scalar $o->reps_on,
		"No repositories -- use 'rep add' to add a repository.\n"
	    );
	    my ($set, $index) = $o->cache_find('search', $args[0]);
	    my ($ok, $pkg);
	    if ($index >= 0) {
		$o->cache_set_current('search', $set);
		$o->cache_set_index('search', $index);
		$pkg = $o->cache_entry('search');
	    }
	    else {
		$ok = PPM::UI::describe([$o->reps_on],
					$o->conf('target'), $args[0]);
		unless ($ok->is_success) {
		    $o->inform($ok->msg);
		    return unless $ok->ok;
		}
		$pkg = $ok->result;
		$o->cache_set_add('search', $args[0], [$pkg]);
		my $last = $o->cache_sets('search') - 1;
		$o->cache_set_current('search', $last);
		$o->cache_set_index('search', 0);
	    }
	    $o->inform("$SEP\n");
	    $o->$displayer($pkg);
	    $o->inform("$SEP\n");
	}
    }
    1;
}

#============================================================================
# Install:
# i		# installs default or current package
# i <\d+>	# installs numbered package in current search set
# i <pkg>	# installs named package
# i <url>	# installs the package at <url>
#============================================================================
sub smry_install { "installs packages" }
sub help_install { <<'END' }

END
sub comp_install { goto &comp_describe }
sub run_install {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: install @args\n");

    # Get the install options
    my %opts = (
	force  => $o->conf('force-install'),
	follow => $o->conf('follow-install'),
	dryrun => 0,
    );
    {
	local @ARGV = @args;
	GetOptions('force!'  => \$opts{force},
		   'follow!' => \$opts{follow},
		   'dryrun'  => \$opts{dryrun},
		  );
	@args = @ARGV;
    }

    # No Args -- installs default package
    unless (@args) {
	my @search_results = $o->cache_sets('search');
	my $search_result_current = $o->cache_set_current('search');
	unless (@search_results and
		bounded(0, $search_result_current, $#search_results)) {
	    $o->warn("No search results to install -- " . 
	      "use 'search' to find a package.\n");
	    return;
	}
	else {
	    my @results = $o->cache_set('search');
	    my $npkgs = @results;
	    my $pkg;
	    if ($o->cache_entry('search')) {
		my $n = $o->cache_set_index('search') + 1;
		$o->inform("Package $n:\n");
		$pkg = $o->cache_entry('search');
	    }
	    else {
		$o->inform("Package 1:\n");
		$pkg = $o->cache_entry('search', 0);
	    }
	    return $o->install_pkg($pkg, \%opts);
	}
    }

    # Args provided
    else {

	# Install a particular number:
	if (my @r = parse_range(@args)) {
	    my @search_results = $o->cache_sets('search');
	    my $search_result_current = $o->cache_set_current('search');
	    unless (@search_results and
		    bounded(0, $search_result_current, $#search_results)) {
		$o->warn("No search results to install -- " . 
		  "use 'search' to find a package.\n");
		return;
	    }
	    else {
		my $ok = 0;
		for my $n (@r) {
		    my $sr = $o->cache_set('search');
		    if (bounded(1, $n, scalar @$sr)) {
			$o->inform("Package $n:\n");
			my $pkg = $sr->[$n-1];
			$ok++ if $o->install_pkg($pkg, \%opts);
		    }
		    else {
			$o->inform("No such package $n in result set.\n");
		    }
		}
		return unless $ok;
	    }
	}

	# Install a particular package
	else {
	    unless ($o->reps_all) {
		$o->warn("Can't install: no repositories defined.\n");
	    }
	    else {
		return $o->install_pkg($args[0], \%opts);
	    }
	    return;
	}
    }
    1;
}

#============================================================================
# Target:
# t		# displays a list of backend targets
# t [set] <\d+>	# sets numbered target as default backend target
# t des [<\d+>]	# describes the given (or default) target
#============================================================================
sub smry_targets { "views or sets target installer backends" }
sub help_targets { <<'END' }

END
sub comp_targets {
    my $o = shift;
    my ($word, $line, $start) = @_;
    my @words = $o->line_parsed($line);
    my $words = scalar @words;
    my @compls;
    my @targs = PPM::UI::target_list()->result_l;

    # only return 'set' and 'describe' when we're completing the second word
    if ($words == 1 or $words == 2 and $start != length($line)) {
	@compls = ('set', 'select', 'describe', 'rename', 1 .. scalar @targs);
	return $o->completions($word, \@compls);
    }

    if ($words == 2 or $words == 3 and $start != length($line)) {
	# complete 'set'
	if (matches($words[1], 's|et')) {
	    my $targ = $o->conf('target');
	    @compls = map { $_->[0] }
		      grep { $_->[1] }
		      PPM::UI::target_config_keys($targ)->result_l;
	    return $o->completions($word, \@compls);
	}
	# complete 'describe' and 'rename'
	elsif (matches($words[1], 'd|escribe')
	    or matches($words[1], 'r|ename')
	    or matches($words[1], 's|elect')) {
	    return $o->completions($word, [1 .. scalar @targs]);
	}
    }
    ();
}
sub run_targets {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: target @args\n");

    my @targets = PPM::UI::target_list()->result_l;
    my $targets = @targets;

    # No arguments: print targets
    if (@args) {
	my ($cmd, @rest) = @args;
	if ($cmd =~ /^\d+$/
	    or matches($cmd, 'se|lect')) {
	    my $num = 	$cmd =~ /^\d+$/		? $cmd		:
			$rest[0] =~ /^\d+$/	? $rest[0]	:
			do {
			    my $n = find_index($rest[0], 1, @targets);
			    if ($n < 1) {
				$o->warn("No such target '$rest[0]'.\n");
				return;
			    }
			    $n;
			};

	    # QA the number: is it too high/low?
	    unless(bounded(1, $num, $targets)) {
		$o->warn("No such target number '$num'.\n");
		return;
	    }
	    else {
		$o->conf('target', $targets[$num-1]);
		$o->cache_clear('query');
	    }
	}
	elsif (matches($cmd, 'r|ename')) {
	    my ($oldnum, $newname) = @rest;
	    $oldnum =	$oldnum =~ /^\d+$/ ? $oldnum :
			do {
			    my $n = find_index($oldnum, 1, @targets);
			    if ($n < 1) {
				$o->warn("No such target '$oldnum'.\n");
				return;
			    };
			    $n;
			};
	    unless (defined $oldnum && $oldnum =~ /^\d+$/) {
		$o->warn(<<END);
target: '$cmd' requires a numeric argument. See 'help $cmd'.
END
		return;
	    }
	    unless (bounded(1, $oldnum, $targets)) {
		$o->warn("No such target number '$oldnum'.\n");
		return;
	    }
	    unless (defined $newname and $newname) {
		$newname = '' unless defined $newname;
		$o->warn(<<END);
Target names must be non-empty: '$newname' is not a valid name.
END
		return;
	    }
	    
	    my $oldname = $targets[$oldnum - 1];
	    my $ret = PPM::UI::target_rename($oldname, $newname);
	    $o->warn($ret->msg) unless $ret->ok;
	    $o->conf('target', $newname)
	      if $o->conf('target') eq $oldname;
	    @targets = PPM::UI::target_list()->result_l;
	    $targets = scalar @targets;
	}
	elsif (matches($cmd, "s|et")) {
	    my ($key, $value) = @rest;
	    if (defined $key and $key =~ /=/ and not defined $value) {
		($key, $value) = split /=/, $key;
	    }
	    unless(defined($key) && $key) {
		$o->warn(<<END);
You must specify what option to set. See 'help target'.
END
		return;
	    }
	    unless(defined($value)) {
		$o->warn(<<END);
You must provide a value for the option. See 'help target'.
END
		return;
	    }
	    my $targ = $o->conf('target');
	    my %keys = map { @$_ }
			   PPM::UI::target_config_keys($targ)->result_l;
	    unless ($keys{$key}) {
		$o->warn("Invalid set key '$key'; these are the settable values:\n");
		$o->warn("    $_\n") for (grep { $keys{$_} } keys %keys);
		return;
	    }
	    my $ok = PPM::UI::target_config_set($targ, $key, $value);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    $o->inform("Target attribute '$key' set to '$value'\n");
	    return 1;
	}
	elsif (matches($cmd, "d|escribe")) {
	    my %opts = (exec => 1);
	    my $sel;
	    if (@rest) {
		local @ARGV = @rest;
		GetOptions(\%opts, 'exec!');
		@rest = @ARGV;
	    }
	    if (@rest) {
		$sel =	$rest[0] =~ /^\d+$/ ? $rest[0] :
			    do {
				my $n = find_index($rest[0], 1, @targets);
				if ($n < 1) {
				    $o->warn("No such target '$rest[0]'.\n");
				    return;
				};
				$n;
			    };
		unless(bounded(1, $sel, $targets)) {
		    $o->warn("No such target number '$sel'.\n");
		}
	    }
	    else {
		$sel = find_index($o->conf('target'), 1, @targets);
	    }
	    my $targ = $targets[$sel-1];
	    my (@keys, @vals);
	    my $res = $opts{exec}
		? PPM::UI::target_info($targ)
		: PPM::UI::target_raw_info($targ);
	    unless ($res->is_success) {
		$o->warn($res->msg);
		return unless $res->ok;
	    }
	    my %h = $res->result_h;
	    my @h = sort keys %h;
	    push @keys, @h;
	    push @vals, $h{$_} for @h;
	    if ($opts{exec}) {
		for (PPM::UI::target_config_info($targ)->result_l) {
		    push @keys, $_->[0];
		    push @vals, $_->[1];
		}
	    }
	    $_ = ucfirst $_ for @keys;
	    $o->inform("Describing target $sel ($targ):\n");
	    $o->print_pairs(\@keys, \@vals);
	    return 1;
	}
    }
    unless($targets) {
	$o->warn("No targets. Install a PPM target.\n");
	return;
    }
    else {
	$o->conf('target', $targets[0])
	    unless $o->conf('target');
	my $i = 0;
	$o->inform("Targets:\n");
	for (@targets) {
	    $o->informf(
		"%s%2d",
		$o->conf('target') eq $targets[$i] ? "*" : " ",
		$i + 1
	    );
	    $o->inform(". $_\n");
	    $i++;
	}
    }
    1;
}

#============================================================================
# Query:
# query		# displays list of previous queries
# query <\d+>	# displays results of previous query
# query <terms>	# performs a new query and displays results
#============================================================================
sub smry_query { "queries installed packages" }
sub help_query { <<'END' }

END
sub comp_query {()}
sub run_query {
    my $o = shift;
    my $query = $o->raw_args || join ' ', @_;
    trace(1, "PPM: query @_\n\tquery='$query'\n");
    my @targets = PPM::UI::target_list()->result_l;
    my $target = $o->conf('target');
    my $case = not $o->conf('case-sensitivity');
    $o->warn("You must install an installation target before using PPM.\n")
      and return unless @targets;

    # No args: show cached query sets
    unless ($query =~ /\S/) {
	my @query_results = $o->cache_sets('query');
	my $query_result_current = $o->cache_set_current('query');
	if (@query_results) {
	    $o->inform("Query Result Sets:\n");
	    my $i = 0;
	    for (@query_results) {
		$o->informf("%s%2d",
		       $query_result_current == $i ? "*" : " ",
		       $i + 1);
		$o->inform(". $_->{query}\n");
		$i++;
	    }
	}
	else {
	    $o->warn("No query result sets -- provide a query term.\n");
	    return;
	}
    }

    # Args:
    else {
	# Show specified result set 
	if ($query =~ /^\d+/) {
	    my $set = int($query);
	    unless (defined $o->cache_set('query', $set-1)) {
		$o->warn("No such query result set '$set'.\n");
		return;
	    }

	    $query = $o->cache_set('query', $set-1, 'query');
	    $o->inform("Query Results Set $set ($query):\n");
	    $o->print_formatted([$o->cache_set('query', $set-1)],
				$o->cache_set_index('query'));
			    
	    $o->cache_set_current('query', $set-1);
	    $o->cache_set_index('query', -1);
	}

	# Query is the same a a previous query on the same target:
	# Use cached results and set them as default
	elsif (grep { $_->{query} eq $query } $o->cache_sets('query')) {
	    for (my $i=0; $i<$o->cache_sets('query'); $i++) {
		if ($o->cache_set('query', $i, 'query') eq $query) {
		    $o->inform("Using cached query result set ", $i+1, ".\n");
		    $o->cache_set_current('query', $i);
		    my $set = $o->cache_set('query');
		    $o->print_formatted($set);
		}
	    }
	}

	# Perform a new query.
	else {
	    my $num = find_index($target, 1, @targets);
	    $o->inform("Querying target $num (");
	    if (length($target) > 30) {
		$o->inform(substr($target, 0, 30), "...");
	    }
	    else {
		$o->inform($target);
	    }
	    $o->inform(")\n");

	    my $res = PPM::UI::query($target, $query, $case);
	    unless ($res->ok) {
		$o->inform($res->msg);
		return;
	    }
	    my @matches = $res->result_l;
	    if (@matches) {
		$o->cache_set_add('query', $query, \@matches);
		$o->cache_set_current('query', scalar($o->cache_sets('query')) - 1);
		my @set = $o->cache_set('query');
		$o->print_formatted(\@set);
	    }
	    else {
		$o->warn("No matches for '$query'; see 'help query'.\n");
	    }
	}
    }
    1;
}

#============================================================================
# Properties:
# prop		# describes default installed package
# prop <\d+>	# describes numbered installed package
# prop <pkg>	# describes named installed package
# prop <url>	# describes installed package at location <url>
#============================================================================
sub smry_properties { "describes installed packages in detail" }
sub help_properties { <<'END' }

END
sub comp_properties {
    my $o = shift;
    my ($word, $line, $start) = @_;

    # If no query results
    my $n_results = scalar $o->cache_sets('query');
    my $n_current = $o->cache_set_current('query');
    unless ($n_results and bounded(0, $n_current, $n_results - 1)) {
	my $targ = $o->conf('target') or return ();
	my $r = PPM::UI::query($targ, '*');
	return () unless $r->ok;
	$o->cache_set_add('query', '*', $r->result);
	$o->cache_set_current('query', scalar($o->cache_sets('query')) - 1);
    }
    my @words = $o->line_parsed($line);

    # If the previous word isn't a number or the command, stop.
    return ()
      if ($#words > 0 and
	  $words[$#words] !~ /^\d+/ and
	  $start == length($line) or 
	  $#words > 1);

    # This is the most optimistic list:
    my @results = $o->cache_set('query');
    my $npkgs = @results;
    my @compls = (1 .. $npkgs);

    # If the previous word is a number, return only other numbers:
    return $o->completions($word, \@compls)
      if ($words[$#words] =~ /^\d+/);

    # Either a number or the names of the packages
    push @compls, map { $_->name } @results;
    return $o->completions($word, \@compls);
}
sub run_properties {
    my $o = shift;
    my @args = @_;
    my $args = $args[0];
    trace(1, "PPM: properties @args\n");

    # Check for anything that looks like a query. If it does, send it
    # to query instead.
    my $query = $o->raw_args || join ' ', @args;
    $query ||= '';
    if ($query and not PPM::UI::is_pkg($args[0]) and not parse_range($query)) {
	$o->inform("Wildcards detected; using 'query' instead.\n");
	return $o->run('query', @_);
    }
    
    # No Args: describes current index of current result set, or 1.
    my $n_results = $o->cache_sets('query');
    my $n_current = $o->cache_set_current('query');
    my $ind = $o->cache_set_index('query');
    unless (@args) {
	unless ($n_results and bounded(0, $n_current, $n_results - 1)) {
	    $o->inform("No query results to describe -- " . 
	      "use 'query' to find a package.\n");
	    return;
	}
	else {
	    my @results = $o->cache_set('query');
	    my $npkgs = @results;
	    $o->inform("$SEP\n");
	    if (bounded(0, $ind, $npkgs-1)) {
		my $n = $ind + 1;
		$o->inform("Package $n:\n");
		$o->describe_pkg($o->cache_entry('query', $ind));
	    }
	    else {
		$o->inform("Package 1:\n");
		$o->describe_pkg($results[0]);
		$o->cache_set_index('query', 0);
	    }
	    $o->inform("$SEP\n");
	}
    }

    # Args provided
    else {

	# Describe a particular number:
	if (my @r = parse_range(@args)) {
	    unless ($n_results and bounded(0, $n_current, $n_results - 1)) {
		$o->inform("No query results to describe -- " . 
		  "use 'query' to find a package.\n");
		return;
	    }
	    else {
		for my $n (@r) {
		    my @results = $o->cache_set('query');
		    my $npkgs = @results;
		    $o->inform("$SEP\n");
		    if (bounded(1, $n, $npkgs)) {
			$o->inform("Package $n:\n");
			$o->cache_set_index('query', $n-1);
			my $old = $o->cache_entry('query');
			my $prop =
			  PPM::UI::properties($o->conf('target'), $old->name);
			unless ($prop->is_success) {
			    $o->warn($prop->msg);
			    next unless $prop->ok;
			}
			my ($pkg, $idate, $loc) = $prop->result_l;
			$o->describe_pkg($pkg,
				     [qw(InstDate Location)],
				     [$idate, $loc],
				    );
		    }
		    else {
			$o->inform("No such package $n in result set.\n");
		    }
		}
		$o->inform("$SEP\n");
	    }
	}

	# Query a particular package
	else {
	    if ($o->conf('target')) {
		my $prop =
		  PPM::UI::properties($o->conf('target'), $args);
		unless ($prop->is_success) {
		    $o->warn($prop->msg);
		    return unless $prop->ok;
		}
		my ($pkg, $idate, $loc) = $prop->result_l;
		my ($s, $index) = $o->cache_find('query', $args);
		$o->inform("$SEP\n") if $pkg;
		$o->describe_pkg($pkg,
			     [qw(InstDate Location)],
			     [$idate, $loc],
			    )
		  if $pkg;
		$o->inform("$SEP\n") if $pkg;
		if ($index >= 0) {
		    $o->cache_set_current('query', $s);
		    $o->cache_set_index('query', $index);
		}
		elsif ($pkg) {
		    $o->cache_set_add('query', $args[0], [$pkg]);
		    my $last = $o->cache_sets('query') - 1;
		    $o->cache_set_current('query', $last);
		    $o->cache_set_index('query', 0);
		}
		$o->warn("Package '$args' not found; 'query' for it first.\n")
		  and return unless $pkg;
	    }
	    else {
		# XXX: Change this output.
		$o->warn(
		    "There are no targets installed.\n"
		);
		return;
	    }
	}
    }
    1;
}

#============================================================================
# Uninstall:
# uninst	# removes default installed package
# uninst <\d+>	# removes specified package
# uninst <pkg>	# removes specified package
# uninst <url>	# removes the package located at <url>
#============================================================================
sub smry_uninstall { "uninstalls packages" }
sub help_uninstall { <<'END' }

END
sub comp_uninstall { goto &comp_properties; }
sub run_uninstall {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: uninstall @args\n");

    # Get the force option:
    my ($force);
    {
	local @ARGV = @args;
	GetOptions(
		'force!' => \$force,
	);
	@args = @ARGV;
    }
    
    my $args = $args[0];

    # No Args -- removes default package
    my $n_results = $o->cache_sets('query');
    my $n_current = $o->cache_set_current('query');
    my $ind = $o->cache_set_index('query');
    unless (@args) {
	unless ($n_results and bounded(0, $n_current, $n_results - 1)) {
	    $o->warn("No query results to uninstall -- " . 
	      "use 'query' to find a package.\n");
	    return;
	}
	else {
	    my @results = $o->cache_set('query');
	    if (bounded(0, $ind, $#results)) {
		my $n = $ind + 1;
		$o->inform("Package $n:\n");
		$o->remove_pkg($o->cache_entry('query', $ind)->name, $force);
	    }
	    else {
		$o->inform("Package 1:\n");
		$o->remove_pkg($o->cache_entry('query', 0)->name, $force);
	    }
	}
    }

    # Args provided
    else {
	# Uninstall a particular number:
	if (my @r = parse_range(@args)) {
	    unless ($n_results and bounded(0, $n_current, $n_results - 1)) {
		$o->warn("No query results to uninstall -- " . 
		  "use 'query' to find a package.\n");
		return;
	    }
	    else {
		my @results = $o->cache_set('query');
		my $npkgs = @results;
		my $ok = 0;
		for my $n (@r) {
		    if (bounded(1, $n, $npkgs)) {
			$o->inform("Package $n:\n");
			$ok |=
			  $o->remove_pkg($o->cache_entry('query', $n-1)->name,
				     $force, 1);
		    }
		    else {
			$o->warn("No such package $n in result set.\n");
		    }
		}
		$o->cache_clear('query') if $ok;
	    }
	}

	# Uninstall a particular package
	else {
	    if ($o->conf('target')) {
		$o->remove_pkg($_, $force) for @args;
	    }
	    else {
		print
		  "No targets -- use 'rep add' to add a target.\n";
		return;
	    }
	}
    }
    1;
}
sub alias_uninstall { qw(remove) }

#============================================================================
# Settings:
#============================================================================
my (%lib_keys, @ui_keys);
my (@path_keys, @boolean_keys, @integer_keys);
my (%cache_clear_keys);
BEGIN {
    %lib_keys = ('download-chunksize' => 'downloadbytes',
		'tempdir' => 'tempdir',
		'rebuild-html' => 'rebuildhtml',
		'trace-file' => 'tracefile',
		'trace-level' => 'tracelvl',
		'profile-track' => 'profile_enable',
		);
    @ui_keys = qw(
	case-sensitivity
	pager
	fields
	follow-install
	force-install
	prompt-context
	prompt-slotsize
	prompt-verbose
	sort-field
	verbose-startup

	install-verbose
	upgrade-verbose
	remove-verbose
    );
    @boolean_keys = qw(case-sensitivity force-install follow-install
		       prompt-context prompt-verbose profile-track
		       verbose-startup install-verbose upgrade-verbose
		       remove-verbose rebuild-html
		      );
    @integer_keys = qw(download-chunksize prompt-slotsize trace-level);
    @path_keys = qw(tempdir pager trace-file);
    @cache_clear_keys{qw/
	case-sensitivity
    /} = ();
}
sub settings_getkeys {
    my $o = shift;
    my @keys = @ui_keys;
    push @keys, keys %lib_keys;
    @keys;
}
sub settings_getvals {
    my $o = shift;
    my @vals;
    push @vals, $o->settings_getkey($_) for $o->settings_getkeys;
    @vals;
}

sub conf {
    my $o   = shift;
    my $key = shift;
    my $val = shift;
    my $un  = shift;
    return $o->settings_setkey($key, $val, $un) if defined $val;
    return $o->settings_getkey($key);
}

sub settings_getkey {
    my $o = shift;
    my $key = shift;
    return PPM::UI::config_get($lib_keys{$key})->result if $lib_keys{$key};
    return $o->{SHELL}{conf}{DATA}{$key};
}
sub settings_setkey {
    my $o = shift;
    my ($key, $val, $un) = @_;
    if (grep { $key eq $_ } @boolean_keys) {
	$val = 0 if $un;
	unless ($val =~ /^\d+$/ && ($val == 0 || $val == 1)) {
	    $o->warn(<<END);
Setting '$key' must be boolean: '0' or '1'. See 'help settings'.
END
	    return;
	}
    }
    elsif (grep { $key eq $_ } @integer_keys) {
	$val = 0 if $un;
	unless ($val =~ /^\d+$/) {
	    $o->warn(<<END);
Setting '$key' must be numeric. See 'help settings'.
END
	    return;
	}
    }
    elsif ($key eq 'sort-field') {
	$val = 'name' if $un;
	my @fields = sort_fields();
	unless (grep { lc($val) eq $_ } @fields) {
	    $o->warn(<<END);
Error setting '$key' to '$val': should be one of:
@fields.
END
	    return;
	}
	else {
	    $val = lc($val);
	    $o->cache_set_index('search', -1); # invalidates current indices.
	    $o->cache_set_index('query', -1);
	}
    }
    elsif ($key eq 'fields') {
	$val = 'name version abstract' if $un;
	my @fields = sort_fields();
	my @vals = split ' ', $val;
	for my $v (@vals) {
	    unless (grep { lc $v eq lc $_ } @fields) {
		$o->warn(<<END);
Error adding field '$v': should be one of:
@fields.
END
		return;
	    }
	}
	$val = lc $val;
    }

    if ($un and $key eq 'tempdir') {
	$o->warn("Can't unset 'tempdir': use 'set' instead.\n");
	return;
    }

    # Check for any cache-clearing that needs to happen:
    if (exists $cache_clear_keys{$key}) {
	$o->cache_clear('search');
	$o->cache_clear('query');
    }

    if ($lib_keys{$key}) { PPM::UI::config_set($lib_keys{$key}, $val) }
    else {
	$o->{SHELL}{conf}{DATA}{$key} = $val;
	$o->{SHELL}{conf}->save;
    }
    $o->inform(<<END);
Setting '$key' set to '$val'.
END
}

sub smry_settings { "view or set PPM options" }
sub help_settings { <<'END' }

END
sub comp_settings {
    my $o = shift;
    my ($word, $line, $start) = @_;
    my @words = $o->line_parsed($line);

    # To please the users of Bash, we'll allow 'set foo=bar' to work as well,
    # since it's really easy to do:
    if (defined $words[1] and $words[1] =~ /=/ and not defined $words[2]) {
	my @kv = split '=', $words[1];
	splice(@words, 1, 1, @kv);
    }
    my $words = @words;
    my @compls;

    # return the keys when we're completing the second word
    if ($words == 1 or $words == 2 and $start != length($line)) {
	@compls = $o->settings_getkeys();
	return $o->completions($word, \@compls);
    }

    # Return no completions for 'unset'.
    return () if matches($o->{API}{cmd}{run}{name}, 'u|nset');

    # provide intelligent completion for arguments:
    if ($words ==2 or $words == 3 and $start != length($line)) {
	# Completion for boolean values:
	my @bool = $o->completions($words[1], \@boolean_keys);
	my @path = $o->completions($words[1], \@path_keys);
	if (@bool == 1) {
	    return $o->completions($word, [0, 1]);
	}
	elsif (@path == 1) {
	    @compls = readline::rl_filename_list($word);
	    return $o->completions($word, \@compls);
	}
	elsif (matches($words[1], 's|ort-field')) {
	    @compls = sort_fields();
	    return $o->completions(lc($word), \@compls);
	}
    }

    # Don't complete for anything else.
    ()
}
sub run_settings {
    my $o = shift;
    my @args = @_;
    my $key = $args[0];
    my $val = $args[1];

    # To please the users of Bash, we'll allow 'set foo=bar' to work as well,
    # since it's really easy to do:
    if (defined $key and $key =~ /=/ and not defined $val) {
	($key, $val) = split '=', $key;
    }

    trace(1, "PPM: settings @args\n");
    my $unset = matches($o->{API}{cmd}{run}{name}, 'u|nset');
    my @stuff = $o->completions($key, [$o->settings_getkeys()])
      if $key;
    my $fullkey = $stuff[0] if @stuff == 1;
    if (defined $key and defined $val) {
	# validate the key:
	unless ($fullkey) {
	    $key = '' unless defined $key;
	    $o->warn("Unknown or ambiguous setting '$key'. See 'help settings'.\n");
	    return;
	}
	$o->conf($fullkey, $val, $unset);
    }
    elsif (defined $key) {
	unless ($fullkey) {
	    $key = '' unless defined $key;
	    $o->warn("Unknown or ambiguous setting '$key'. See 'help settings'.\n");
	    return;
	}
	if ($unset) {
	    $o->conf($fullkey, '', $unset);
	}
	else {
	    my $val = $o->conf($fullkey);
	    $o->print_pairs([$fullkey], [$val]);
	}
    }
    else {
	my (@keys, @vals);
	@keys = $o->settings_getkeys();
	@vals = $o->settings_getvals();
	my %k;
	@k{@keys} = @vals;
	@keys = sort keys %k;
	@vals = map { $k{$_} } @keys;
	$o->print_pairs(\@keys, \@vals);
    }
}
sub alias_settings { qw(unset) }

sub help_help { <<'END' }

END

#============================================================================
# Version:
#============================================================================
sub smry_version { "displays the PPM version ($VERSION)" }
sub help_version { <<'END' }

END
sub comp_version {()}
sub run_version {
    my $o = shift;
    if ($o->mode eq 'SHELL') {
	$o->inform("$NAME version $VERSION\n");
    }
    else {
	$o->inform("$SHORT_NAME $VERSION\n");
    }
    1;
}

#============================================================================
# Exit:
#============================================================================
sub help_exit { <<'END' }

END
sub comp_exit {
    my $o = shift;
    return &comp_query
	if $o->{API}{cmd}{run}{name} eq 'q' and @_;
    ();
}
sub run_exit {
    my $o = shift;
    # Special case: 'q' with no arguments should mean 'quit', but 'q' with
    # arguments should mean 'query'.
    if ($o->{API}{cmd}{run}{name} eq 'q' and @_) {
	return $o->run('query', @_);
    }
    $o->stoploop;
}
sub alias_exit { qw(quit q) }

#============================================================================
# Upgrade
# upgrade	# lists upgrades available
# upgrade <\d+> # lists upgrades for specified package
# upgrade<pkg>	# lists upgrades for named package
#============================================================================
sub smry_upgrade { "shows availables upgrades for installed packages" }
sub help_upgrade { <<'END' }

END
sub comp_upgrade { goto &comp_properties; }
sub run_upgrade {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: upgrade @args\n");

    # Get options:
    my %opts = (
	install => 0,
	doprecious => 0,
	dryrun => 0,
	force => $o->conf('force-install'),
	follow => $o->conf('follow-install'),
    );
    {
	local @ARGV = @args;
	GetOptions(install => \$opts{install},
		   precious => \$opts{doprecious},
		   'force!' => \$opts{force},
		   'follow!' => \$opts{follow},
		   dryrun => \$opts{dryrun},
		  );
	@args = @ARGV;
    }

    my $rlist = [$o->reps_on];
    my $targ  = $o->conf('target');
    my @pkgs;

    # Allow 'upgrade *';
    @args = grep { $_ ne '*' } @args;

    # List upgrades for a particular package
    if (@args) {
	my $pkg = $args[0];
	my @n = parse_range($o->raw_args);
	for my $n (@n) {
	    my $ppd = $o->cache_entry('query', $n-1);
	    unless($ppd) {
		$o->warn("No such query result '$pkg' in result set.\n");
		return;
	    }
	    else {
		push @pkgs, $ppd;
	    }
	}

	# The name of the package:
	unless (@n) {
	    my $ppd = PPM::UI::properties($o->conf('target'), $pkg);
	    unless ($ppd->is_success) {
		$o->warn($ppd->msg);
		return unless $ppd->ok;
	    }
	    my $real_ppd = ($ppd->result_l)[0];
	    push @pkgs, $real_ppd;
	}
    }
    # List upgrades for all packages
    else {
	@pkgs = PPM::UI::query($targ, '*', 0)->result_l;
	@pkgs = $o->sort_pkgs($o->conf('sort-field'), @pkgs);
    }

    my $verify = PPM::UI::verify_pkgs($rlist, $targ, @pkgs);
    unless ($verify->is_success) {
	$o->error("Error verifying packages: ", $verify->msg_raw, "\n");
	return;
    }
    my %bypackage;
    for my $result ($verify->result_l) {
	next unless $result->is_success; # ignore unfound packages
	my ($uptodate, $server_pkg, $inst_pkg, $b, $p) = $result->result_l;
	my $name = $server_pkg->name;
	my $nver = $server_pkg->version;
	my $over = $inst_pkg->version;
	my $repo = $server_pkg->repository->name;
	$bypackage{$name}{$repo} = {
	    uptodate => $uptodate,
	    oldver => $over,
	    newver => $nver,
	    repo => $repo,
	    bundled => $b,
	    precious => $p,
	    pkg => $server_pkg,
	};
    }
    for my $pkg (sort keys %bypackage) {
	my $default;
	my @updates;
	my $p = $bypackage{$pkg};
	for my $rep (sort { $p->{$b}{newver} cmp $p->{$a}{newver} } keys %$p) {
	    my $tmp = $default = $p->{$rep};
	    push @updates, [@$tmp{qw(oldver newver repo)}] unless $tmp->{uptodate};
	}
	my $upgrade = $opts{install} ? 1 : 0;
        for (@updates) {
	    $o->inform("$pkg $_->[0]: new version $_->[1] available in $_->[2]\n");
	}
	unless (@updates) {
	    $o->inform("$pkg $default->{oldver}: up to date.\n");
	    $upgrade &= $opts{force};
	}
	if ($upgrade) {
	    my @k = keys %$p;
	    my $ask = (@updates > 1 or @k > 1 and !@updates);
	    if ($ask) {
		# Which one do they want to install?
		$o->inform(<<MANY);

   Note: $pkg version $default->{oldver} is available from more than one place.
   Which repository would you like to upgrade from?

MANY
		my @repos = map { $_->[2] } @updates;
		$o->print_pairs([ 1 .. @repos ], \@repos, '. ');
		$o->inform("\n");
		my $rep = $o->prompt(
		    "Repository? [$default->{repo}] ",
		    $default->{repo},
		    [ 1 .. @repos, @repos ],
		);
		$rep = $repos[$rep - 1] if $rep =~ /^\d+$/;
		$default = $p->{$rep};
	    }
	    elsif (!@updates) {
		($default) = values %$p;
	    }
	    if (not $default->{precious} or $default->{precious} && $opts{doprecious}) {
		$o->upgrade_pkg($default->{pkg}, \%opts);
	    }
	    else {
		$o->warn(<<END);
Use '-precious' to force precious packages to be upgraded.
END
	    }
	}
    }
    1;
}

#============================================================================
# Profile:
# profile		# lists the profiles available on the repository
# profile N		# switches profiles
# profile add "name"	# adds a new profile
# profile delete N	# deletes the given profile
# profile describe N	# describes the given profile
# profile save		# saves the current state to the current profile
# profile restore	# restores the current profile
# profile rename	# renames the given profile
#============================================================================
sub smry_profiles { "manage PPM profiles" }
sub help_profiles { <<'END' }

END
sub comp_profiles {
    my $o = shift;
    my ($word, $line, $start) = @_;
    my @words = $o->line_parsed($line);
    my $words = scalar @words;
    my @profs = PPM::UI::profile_list();
    my @cmds = ('add', 'delete', 'describe', 'save', 'restore', 'rename');

    if ($words == 1 or $words == 2 and $start != length($line)) {
	my @compls = (@cmds, 1 .. scalar @profs);
	return $o->completions($word, \@compls);
    }
    if ($words == 2 or $words == 3 and $start != length($line)) {
	return ()
	  if ($o->completions($words[1], [qw(add save restore)])==1);
	return $o->completions($word, [1 .. scalar @profs])
	  if ($o->completions($words[1], [qw(delete describe rename)])==1);
    }
    ();
}
sub run_profiles {
    my $o = shift;
    my @args = @_;
    trace(1, "PPM: profile @args\n");

    my $ok = PPM::UI::profile_list();
    unless ($ok->is_success) {
	$o->warn($ok->msg);
	return unless $ok->ok;
    }
    my @profiles = dictsort $ok->result_l;
    $ok = PPM::UI::profile_get();
    unless ($ok->is_success) {
	$o->warn($ok->msg);
	return unless $ok->ok;
    }
    my $profile = $ok->result;
    my $which = find_index($profile, 0, @profiles);
    if ($which < 0 and @profiles) {
	$profile = $profiles[0];
	PPM::UI::profile_set($profile);
    }

    if (@args) {
	# Switch to profile N:
	if ($args[0] =~ /^\d+$/) {
	    my $num = $args[0];
	    if (bounded(1, $num, scalar @profiles)) {
		my $profile = $profiles[$num-1];
		PPM::UI::profile_set($profile);
	    }
	    else {
		$o->warn("No such profile number '$num'.\n");
		return;
	    }
	}

	# Describe profile N:
	elsif (matches($args[0], "des|cribe")) {
	    my $num = 	$args[1] =~ /^\d+$/ ? $args[1] :
			do {
			    my $n = find_index($args[1], 1, @profiles);
			    if ($n < 1) {
				$o->warn("No such profile '$args[1]'.\n");
				return;
			    }
			    $n;
			} if defined $args[1];
	    my $prof;
	    if (defined $num and $num =~ /^\d+$/) {
		if (bounded(1, $num, scalar @profiles)) {
		    $prof = $profiles[$num - 1];
		}
		else {
		    $o->warn("No such profile number '$num'.\n");
		    return;
		}
	    }
	    elsif (defined $num) {
		$o->warn("Argument to '$args[0]' must be numeric; see 'help profile'.\n");
		return;
	    }
	    else {
		$prof = $profile;
	    }

	    my $res = PPM::UI::profile_info($prof);
	    $o->warn($res->msg) and return unless $res->ok;
	    my @res = $res->result_l;
	    {
		my ($pkg, $version, $target);
		my $picture = <<'END';
[[[[[[[[[[[[[[[[[[[	[[[[[[[[[[[	[[[[[[[[[[[[[[[[[[[[[[
END
		($pkg, $version, $target) = qw(PACKAGE VERSION TARGET);
		my $text = '';
		$text .= form($picture, $pkg, $version, $target)
		  if @res;
		for my $entity (@res) {
		    ($pkg, $version, $target) = @$entity;
		    $version = "[$version]";
		    $text .= form($picture, $pkg, $version, $target);
		}
		if (@res) {
		    $o->inform("Describing Profile '$prof':\n");
		}
		else {
		    $o->inform("Profile '$prof' is empty.\n");
		}
		$o->page($text);
	    }
	    return 1;
	}

	# Add a profile "name":
	elsif (matches($args[0], "a|dd")) {
	    my $name = $args[1];
	    if ($name) {
		# Note: do some heavy-duty error-checking; XXX
		PPM::UI::profile_add($name);
		PPM::UI::profile_save($name)
		  if $o->conf('profile-track');
		PPM::UI::profile_set($name)
		  unless $which >= 0;
		@profiles = PPM::UI::profile_list()->result_l;
	    }
	    else {
		$o->warn("Invalid use of 'add' command; see 'help profile'.\n");
		return;
	    }
	}

	# Remove profile N:
	elsif (matches($args[0], "del|ete")) {
	    my $num =	$args[1] =~ /^\d+$/ ? $args[1] :
			do {
			    my $n = find_index($args[1], 1, @profiles);
			    if ($n < 1) {
				$o->inform("No such profile '$args[1]'.\n");
				return;
			    }
			    $n;
			} if defined $args[1];
	    if (defined $num and $num =~ /^\d+$/) {
		my $dead_profile = $profiles[$num-1];
		if (bounded(1, $num, scalar @profiles)) {
		    PPM::UI::profile_del($dead_profile);
		    @profiles = dictsort PPM::UI::profile_list()->result_l;
		    if (@profiles and $dead_profile eq $profile) {
			$profile = $profiles[0];
			PPM::UI::profile_set($profile);
		    }
		    elsif (not @profiles) {
			$o->conf('profile-track', 0);
			PPM::UI::profile_set('');
		    }
		}
		else {
		    $o->warn("No such profile '$num'.\n");
		    return;
		}
	    }
	    elsif (defined $num) {
		$o->warn(<<END);
Argument to '$args[0]' must be numeric; see 'help profile'.
END
		return;
	    }
	    else {
		$o->warn(<<END);
Invalid use of '$args[0]' command; see 'help profile'.
END
		return;
}
	}

	# Save current profile:
	elsif (matches($args[0], "s|ave")) {
	    unless (@profiles) {
		$o->warn(<<END);
No profiles on the server. Use 'profile add' to add a profile.
END
		return;
	    }
	    unless ($which >= 0) {
		$o->warn(<<END);
No profile selected. Use 'profile <number>' to select a profile.
END
		return;
	    }
	    my $ok = PPM::UI::profile_save($profile);
	    if ($ok->ok) {
		$o->inform("Profile '$profile' saved.\n");
	    }
	    else {
		$o->warn($ok->msg);
		return;
	    }
	    return 1;
	}

	# Rename profile:
	elsif (matches($args[0], "ren|ame")) {
	    unless (@profiles) {
		$o->warn(<<END);
No profiles on the server. Use 'profile add' to add a profile.
END
		return;
	    }

	    # Determine the old name:
	    my $num =	$args[1] =~ /^\d+$/ ? $args[1] :
			do {
			    my $n = find_index($args[1], 1, @profiles);
			    if ($n < 1) {
				$o->warn("No such profile '$args[1]'.\n");
				return;
			    };
			    $n;
			} if defined $args[1];
	    my $oldprof;
	    if (defined $num and $num =~ /^\d+$/) {
		if (bounded(1, $num, scalar @profiles)) {
		    $oldprof = $profiles[$num - 1];
		}
		else {
		    $o->warn("No such profile number '$num'.\n");
		    return;
		}
	    }
	    elsif (defined $num) {
		$o->warn("Argument to '$args[0]' must be numeric; see 'help profile'.\n");
		return;
	    }
	    else {
		$o->warn("profile: invalid use of '$args[0]' command: see 'help profile'.\n");
		return;
	    }

	    # Validate the new name:
	    my $newprof = $args[2];
	    unless (defined $newprof and length($newprof)) {
		$newprof = '' unless defined $newprof;
		$o->warn(<<END);
Profile names must be non-empty: '$newprof' is not a valid name.
END
		return;
	    }

	    # Actually do it:
	    my $ok = PPM::UI::profile_rename($oldprof, $newprof);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    if ($profile eq $oldprof) {
		$profile = $newprof;
		PPM::UI::profile_set($profile);
	    }
	    @profiles = dictsort PPM::UI::profile_list()->result_l;
	}

	# Restore current profile:
	elsif (matches($args[0], "res|tore")) {
	    unless (@profiles) {
		$o->warn(<<END);
No profiles on this server. Use 'profile add' to add a profile.
END
		return;
	    }
	    unless ($which >= 0) {
		$o->warn(<<END);
No profile selected. Use 'profile <number>' to select a profile.
END
		return;
	    }
	    my ($clean_packages, $dry) = (0, 0);
	    my ($force, $follow) = (1, 0);
	    {
		local @ARGV = @args;
		GetOptions('clean!' => \$clean_packages,
			   'force!' => \$force,
			   'follow!' => \$follow,
			   'dryrun' => \$dry,
			  );
		@args = @ARGV;
	    }
	    my $cb_inst = $dry ? \&dr_install : \&cb_install;
	    my $cb_rm   = $dry ? \&dr_remove  : \&cb_remove ;
	    my $ok = PPM::UI::profile_restore($profile, sub {$o->$cb_inst(@_)},
					      sub {$o->$cb_rm(@_)}, $force, $follow,
					      $dry, $clean_packages);
	    if ($ok->ok) {
		$o->cache_clear('query');
		$o->inform("Profile '$profile' restored.\n");
	    }
	    else {
		$o->warn($ok->msg);
		return;
	    }
	    return 1;
	}

	# Unrecognized subcommand:
	else {
	    $o->warn("No such profile command '$args[0]'; see 'help profile'.\n");
	    return;
	}
    }
    if (@profiles) {
	@profiles = dictsort @profiles;
	my $i = 0;
	$o->inform("Profiles:\n");
	my $profile = PPM::UI::profile_get()->result;
	for (@profiles) {
	    $o->informf("%s%2d", $profile eq $profiles[$i] ? "*" : " ", $i + 1);
	    $o->inform(". $_\n");
	    $i++;
	}
    }
    elsif (defined $args[0] and matches($args[0], "del|ete")) {
	# assume that we just deleted the last profile
	$o->warn(<<END);
Profile deleted; no remaining profiles on the server.
END
    }
    else {
	$o->warn(<<END);
No profiles. Use 'profile add' to add a profile.
END
    }
    1;
}

#============================================================================
# Help-only topics:
#============================================================================
sub smry_prompt { "how to interpret the PPM prompt" }
sub help_prompt { <<'END' }

END

#sub run_quickstart  { $_[0]->run_help('quickstart') }
sub smry_quickstart { "a crash course in using PPM" }
sub help_quickstart { <<'END' }

END

sub smry_ppm_migration { "guide for those familiar with PPM" }
sub help_ppm_migration { <<'END' }

END

sub smry_unicode { "notes about unicode author names" }
sub help_unicode { <<'END' }

END

#============================================================================
# Utility Functions
#============================================================================
sub sort_fields { qw(name title author abstract version repository) }
sub sort_pkgs {
    my $o = shift;
    my $field = lc shift;
    my @pkgs = @_;
    my $targ = $o->conf('target');
    my $filt = sub { $_[0]->getppd_obj($targ)->result->$field };
    if ($field eq 'name') {
	return dictsort $filt, @pkgs;
    }
    if ($field eq 'title') {
	return dictsort $filt, @pkgs;
    }
    if ($field eq 'author') {
	return dictsort $filt, @pkgs;
    }
    if ($field eq 'abstract') {
	return dictsort $filt, @pkgs;
    }
    if ($field eq 'repository') {
	return dictsort sub { $_[0]->repository->name }, @pkgs;
    }
    if ($field eq 'version') {
	return sort {
	    my $pa = $a->getppd_obj($targ)->result;
	    my $pb = $b->getppd_obj($targ)->result;
	    $pb->uptodate($pa->version_osd) <=> $pa->uptodate($pb->version_osd)
	} @pkgs;
    }
    @pkgs;
}

sub find_index {
    my $entry = shift || '';
    my $index = shift;
    $index = 0 unless defined $index;
    for (my $i=0; $i<@_; $i++) {
	return $index + $i if $entry eq $_[$i];
    }
    return $index - 1;
}

sub bounded {
    my $lb = shift;
    my $d = shift;
    my $ub = shift;
    return ($d >= $lb and $d <= $ub);
}

sub dictsort(@) {
    my $o = shift if eval { $_[0]->isa("PPMShell") };
    my $filt = ref($_[0]) eq 'CODE' ? shift @_ : undef;
    return map { $_->[0] }
	   sort { lc $a->[1] cmp lc $b->[1] }
	   map { [ $_, $filt ? $filt->($_) : $_ ] } @_;
}

sub path_under {
    my $path = shift;
    my $cmp  = shift;
    if ($^O eq 'MSWin32') {
	$path =~ s#\\#/#g;
	$cmp  =~ s#\\#/#g;
	return $path =~ /^\Q$cmp\E/i;
    }
    else {
	return $path =~ /^\Q$cmp\E/;
    }
}

sub prompt_str {
    my $o = shift;

    # Hack: set the pager here, instead of in settings_setkey()
    $o->{API}{pager} = $o->conf('pager');

    my @search_results = $o->cache_sets('search');
    my $search_result_current = $o->cache_set_current('search');
    my $search_result_index = $o->cache_set_index('search');
    my @query_results = $o->cache_sets('query');
    my $query_result_current = $o->cache_set_current('query');
    my $query_result_index = $o->cache_set_index('query');

    # Make sure a profile is selected if they turned tracking on.
    my $profile_track = $o->conf('profile-track');
    my $profile       = PPM::UI::profile_get()->result;
    $o->setup_profile()
	if $profile_track and not $profile and $o->mode eq 'SHELL';

    my @targs = PPM::UI::target_list()->result_l;
    if (@targs and not find_index($o->conf('target'), 1, @targs)) {
	$o->conf('target', $targs[0]);
    }

    if ($o->conf('prompt-context')) {
	my ($targ, $rep, $s, $sp, $q, $qp);

	if ($o->conf('prompt-verbose')) {
	    my $sz = $o->conf('prompt-slotsize');
	    $targ = substr($o->conf('target'), 0, $sz);
	    $rep  = substr($o->conf('repository'), 0, $sz);

	    my $sq_tmp = $o->cache_set('search', undef, 'query');
	    my $ss_tmp = $o->cache_set('search');
	    my $sp_tmp = $o->cache_entry('search');
	    $s = (defined $sq_tmp)
		  ? ":" . substr($sq_tmp, 0, $sz)
		  : "";
	    $sp = ($s and defined $sp_tmp and
		   bounded(0, $search_result_index, $#$ss_tmp))
		  ? ":" . substr($sp_tmp->name, 0, $sz)
		  : "";

	    my $qq_tmp = $o->cache_set('query', undef, 'query');
	    my $qs_tmp = $o->cache_set('query');
	    my $qp_tmp = $o->cache_entry('query');
	    $q = (defined $qq_tmp)
		  ? ":" . substr($qq_tmp, 0, $sz)
		  : "";
	    $qp = ($q and defined $qp_tmp and
		   bounded(0, $query_result_index, $#$qs_tmp))
		  ? ":" . substr($qp_tmp->name, 0, $sz)
		  : "";
	}
	else {
	    # Target and Repository:
	    $targ = find_index($o->conf('target'), 1, @targs);
	    $targ = '?' if $targ == 0;
	
	    # Search number & package:
	    $s = @search_results ? ":s".($search_result_current + 1) : "";
	    my $sp_tmp = $o->cache_set('search');
	    $sp = ($s and defined $sp_tmp and 
		   bounded(0, $search_result_index, $#$sp_tmp))
		  ? ":sp".($search_result_index + 1)
		  : "";
	
	    # Query number & package:
	    $q = @query_results ? ":q".($query_result_current + 1) : "";
	    my $qp_tmp = $o->cache_set('query');
	    $qp = ($q and defined $qp_tmp and
		   bounded(0, $query_result_index, $#$qp_tmp))
		  ? ":qp".($query_result_index + 1)
		  : "";
	}
	return "ppm:$targ$s$sp$q$qp> ";
    }
    else {
	return "ppm> ";
    }
}

{
    # Weights for particular fields: these are stored in percentage of the
    # screen width, based on the number of columns they use on an 80 column
    # terminal. They also have a minimum and maximum.
    use constant MIN    => 0;
    use constant MAX    => 1;
    my %weight = (
	name     => [12, 20],
	title    => [12, 20],
	abstract => [12, 20],
	author   => [12, 20],
	repository => [12, 20],
	version  => [ 4,  9],
    );
    my %meth = (
	name     => 'name',
	title    => 'title',
	version  => 'version',
	abstract => 'abstract',
	author   => 'author',
	repository => sub {
	    my $o = shift;
	    my $rep = $o->repository or return "Installed";
	    my $name = $rep->name;
	    my $id   = $o->id || $name;
	    my $loc  = $rep->location;
	    "$name [$loc]"
	},
    );
    # These are Text::Autoformat justification marks. They're actually used to
    # build a printf() format string, since it's so much more efficient for a
    # non-line-wrapping case.
    my %just = (
	name     => '<',
	title    => '<',
	abstract => '<',
	author   => '<',
	repository => '<',
	version  => '>',
    );
    my %plus = (
	name     => '0',
	title    => '0',
	abstract => '0',
	author   => '0',
	repository => '0',
	version  => '2',
    );
    my %filt = (
	version => q{"[$_]"},
    );
    sub picture_optimized {
	my $o = shift;
	my @items = @{shift(@_)};
	unless ($o->conf('fields')) {
	    my $m = $o->setmode('SILENT');
	    $o->conf('fields', '', 1);
	    $o->setmode($m);
	}
	my @fields = split ' ', $o->conf('fields');
	$_ = lc $_ for @fields;
	my (%max_width, %width);
	my $cols = $o->termsize->{cols};
	for my $f (@fields) {
	    my $meth = $meth{$f};
	    $max_width{$f} = max { length($_->$meth) } @items;
	    $max_width{$f} += $plus{$f};
	    $width{$f} = $max_width{$f} / 80 * $cols;
	    my $max_f  = $weight{$f}[MAX] / 80 * $cols;
	    my $min_f  = $weight{$f}[MIN];
	    my $gw     = $width{$f};
	    $width{$f} = (
		$width{$f} > $max_width{$f} ? $max_width{$f} :
		$width{$f} > $max_f         ? $max_f         :
		$width{$f} < $min_f         ? $min_f         : $width{$f}
	    );
	}
	my $right = $fields[-1];
	my $index_sz = length( scalar(@items) ) + 3; # index spaces
	my $space_sz = @fields + 1; # separator spaces
	my $room = $cols - $index_sz - $space_sz;
	$width{$right} = $room - sum { $width{$_} } @fields[0 .. $#fields-1];
	while ($width{$right} > $max_width{$right}) {
	    my $smallest;
	    my $n;
	    for my $k (@fields[0 .. $#fields-1]) {
		my $max = $max_width{$k};
		my $sz  = $width{$k};
		$smallest = $k, $n = $max - $sz if $max - $sz > $n;
	    }
	    $width{$right}--;
	    $width{$smallest}++;
	}
	while ($width{$right} < $weight{$right}[MIN]) {
	    my $biggest;
	    my $n;
	    for my $k (@fields[0 .. $#fields-1]) {
		my $max = $max_width{$k};
		my $sz  = $width{$k};
		$biggest = $k, $n = $max - $sz if $max - $sz < $n;
	    }
	    $width{$right}++;
	    $width{$biggest}--;
	}
	my $picture;
	$picture = "\%${index_sz}s "; # printf picture
	$picture .= join ' ', map {
	    my $w = $width{$_};
	    my $c = $just{$_};
	    my $pad = $c eq '>' ? '' : '-';
	    "\%${pad}${w}s" # printf picture
	} @fields;
	($picture, \@fields, [@width{@fields}]);
    }

    sub print_formatted {
	my $o = shift;
	my $targ = $o->conf('target');
	my @items = map { $_->getppd_obj($targ)->result } @{shift(@_)};
	my $selected = shift;
	my $format;

	# Generate a picture and a list of fields for Text::Autoformat:
	my (@fields, %width);
	my ($picture, $f, $w) = $o->picture_optimized(\@items);
	$picture .= "\n";
	@fields = @$f;
	@width{@fields} = @$w;

	# The line-breaking sub: use '~' as hyphenation signal
	my $wrap = sub {
	    my ($str, $maxlen, $width) = @_;
	    my $field = substr($str, 0, $maxlen - 1) . '~';
	    my $left  = substr($str, $maxlen - 1);
	    ($field, $left);
	};

	my $lines = 0;
	my $i = 1;
	my @text;
	my %seen;
	for my $pkg (@items) {
	    my $star = (defined $selected and $selected == $i - 1) ? "*" : " ";
	    my $num  = "$star $i.";
	    my @vals = (
		map {
		    my $field  = $_;
		    my $method = $meth{$field};
		    local $_   = $pkg->$method;
		    my $val = defined $filt{$field} ? eval $filt{$field} : $_;
		    ($val) = $wrap->($val, $width{$field})
		        if length $val > $width{$field};
		    $val;
		}
		@fields
	    );
#	    my $key = join '', @vals;
#	    if (exists $seen{$key}) {
#		my $index = $seen{$key};
#		substr($text[$index], 0, 1) = '+';
#		next;
#	    }
#	    $seen{$key} = $i - 1;
	    (my $inc = sprintf $picture, $num, @vals) =~ s/[ ]+$//;
	    push @text, $inc;
	    $i++;
	}

	# And, page it.
	$o->page(join '', @text);
    }
}

sub tree_pkg {
    my $o = shift;
    my @rlist = $o->reps_on;
    my $tar = $o->conf('target');
    my $pkg = shift;
    my $ppd;
    if (eval { $pkg->isa('PPM::Package') }) {
	$ppd = $pkg->getppd_obj($tar);
	unless ($ppd->ok) {
	    $o->warn($ppd->msg);
	    return;
	}
	$ppd = $ppd->result;
    }
    else {
	my ($s, $i) = $o->cache_find('search', $pkg);
	if ($i >= 0) {
	    $ppd = $o->cache_entry('search', $i, $s);
	} 
	else {
	    my $ok = PPM::UI::describe(\@rlist, $tar, $pkg);
	    unless ($ok->is_success) {
		$o->warn($ok->msg);
		return unless $ok->ok;
	    }
	    $ppd = $ok->result->getppd_obj($tar);
	    unless ($ppd->ok) {
		$o->warn($ppd->msg);
		return;
	    }
	    $ppd = $ppd->result;
	}
    }

    my $pad = "\n";
    $o->inform($ppd->name, " ", $ppd->version);
    $o->Tree(\@rlist, $tar, $ppd->name, $pad, {});
    $o->inform($pad);
}

my ($VER, $HOR, $COR, $TEE, $SIZ) = ('|', '_', '\\', '|', ' ');

sub Tree {
    my $o = shift;
    my $reps = shift;
    my $tar = shift;
    my $pkg = shift;
    my $ind = shift;
    my $seen = shift;
    my $pad = $ind . "  " . $VER;

    my $ppd;
    if (exists $seen->{$pkg}) {
	$ppd = $seen->{$pkg};
    }
    else {
	my ($s, $i) = $o->cache_find('search', $pkg);
	if ($i >= 0) {
	    $ppd = $o->cache_entry('search', $i, $s);
	}
	else {
	    my $ok = PPM::UI::describe($reps, $tar, $pkg);
	    unless ($ok->is_success) {
		$o->inform(" -- package not found; skipping tree");
		return 0 unless $ok->ok;
	    }
	    $ppd = $ok->result;
	}
	$ppd->make_complete($tar);
	$ppd = $ppd->getppd_obj($tar);
	unless ($ppd->ok) {
	    $o->warn($ppd->msg);
	    return;
	}
	$ppd = $ppd->result;
	$seen->{$pkg} = $ppd;
    }

    my @impls   = $ppd->implementations;
    return 0 unless @impls;
    my @prereqs = $impls[0]->prereqs;
    return 0 unless @prereqs;
    my $nums = scalar @prereqs;

    for (1..$nums) {
	my $doneblank = 0;
	my $pre = $prereqs[$_-1];
	my $txt = $pre->name . " " . $pre->version;
	if ($_ == $nums) {
	    substr($pad, -1) = $COR;
	    $o->inform($pad, "$HOR$HOR", $txt);
	    substr($pad, -1) = ' ';
	}
	else {
	    substr($pad, -1) = $TEE;
	    $o->inform($pad, "$HOR$HOR", $txt);
	    substr($pad, -1) = $VER;
	}
	if ($o->Tree($reps, $tar, $pre->name, $pad, $seen) != 0 and
	    $doneblank == 0) {
	    $o->inform($pad); ++$doneblank;
	}
    }
    return $nums;
}

sub describe_pkg {
    my $o = shift;
    my $pkg = shift;
    my ($extra_keys, $extra_vals) = (shift || [], shift || []);
    my $n; 

    # Get the PPM::PPD object out of the PPM::Package object.
    my $pkg_des = $pkg->describe($o->conf('target'));
    unless ($pkg_des->ok) {
	$o->warn($pkg_des->msg);
	return;
    }
    $pkg_des = $pkg_des->result;

    # Basic information:
    $n = $o->print_pairs(
	[qw(Name Version Author Title Abstract), @$extra_keys],
	[(map { $pkg_des->$_ } qw(name version author title abstract)),
	 @$extra_vals],
	undef,	# separator
	undef,	# left
	undef,	# indent
	undef,	# length
	1,	# wrap (yes, please wrap)
    );

    # The repository:
    if (my $rep = $pkg_des->repository) {
	$o->print_pairs(
	    ["Location"],
	    [$rep->name],
	    undef,	# separator
	    undef,	# left
	    undef,	# indent
	    $n,		# length
	    1,		# wrap
	);
    }
    
    # Prerequisites:
    my @impls = grep { $_->architecture } $pkg_des->implementations;
    my @prereqs = @impls ? $impls[0]->prereqs : ();
    $o->inform("Prerequisites:\n") if @prereqs;
    $o->print_pairs(
	[ 1 .. @prereqs ],
	[ map { $_->name . ' ' . $_->version} @prereqs ],
	'. ',	# separator
	undef,	# left
	undef,	# indent
	$n,	# length
	0,	# wrap (no, please don't wrap)
    );
    
    # Implementations:
    $o->inform("Available Platforms:\n") if @impls;
    my @impl_strings;
    for (@impls) {
	my $arch  = $_->architecture;
	my $os    = $_->os;
	my $osver = $_->osversion;
	my $str   = $arch;
	$osver    =~ s/\Q(any version)\E//g;
	if ($os and $osver) {
	    $str .= ", $os $osver";
	}
	push @impl_strings, $str;
    }
    @impl_strings = dictsort @impl_strings;
    $o->print_pairs(
	[ 1 .. @impls ],
	[ @impl_strings ],
	'. ', undef, undef, $n
    );
}

sub remove_pkg {
    my $o = shift;
    my $package = shift;
    my $target = $o->conf('target');
    my $force = shift;
    my $quell_clear = shift;
    my $verbose = $o->conf('remove-verbose');
    my $ok = PPM::UI::remove($target, $package, $force, sub { $o->cb_remove(@_) }, $verbose);
    unless ($ok->is_success) {
	$o->warn($ok->msg);
	return 0 unless $ok->ok;
    }
    else {
	$o->warn_profile_change($ok);
    }
    $o->cache_clear('query') if ($ok->ok and not $quell_clear);
    1;
}

sub upgrade_pkg {
    push @_, 'upgrade';
    goto &install_pkg;
}
sub install_pkg {
    my $o = shift;
    my $pkg = shift;
    my $opts = shift;
    my $action = shift;
    my $quell_clear = shift;
    $action = 'install' unless defined $action;

    # Find the package:
    while (1) {
	# 1. Return if they specified a full filename or URL:
	last if PPM::UI::is_pkg($pkg);

	# 2. Check if whatever they specified returns 1 search result:
	my $search =
	  PPM::UI::search([$o->reps_on], $o->conf('target'), $pkg, 
			  $o->conf('case-sensitivity'));
	unless ($search->is_success) {
	    $o->warn($search->msg);
	    return unless $search->ok;
	}
	my @ret = $search->result_l;
	if (@ret > 1) {
	    $o->warn(<<END);
Searching for '$pkg' returned multiple results. Using 'search' instead...
END
	    $o->run_search($pkg);
	    return;
	}
	elsif (not @ret) {
	    $o->warn(<<END);
Searching for '$pkg' returned no results. Try a broader search first.
END
	    return;
	}
	$pkg = $ret[0]->name;
	last;
    }

    my $cb = (
	$opts->{dryrun}
	? $action eq 'install' ? \&dr_install : \&dr_upgrade
	: $action eq 'install' ? \&cb_install : \&cb_upgrade
    );

    # Now, do the install
    my $ok;
    my @rlist = $o->reps_on;
    my $targ = $o->conf('target');

    my $prop = PPM::UI::properties($targ, $pkg);
    if ($prop->ok) {
	my $name = ($prop->result_l)[0]->name;
	if (ref $pkg) {
	    $pkg->name($name);
	}
	else {
	    $pkg = $name;
	}
    }

    if ($action eq 'install') {
	$opts->{verbose} = $o->conf('install-verbose');
	my $pkgname = ref $pkg ? $pkg->name : $pkg;
	if ($prop->ok) {
	    $o->inform("Note: Package '$pkgname' is already installed.\n");
	    return unless $opts->{force};
	}
	$ok = PPM::UI::install(\@rlist, $targ, $pkg, $opts, sub {$o->$cb(@_)});
    }
    else {
	$opts->{verbose} = $o->conf('upgrade-verbose');
	$ok = PPM::UI::upgrade(\@rlist, $targ, $pkg, $opts, sub {$o->$cb(@_)});
    }

    unless ($ok->is_success) {
	$o->warn($ok->msg);
	return unless $ok->ok;
    }
    else {
	$o->warn_profile_change($ok);
	$o->cache_clear('query') unless $quell_clear;
    }
    1;
}

# The dry run callback; just prints out package name and version:
sub dr_install {
    my $o = shift;
    my $pkg = shift;
    my $version = shift;
    my $target_name = shift;
    $o->inform(<<END);
Dry run install '$pkg' version $version in $target_name.
END
}

sub dr_upgrade {
    my $o = shift;
    my $pkg = shift;
    my $version = shift;
    my $target_name = shift;
    $o->inform(<<END);
Dry run upgrade '$pkg' version $version in $target_name.
END
}

sub dr_remove {
    my $o = shift;
    my $pkg = shift;
    my $version = shift;
    my $target_name = shift;
    $o->inform(<<END);
Dry run remove '$pkg' version $version from $target_name.
END
}

sub cb_remove {
    my $o = shift;
    my $pkg = shift;
    my $version = shift;
    my $target_name = shift;
    my $status = shift;
    if ($status eq 'COMPLETE') {
	$o->inform(
	    "Successfully removed $pkg version $version from $target_name.\n"
	)
    }
    else {
	$o->inform(<<END);
$SEP
Remove '$pkg' version $version from $target_name.
$SEP
END
    }
}

sub cb_install {
    my $o = shift;
    unshift @_, $o, 'install';
    &cb_status;
}

sub cb_upgrade {
    my $o = shift;
    unshift @_, $o, 'upgrade';
    &cb_status;
}

sub cb_status {
    my $o = shift;
    my $ACTION = shift;
    my $pkg = shift;
    my $version = shift;
    my $target_name = shift;
    my $status = shift;
    my $bytes = shift;
    my $total = shift;
    my $secs = shift;

    my $cols = $ENV{COLUMNS} || 78;

    $o->inform(<<END) and return if ($status eq 'PRE-INSTALL');
$SEP
\u$ACTION '$pkg' version $version in $target_name.
$SEP
END

    # Print the output on one line, repeatedly:
    my ($line, $pad, $eol);
    if ($status eq 'DOWNLOAD') {
	if ($bytes < $total) {
	    $line = "Transferring data: $bytes/$total bytes.";
	    $eol = "\r";
	}
	else {
	    $line = "Downloaded $bytes bytes.";
	    $eol = "\n";
	}
    }
    elsif ($status eq 'PRE-EXPAND') {
	$line = ""; #"Extracting package. This may take a few seconds.";
	$eol = "\r";  #"\n";
    }
    elsif ($status eq 'EXPAND') {
	$line = "Extracting $bytes/$total: $secs";
	$eol = $bytes < $total ? "\r" : "\n";
    }
    elsif ($status eq 'COMPLETE') {
	my $verb = $ACTION eq 'install' ? 'installed' : 'upgraded';
	$o->inform(
	    "Successfully $verb $pkg version $version in $target_name.\n"
	);
	return;
    }
    $pad = ' ' x ($cols - length($line));
    $o->verbose($line, $pad, $eol);
}

sub warn_profile_change {
    my $o = shift;
    my $ok = shift;

    my $profile_track = $o->conf('profile-track');
    my $profile = PPM::UI::profile_get()->result;

    if ($profile_track) {
	$o->verbose(<<END);
Tracking changes to profile '$profile'.
END
    }
}

sub parse_range {
    my @numbers;
    my $arg;
    while ($arg = shift) {
      while ($arg) {
	if ($arg =~ s/^\s*,?\s*(\d+)\s*-\s*(\d+)//) {
	    push @numbers, ($1 .. $2);
	}
	elsif ($arg =~ s/^\s*,?\s*(\d+)//) {
	    push @numbers, $1;
	}
	else {
	    last;
	}
      }
    }
    @numbers;
}

sub raw_args {
    my $o = shift;
    strip($o->line_args);
}

sub strip {
    my $f = shift;
    $f =~ s/^\s*//;
    $f =~ s/\s*$//;
    $f;
}

# matches("neil", "ne|il") => 1
# matches("ne", "ne|il") => 1
# matches("n", "ne|il") => 0
sub matches {
    my $cmd = shift;
    my $pat = shift || "";

    my ($required, $extra) = split '\|', $pat;
    $extra ||= "";
    my $regex = "$required(?:";
    for (my $i=1; $i<=length($extra); $i++) {
	$regex .= '|' . substr($extra, 0, $i);
    }
    $regex .= ")";
    return $cmd =~ /^$regex$/i;
}

sub pause_exit {
    my $o = shift;
    my $exit_code = shift || 0;
    my $pause = shift || 0;
    if ($pause) {
	if ($o->have_readkey) {
	    $o->inform("Hit any key to exit...");
	}
	else {
	    $o->inform("Hit <ENTER> to exit...");
	}
	$o->readkey;
    }
    exit $exit_code;
}

#============================================================================
# Check if this is the first time we've ever used profiles. This can be
# guessed: if the 'profile' entry is not set, but the 'profile-track' flag
# is, then it's the first time profile-track has been set to '1'.
#============================================================================
sub setup_profile {
    my $o = shift;
    $o->inform(<<END);
$SEP
You have profile tracking turned on: now it's time to choose a profile name.
ActiveState's PPM 3 Server will track which packages you have installed on
your machine. This information is stored in a "profile", located on the
server.

Here are some features of profiles:
 o You can have as many profiles as you want;
 o Each profile can track an unlimited number of packages;
 o PPM defaults to "tracking" your profile (it updates your profile every time
   you add or remove a package;
 o You can disable profile tracking by modifying the 'profile-track' option;
 o You can manually select, save, and restore profiles;
 o You can view your profile from ASPN as well as inside PPM 3.
$SEP

END

    my $response = PPM::UI::profile_list();
    my @l;
    unless ($response->ok) {
	$o->warn("Failed to enable profile tracking: ".$response->msg);
	$o->warn(<<END);

You can still use PPM3, but profiles are not enabled. To try setting up
profiles again, enter 'set profile-track=1'. Or, you can set up profiles
by hand, using the 'profile add' command.

END
	$o->run('unset', 'profile-track');
	return;
    }
    else {
	@l = sort $response->result_l;
	$o->inform("It looks like you have profiles on the server already.\n")
	  if @l;
	$o->print_pairs([1 .. @l], \@l, '. ', 1, ' ');
	$o->inform("\n") if @l;
    }

    require PPM::Sysinfo;
    (my $suggest = PPM::Sysinfo::hostname()) =~ s/\..*$//;
    $suggest ||= "Default Profile";
    my $profile_name = $o->prompt(
	"What profile name would you like? [$suggest] ", $suggest, @l
    );

    my $select_existing = grep { $profile_name eq $_ } $response->result_l
      if $response->ok;
    if ($select_existing) {
	$o->inform("Selecting profile '$profile_name'...\n");
	PPM::UI::profile_set($profile_name);
	$o->inform(<<END);
You should probably run either 'profile save' or 'profile restore' to bring
the profile in sync with your computer.
END
    }
    elsif ($response->ok) {
	$o->inform("Creating profile '$profile_name'...\n");
	$o->run('profile', 'add', $profile_name);
	$o->inform("Saving profile '$profile_name'...\n");
	$o->run('profile', 'save');
	$o->inform(<<END);
Congratulations! PPM is now set up to track your profile.
END
    }
    else {
	$o->warn($response->msg);
	$o->warn(<<END);

You can still use PPM3, but profiles will not be enabled. To try setting up
profiles again, enter 'set profile-track=1'. Or, you can set up profiles
yourself using the 'profile add' command.

END
	$o->run('unset', 'profile-track');
    }
}

package main;
use Getopt::Long;
use Data::Dumper;

$ENV{PERL_READLINE_NOWARN} = "1";
$ENV{PERL_RL} = $^O eq 'MSWin32' ? "0" : "Perl";

my ($pause, $input_file, $target);

BEGIN {
    my ($shared_config_files, @fixpath, $gen_inst_key);

    Getopt::Long::Configure('pass_through');
    $target = 'auto';
    GetOptions(
	'file=s' => \$input_file,
	'shared' => \$shared_config_files,
	'target:s' => \$target,
	'fixpath=s' => \@fixpath,
	'generate-inst-key' => \$gen_inst_key,
	pause => \$pause,
    );
    Getopt::Long::Configure('no_pass_through');

    if ($shared_config_files) {
	$ENV{PPM3_shared_config} = 1;
    }

    if (@fixpath) {
	PPM::UI::target_fix_paths(@fixpath);
	exit;
    }
    if ($gen_inst_key) {
	require PPM::Config;
	PPM::Config::load_config_file('instkey');
	exit;
    }
}

# If we're being run from a file, tell Term::Shell about it:
if ($input_file) {
    my $line = 0;
    open SCRIPT, $input_file or die "$0: can't open $input_file: $!";
    my $shell = PPMShell->new(
	term => ['PPM3', \*SCRIPT, \*STDOUT],
	target => $target,
	pager => 'none',
    );
    $shell->setmode('SCRIPT');
    while (<SCRIPT>) {
	$line++;
	next if /^\s*#/ or /^\s*$/;
	my ($cmd, @args) = $shell->line_parsed($_);
	my $ret = $shell->run($cmd, @args);
	my $warn = <<END;
$0: $input_file:$line: fatal error: unknown or ambiguous command '$cmd'. 
END
	$shell->warn($warn) and $shell->pause_exit(2, $pause)
	    unless $shell->{API}{cmd}{run}{found};
	$shell->pause_exit(1, $pause) unless $ret;
    }
    close SCRIPT;
    $shell->pause_exit(0, $pause);
}

# If we've been told what to do from the command-line, do it right away:
elsif (@ARGV) {
    my $shell = PPMShell->new(target => $target, pager => 'none');
    $shell->setmode('BATCH');
    my $ret = $shell->run($ARGV[0], @ARGV[1..$#ARGV]);
    my $warn = <<END;
Unknown or ambiguous command '$ARGV[0]'; type 'help' for commands.
END
    $shell->warn($warn) and $shell->pause_exit(2, $pause)
	unless $shell->{API}{cmd}{run}{found};
    $shell->pause_exit(0, $pause) if $ret;
    $shell->pause_exit(1, $pause);
}

# Just run the command loop
if (-t STDIN and -t STDOUT) {
    my $shell = PPMShell->new(target => $target);
    $shell->setmode('SHELL');
    $shell->cmdloop;
}
else {
    die <<END;

Error:
    PPM3 cannot be run in interactive shell mode unless both STDIN and
    STDOUT are connected to a terminal or console. If you want to
    capture the output of a command, use PPM3 in batch mode like this:

       ppm3 search IO-stringy > results.txt

    Type 'perldoc ppm3' for more information.

END
}


=head1 NAME

ppm3-bin - ppm3 executable

=head1 SYNOPSIS

Do not run I<ppm3-bin> manually. It is meant to be called by the wrapper
program I<ppm3>. See L<ppm3>.

=head1 DESCRIPTION

I<ppm3> runs I<ppm3-bin> after setting up a few environment variables. You
should run I<ppm3> instead.

For information about I<ppm3> commands, see L<ppm3>.

=head1 SEE ALSO

See L<ppm3>.

=head1 AUTHOR

ActiveState Corporation (support@ActiveState.com)

=head1 COPYRIGHT

Copyright (C) 2001, 2002, ActiveState Corporation. All Rights Reserved.

=cut

__END__
:endofperl
