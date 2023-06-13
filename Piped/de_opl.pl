# perl -CSD -pf de_opl.pl FileName.OPL >FileName.SFM
#or
# perl -CSD -pf de_opl.pl <FileName.OPL >FileName.SFM
# undoes opl.pl & opl-bsl
# Converts SFM file from one record per line to one field per line
# occurences of '_hash_'  are changed to back to '#'

BEGIN {print STDERR "Warning:This version of de_opl.pl is deprecated.\n"}

my $eolrep = "#";
my $reptag = "\_\_hash\_\_";
s/\R//g;
s/$eolrep/\n/g;
s/$reptag/$eolrep/g;
