# Opl_DeOplStub
Template for a Script that Opl's and DeOpl's a file

 * puts SFM records one per line (Opl)
 * Opl makes easy regexing of fields
 * EOLs are changed to # (by default)
 *  includes processing for an ini file, debugging, and command line options

Stand-alone pipe versions of the opl.pl and de_opl.pl are in the Piped directory. If you don't want the default record marker and EOL (#), adjust the variables in the perl code. The calling method is documented on the first line.

You can change the record marker on the fly by something like:

````bash
perl -pe 's/lx/ge/' <opl.pl >geopl.pl
````
