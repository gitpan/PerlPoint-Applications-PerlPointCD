
Do you remember the \IX<directory structure>? There's an \X<author level>, which typically
holds a \X<speaker> \X<bio> in an \CX<author.pp> file.

But the author level is below the talk \IX<type level>. Which means that if a speaker gives
talks of various types, his \C<author.pp> file needs to be present in several author level
directories.

||c||  \RED<Tutorials>/Speaker/talk.pp
  \RED<Invited_Talks>/Speaker/talk.pp
  \RED<Long_Talks>/Speaker/talk.pp
  \RED<Short_Talks>/Speaker/talk.pp
  \RED<Lightning_Talks>/Speaker/talk.pp
  \RED<BOFs>/Speaker/talk.pp

OK, that's a very busy speaker in this example. But we know about people like this ;-) Ah, and
even more if \OREF{n=Archives}<archives> are taken into account: each of these directories might
belong to another conference year.

||c||  \RED<2003>/Tutorials/Speaker/talk.pp
  \RED<2002>/Invited_Talks/Speaker/talk.pp
  \RED<2001>/Long_Talks/Speaker/talk.pp
  \RED<2000>/Short_Talks/Speaker/talk.pp
  \RED<1999>/Lightning_Talks/Speaker/talk.pp
  \RED<1998>/BOFs/Speaker/talk.pp

Which leads us to another issue: the speaker might like to see an updated bio about his
100 talks in the archives. So do you have to search all the relevant author directories
and to copy the latest version of the bio files to there? Of course, not. ;-) Instead of this,
use a \I<default file>.

A default file is searched in the defaults directory tree. The tree root can be specified in
the \CX<makefile> (or in the \CX<make> call, respectively) by the \X<macro> \CX<DEFAULTS>. By
default, this is \C<\X<prepare>/defaults>.

||c||  make \RED<DEFAULTS=prepare/new_defaults>

This directory can hold subdirs named like the various directory types - of course \C<author>,
but also \CX<type> and \CX<talk>. \FNR{n="default dirtypes usage"} According to the directory
structure for the talks, subdirectories below this type directory show which defaults are set
up: under \C<authors>, author name directories corresponding to the CD directories are
expected.

||c||  author
    |
    |-- Speaker_1
    |     |
    |     |-- author.pp
    |
    |-- Speaker_2
    |     |
    |     |-- author.pod \FNR{n="default files POD hint"}
    |
    |-- Speaker_3
    |     |
    |     |-- author.pp
    |
    ...

So for the more algorithmic readers, if PerlPointCD cannot find an \C<author.pp> file directly,
it looks up the defaults tree using the author directory name to search.

Which means that a default is only a fallback - if you want to have a special version of a bio,
just store it in the author directory, and an existing default will be ignored.


\HR

// footnotes
\TS\FN{n="default dirtypes usage"}<I suppose that \C<author> will be used mostly ...>

\TS\FN{n="default files POD hint"}<Of course, \XO<POD>\OREF{n="POD support"}<this works>.>








