
A CD \X<index> is made automatically if at least one index entry was marked anywhere. Index
entries can be marked several ways:

* \B<By the \CX<\\X> tag> (or \CX<X> in \X<POD> sources, respectively).

||c||  An \RED<\\X<index\>> entry.

* \B<Using keyword lists.> On every level of the \X<directory structure>, there can be a file
  \C<<directory type\>-index> (\C<author-index>, \C<talk-index> etc.). Each keyword or key
  phrase is written on a separate line. Empty lines are allowed. Line comments begin with
  a \CX<#>.

||co|c||  # words
  red
  blue
  green

  # a phrase
  colors of my talk

Additionally, \I<all talk headlines> and \I<all author names> are made index entries
\I<automatically>.

