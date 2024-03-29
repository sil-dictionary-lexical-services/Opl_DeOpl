#!/usr/bin/env perl
my $USAGE = "Usage: $0 [--recmark lx] [--eolrep #] [--reptag __hash__] [--debug] [file.opl]\n";
use 5.022;
use utf8;
use open qw/:std :utf8/;
use English;
use Getopt::Long;
GetOptions (
# 'sampleoption:s' => \(my $sampleoption = "optiondefault"),
	'recmark:s' => \(my $recmark = "lx"), # record marker, default lx
	'eolrep:s' => \(my $eolrep = "#"), # character used to replace EOL
	'reptag:s' => \(my $reptag = "__hash__"), # tag to use in place of the EOL replacement character
	# e.g., an alternative is --eolrep % --reptag __percent__
	# Be aware # is the bash comment character, so quote it if you want to specify it.
	#	Better yet, just don't specify it -- it's the default.
	'debug'       => \my $debug,
	) or die $USAGE;

$recmark =~ s/[\\ ]//g; # no backslashes or spaces in record marker

my $crlf = ($^O eq 'linux') ? "\n" : "\r\n"; # default according to operationg system
# Note that the above default is used only for files with no EOL characters
# Otherwise it will use the EOL characters from the opl'ed line.
LINE: while (<<>>) {
  $crlf = $MATCH if s/\R//;
  s/$eolrep/$crlf/g;
  s/$reptag/$eolrep/g;
}
continue {
    die "Cannot write to output: $!\n" unless print $_;
}
