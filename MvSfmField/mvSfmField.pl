#!/usr/bin/env perl
my $USAGE = "Usage: $0 [--inifile inifile.ini] [--section section] [--recmark lx] [--debug] [file.sfm]";
=pod
This script moves all the SFM fields that start with one set of markers to after the first marker from a second set.
This can be used, for example to move fields from a subentry to its main entry.
For example if you might have subentries that can start with \lc, \ld, \ls (for compounds,  derivatives and sayings).
The information on the etymology of the word:
\bw borrowed word;
\bwl borrowed word language;
\bwf borrowed word form;
\bwn borrowed word note
The etymology may be in or after the subentries.

In this case the etymology information should come before any of the subentries. The ini file should have a section like this:
[MvSfmField]
MarkerFields=lc,ld,ls
FieldsToMove=bw,bwl,bwf,bwn
=cut

use 5.020;
use utf8;
use open qw/:std :utf8/;

use strict;
use warnings;
use English;
use Data::Dumper qw(Dumper);


use File::Basename;
my $scriptname = fileparse($0, qr/\.[^.]*/); # script name without the .pl

use Getopt::Long;
GetOptions (
	'inifile:s'   => \(my $inifilename = "$scriptname.ini"), # ini filename
	'section:s'   => \(my $inisection = "MvSfmField"), # section of ini file to use
# additional options go here.
# 'sampleoption:s' => \(my $sampleoption = "optiondefault"),
	'recmark:s' => \(my $recmark = "lx"), # record marker, default lx
	'debug'       => \my $debug,
	) or die $USAGE;

# check your options and assign their information to variables here
$recmark =~ s/[\\ ]//g; # no backslashes or spaces in record marker

# if you need  a config file uncomment the following and modify it for the initialization you need.
# if you have set the $inifilename & $inisection in the options, you only need to set the parameter variables according to the parameter names

use Config::Tiny;
my $config = Config::Tiny->read($inifilename, 'crlf');
die "Quitting: couldn't find the INI file $inifilename\n$USAGE\n" if !$config;
my $markerfields = $config->{"$inisection"}->{MarkerFields};
$markerfields =~ s/ //g; # no spaces in the marker list
$markerfields =~ s/,+/,/g; # no empty markers
$markerfields =~ s/,$//; # no empty markers (cont.)
$markerfields =~ s/,/\|/g; # alternatives  are '|' in Regexes
say STDERR "MarkerFields:$markerfields" if $debug;

my $fieldstomove = $config->{"$inisection"}->{FieldsToMove};
$fieldstomove =~ s/ //g; # no spaces in the marker list
$fieldstomove =~ s/,+/,/g; # no empty markers
$fieldstomove =~ s/,$//; # no empty markers (cont.)
$fieldstomove =~ s/,/\|/g; # alternatives  are '|' in Regexes
say STDERR "FieldsToMove:$fieldstomove" if $debug;

# generate array of the input file with one SFM record per line (opl)
my @opledfile_in;
my $line = ""; # accumulated SFM record
while (<>) {
	s/\R//g; # chomp that doesn't care about Linux & Windows
	#perhaps s/\R*$//; if we want to leave in \r characters in the middle of a line 
	s/#/\_\_hash\_\_/g;
	$_ .= "#";
	if (/^\\$recmark /) {
		$line =~ s/#$/\n/;
		push @opledfile_in, $line;
		$line = $_;
		}
	else { $line .= $_ }
	}
push @opledfile_in, $line;

for my $oplline (@opledfile_in) {
# insert code here to perform on each opl'ed line.
while ( $oplline =~ /\\($markerfields).*?#\\($fieldstomove)/) {
	say STDERR "before sub oplline:$oplline" if $debug;
	$oplline =~ s/(\\($markerfields) .*?)(\\($fieldstomove)[^#]*#)/$3$1/;
	# $1 is everything from the backslash of the marker field to the hash before the field to move
	# $2 is what matches "($markerfields)", i.e., the first nested parentheses
	# $3 is the field to move including leading backslash and trailing hash
	# $4 is is what matches "($fieldstomove)", i.e., the second nested parentheses
	say STDERR "\$1:$1" if $debug;
	say STDERR "\$2:$2" if $debug;
	say STDERR "\$3:$3" if $debug;
	say STDERR "\$4:$4" if $debug;
	}

say STDERR "oplline:", Dumper($oplline) if $debug;
#de_opl this line
	for ($oplline) {
		s/#/\n/g;
		s/\_\_hash\_\_/#/g;
		print;
		}
	}

