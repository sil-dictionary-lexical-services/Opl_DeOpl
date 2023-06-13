# Opl_DeOpl
This repo has scripts to move all SFM fields in a SFM record into one line (*opl.pl*) and to undo that (*de_opl.pl*).
All end-of-line (EOL) sequences are changed into *#*. Pre-existing *#* are changed into a unique sequence by *opl.pl* and are restored as *#* by *de_opl.pl*.

 - puts SFM records into one per line (Opl)
 - Opl makes easy regexing of fields
 - EOLs are changed to # (by default)
 - pre-existing # characters are changed to '\_\_hash\_\_'
 - De_opl changes the opl'ed file back to SFM

It is much easier to manipulate SFM fields if the whole record is on one line.


## Stub
The /Stub directory contains a template for a script that Opl's and DeOpl's a file
It reads and opl's an SFM file into an array, one record per entry.

It has a section where you can include code that will be executed for each record of the SFM file.

When the array has been processed, it is de_opl'ed to restore the file as an SFM file.

The template script includes processing for an ini file, debugging, and command line options.

## Piped
The /Piped directory contains old versions of *opl.pl* and *de_opl.pl* that were called using *perl -pf*. They are now deprecated.
