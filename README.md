# Opl_DeOpl
This repo has scripts to move all SFM fields in a SFM record into one line (*oplsfm.pl*) and to undo that (*de_oplsfm.pl*).
All end-of-line (EOL) sequences are changed into *#*. Pre-existing *#* are changed into a unique sequence by *oplsfm.pl* and are restored as *#* by *de_oplsfm.pl*.

 - *oplsfm.pl* puts SFM records into one per line (opl)
 - Opl makes easy regexing of fields
 - EOLs are changed to # (by default)
 - pre-existing # characters are changed to '\_\_hash\_\_'
 - *de_oplsfm.pl* changes the opl'ed file back to SFM

It is much easier to manipulate SFM fields if the whole record is on one line.

*oplsfm.pl* and *de_oplsfm.pl* can be used on the bash command line or in a bash script in a pipe.

If you don't want the default record marker (\\lx) and EOL (#), use options on the command line to adjust them. The following options are available (default value of the option in parentheses):
 -  *--recmark*  : the SFM that starts a record (lx)
  - *--eolrep* : the character that will replace LF or CRLF (#)
  - *--reptag* : the string that will replace pre-existing *eolreps* (\_\_hash\_\_) 
  - *--debug* : display debugging information when the scripts are run (off)

Call them like:
````bash
    ./oplsfm.pl < sample.sfm > sample.opl
    ./de_oplsfm.pl < sample.opl > sample.sfm
````
Or to use @ instead of # as an EOL replacement:
````bash
    ./oplsfm.pl --eolrep '@' --reptag '__at__' < sample.sfm > sample.opl
    ./de_oplsfm.pl --eolrep '@' --reptag '__at__'  < sample.opl > sample.sfm
````

An example SFM file, *sample.sfm* and its opl'ed version *sample.opl* are included in this repo.

## Stub
The /Stub directory contains a template for a script that Opl's and DeOpl's a file
It reads and opl's an SFM file into an array, one record per entry.

It has a section where you can include code that will be executed for each record of the SFM file.

When the array has been processed, it is de_opl'ed to restore the file as an SFM file.

The template script includes processing for an ini file, debugging, and command line options.
