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
use Audio::MPD;


output();


sub mail {
  return sprintf "%s%s",
    fgd('#484848', '^i(bitmaps/envelope.xbm)'),
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



sub output {
  printf "%s | %s\n", mail(), nowplaying();
}
