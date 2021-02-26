# perl -CS -pf opl.pl FileName.SFM >FileName.OPL
#or
# perl -CS -pf opl.pl <FileName.SFM >FileName.OPL
# Converts SFM file to one record per line
# SFM fields are terminated by '#'
# pre-existing '#' in the file are changed to '_hash_' 
my $recmark = "lx";
my $eolrep = "#";
my $reptag = "\_\_hash\_\_";
s/\R//g;
print "\n" if /^\\$recmark /;
# if the record marker is not necessarily at the beginning of the line (e.g. a line number before it)
#    remove the beginning of the line anchor from the search.
# print "\n" if /\\$recmark /;
s/#/$reptag/g;
$_ .= "#"
