# Opl_DeOpl-Piped

## Do not use these versions for new scripts
These versions of *opl.pl* and *de_opl.pl* are now deprecated. They should not be used in new scripts.

The calling sequence and git repo location of the new versions have changed. These have been left here so existing scripts that use them will not be break.

## Legacy README information
Here is some legacy documentation regarding the use of these scripts.

All end-of-line (EOL) sequences are changed into *#*. Pre-existing *#* are changed into a unique sequence by *opl.pl* and are restored as *#* by *de_opl.pl*.

Piped versions of the opl.pl and de_opl.pl that are called using *perl -pf* are in the Piped directory. If you don't want the default record marker and EOL (#), adjust the variables in the perl code. The calling method is documented on the first line.

You can change the record marker on the fly by something like:

````bash
perl -pe 's/lx/ge/' <opl.pl >geopl.pl
````

