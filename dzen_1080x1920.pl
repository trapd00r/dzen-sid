#!/usr/bin/perl
# vim: ft=perl:fdm=marker:fmr=#<,#>:fen:et:sw=2:
use strict;
use warnings FATAL => 'all';
use vars     qw($VERSION);
use autodie  qw(:all);

use open qw(:utf8 :std);

my $APP  = $0;
$VERSION = '0.001';

use Data::Dumper;

{
  package Data::Dumper;
  no strict 'vars';
  $Terse = $Indent = $Useqq = $Deparse = $Sortkeys = 1;
  $Quotekeys = 0;
}

use Term::ExtendedColor::Dzen qw(fgd bgd);
use Music::KNRadio::NowPlaying qw(knnp);
use Audio::MPD;
use File::Basename;


my $pipe    = fgd('#484848', '|');

my %bitmap = ();

my $filename;
for(glob('./bitmaps/*.xbm')) {
  $filename = $_;
  $_ = basename($_);
  $_ =~ s/[.]xbm$//;
  $bitmap{$_} = "^i($filename)";
}

output();


sub mail {
  return sprintf "%s %s",
    fgd('#d70000', $bitmap{mail}),
    $_ =()= glob("$ENV{MAILDIR}/new/*")
}

sub nowplaying {
  my $mpd = Audio::MPD->new;
  my %np = ();

  $np{artist} = $mpd->current->artist // 'N/A';
  $np{album}  = $mpd->current->album  // 'N/A';
  $np{title}  = $mpd->current->title  // 'N/A';
  $np{year}   = $mpd->current->date   // 'N/A';

  return sprintf "%s - %s on %s [%s]",
    fgd('0c73c2', $np{artist}),
    fgd('87af5f', $np{title}),
    fgd('d75f00', $np{album}),
    fgd('c03ebb', $np{year}),
}

sub knradio {
  my $kn = knnp();
  return sprintf "%s - %s",
    fgd('0c73c2', $kn->{artist}),
    fgd('87af5f', $kn->{title});
}



sub output {
  printf "$bitmap{media} %s $pipe %s $pipe %s\n", knradio(), mail(), nowplaying();
}
