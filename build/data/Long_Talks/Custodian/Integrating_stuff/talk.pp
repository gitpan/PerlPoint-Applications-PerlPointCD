
Mail by a speaker! CD stuff arrived!

Now:

* The \X<bio> is stored in a file \CX<author.pp> (or \CX<author.pod>, if the speaker wrote
  \X<POD>).

* The \X<abstract> is stored in a file \CX<talk.pp> (or \CX<talk.pod>, respectively).

* A list of \X<key phrases> is stored in \CX<talk-index>, one phrase per line (empty lines
  and \C<#> comment lines possible).

* In case the additional \X<stuff> has an \X<HTML> entry, the startup page needs to be named
  \CX<index.html>.


\XO<directory structure>In my installation of PerlPointCD, I make a talk directory:

||c||  \X<build>/data/Long_Talks/\RED<CPAN_man/CPAN,_modules_and_the_world>

* The bio goes to the directory on \IX<author> level:

||c||  build/data/Long_Talks/CPAN_man/\RED<author.pp>

* Abstract and keyword list are stored on \IX<talk> level:

||c||  build/data/Long_Talks/CPAN_man/CPAN,_modules_and_the_world/\RED<talk.pp>
  build/data/Long_Talks/CPAN_man/CPAN,_modules_and_the_world/\RED<talk-index>

* Finally, if there is additional stuff, a \CX<data> subdirectory is made to store it in,
  and then the stuff goes there unmodified.

||c||  build/data/Long_Talks/CPAN_man/CPAN,_modules_and_the_world/\RED<data/*>

Running \CX<make> in the PerlPointCD \OREF{n="02: Directory structure"}<working directory>
(above \C<build>) generates CD slides presenting this talk. Ready!




