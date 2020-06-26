# perl -pf de_opl.pl FileNameAfteropl.SFM
# undoes opl.pl & opl-bsl
# Converts SFM file from one record per line to one field per line
# occurences of '_hash_'  are changed to back to '#'
my $eolrep = "#";
my $reptag = "\_\_hash\_\_";
s/\R//g;
s/$eolrep/\n/g;
s/$reptag/$eolrep/g;
