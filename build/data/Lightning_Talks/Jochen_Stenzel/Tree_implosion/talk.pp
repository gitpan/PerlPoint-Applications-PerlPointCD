
PerlPointCD uses a special \X<directory structure> to configure the CD. Talk types, author names
and talk titles are set up by \X<directory names>. While this is convenient and makes \X<maintenance>
easy, the resulting directory names can become very long and might contain \XO<special
characters (in file names)>special characters.
Not all \X<file systems> support this. At least not the \X<ISO file system> which is used on CDs.

More, if the CD content shall be provided via web, the resulting URL's might be invalid.

Oops. Can we have both convenience \I<and> compatibility? We can.

PerlPointCD can work with both \I<long and short directory names>. Short names match the old
\X<8.3 DOS conventions>. These names have no meaning, the real information about authors, talks
etc. is searched in hidden files. A long name directory tree can be transformed into a short
named version by using the \CX<make> \X<target> \RED<\CX<implode>>. Likewise, \RED<\CX<explode>>
restores the long name version.

||c||  make \RED<implode>

  ...

  make \RED<explode>

Typically these targets do not need to be specified by a PerlPointCD user. The assumption is
that the CD is prepared on a modern file system with long name support and that the final version
(on CD or on a server) requires to have short names, so \CX<make> automatically explodes
a tree when producing a \X<preview version> (\I<no> target or target \CX<html>) and
automatically implodes it when producing a \XO<production version>version for production
(target \CX<cd>).




