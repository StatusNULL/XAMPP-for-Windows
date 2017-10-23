
# This is CPAN.pm's systemwide configuration file. This file provides
# defaults for users, and the values can be changed in a per-user
# configuration file. The user-config file is being looked for as
# ~/.cpan/CPAN/MyConfig.pm.

$CPAN::Config = {
  'build_cache' => q[10],
  'build_dir' => q[C:\wampp2\perl\.cpan\build],
  'cache_metadata' => q[1],
  'cpan_home' => q[c:\wampp2\perl\.cpan],
  'dontload_hash' => {  },
  'ftp' => q[D:\WINNT\SYSTEM32\ftp.EXE],
  'ftp_proxy' => q[],
  'getcwd' => q[cwd],
  'gpg' => q[G:\Programme\MiVisSt\VC98\bin\gpg.EXE],
  'gzip' => q[G:\Programme\MiVisSt\VC98\bin\gzip.EXE],
  'histfile' => q[C:\wampp2\perl\.cpan\histfile],
  'histsize' => q[100],
  'http_proxy' => q[],
  'inactivity_timeout' => q[0],
  'index_expire' => q[1],
  'inhibit_startup_message' => q[0],
  'keep_source_where' => q[C:\wampp2\perl\.cpan\sources],
  'lynx' => q[G:\Programme\MiVisSt\VC98\bin\lynx.EXE],
  'make' => q[G:\Programme\MiVisSt\VC98\bin\nmake.EXE],
  'make_arg' => q[],
  'make_install_arg' => q[],
  'makepl_arg' => q[],
  'ncftpget' => q[G:\Programme\MiVisSt\VC98\bin\ncftpget.EXE],
  'no_proxy' => q[],
  'pager' => q[D:\WINNT\SYSTEM32\more.COM],
  'prerequisites_policy' => q[follow],
  'scan_cache' => q[atstart],
  'shell' => q[D:\WINNT\system32\cmd.exe],
  'tar' => q[G:\Programme\MiVisSt\VC98\bin\tar.EXE],
  'term_is_latin' => q[1],
  'unzip' => q[G:\Programme\MiVisSt\VC98\bin\unzip.EXE],
  'urllist' => [q[ftp://cpan.noris.de/pub/CPAN/], q[ftp://ftp-stud.fht-esslingen.de/pub/Mirrors/CPAN], q[ftp://ftp.freenet.de/pub/ftp.cpan.org/pub/CPAN/], q[ftp://ftp.gmd.de/mirrors/CPAN/]],
  'wget' => q[G:\Programme\MiVisSt\VC98\bin\wget.EXE],
};
1;
__END__
