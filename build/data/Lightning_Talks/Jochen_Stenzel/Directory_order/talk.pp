
\XOM<directory sort order|directory structure>
How are chapters sorted on a directory level? Basically, by name, which means alphabetically.
But for several levels there are special rules:

* The \BX<talk type level>: the order of talk types can be configured by a file
  specified by the \CX<makefile> \X<macro> \CX<TALKSTYLEORDER>.

||c||  make TALKSTYLEORDER=\RED<prepare/talkStyleOrder.cfg>

* The configuration lists one type directory name per line, empty and \CX<#>-comment lines
  are allowed.

* Here is the order that we found useful for \GPW CDs:

>

* \X<Tutorials>

* \X<Invited Talks>

* \X<Long Talks>

* \X<Short Talks>

* \X<Lightning Talks>

* \X<Workshops>

* \X<Demonstrations>

* \X<Work in Progress>

* \X<Poster Sessions>

* \X<BOFs>

* \X<Proceedings>

* \X<Awards>

* \X<Images>

* \X<Sponsors>

<

* The \BX<author directory level>: sorted by \I<last> names.

