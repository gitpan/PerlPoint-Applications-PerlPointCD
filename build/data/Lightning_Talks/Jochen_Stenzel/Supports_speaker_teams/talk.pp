
Whether a talk is given by exactly one \X<speaker> or several persons together, PerlPointCD can
handle it:

* The \X<author> level in the \X<directory structure> can hold multiple names, separated
  by commas and (optional) underscores (or spaces).

||c||  First_Author\RED<,_>Second_Author\RED<_,_>Third_Author

* If author \XO<defaults>\OREF{n=Defaults}<defaults> shall be stored, there should be \I<one>
  directory for \I<each> of the authors.

||c||  defaults/authors/\RED<First_Author>
  defaults/authors/\RED<Second_Author>
  defaults/authors/\RED<Third_Author>

Entries in the \X<author index> will be made for \I<each> of those authors. In general,
the tool handles each of the authors individually.


