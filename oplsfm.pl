#!/usr/bin/env perl
my $USAGE = "Usage: $0 [--recmark lx] [--eolrep #] [--reptag __hash__] [--debug] [file.sfm]\n recmark is a list of record markers to start the line\n";
use 5.022;
use utf8;
use open qw/:std :utf8/;
use English;
use Getopt::Long;
GetOptions (
# 'sampleoption:s' => \(my $sampleoption = "optiondefault"),
	'recmark:s' => \(my $recmark = "lx"), # record marker(s), default lx
	'eolrep:s' => \(my $eolrep = "#"), # character used to replace EOL
	'reptag:s' => \(my $reptag = "__hash__"), # tag to use in place of the EOL replacement character
	# e.g., an alternative is --eolrep % --reptag __percent__
	# Be aware # is the bash comment character, so quote it if you want to specify it.
	#	Better yet, just don't specify it -- it's the default.
	'debug'       => \my $debug,
	) or die $USAGE;

$recmark =~ s/[\\ ]//g; # no backslashes or spaces in record markers
$recmark =~ s/\,*$//; # no trailing commas
$recmark =~  s/\,/\|/g; # use bars for or'ing
my $srchRECmarks = qr/$recmark/;
my $crlf;
LINE: while (<<>>) {
    $crlf = $MATCH if  s/\R//g;
    print "$crlf" if /^\\($srchRECmarks) /;
    s/$eolrep/$reptag/g;
    $_ .= "$eolrep";
}
continue {
    s/${eolrep}$/${eolrep}$crlf/ if eof();
    die "Cannot write to output: $!\n" unless print $_;
}
