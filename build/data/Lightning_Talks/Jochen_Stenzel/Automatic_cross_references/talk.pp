
\XO<cross links>
In this demo, pages are crosslinked all over the site. This is done by explicit \X<links>,
and it works fine for all the pages provided by the CD team. But for the \I<talk pages>, this
is no working approach - especially if there are \OREF{n=Archives}<archives>. Too much manual
work, too many maintenance overhead in case of changes (which use to happen permanently),
too much effort to scan and categorize all the abstracts and bios.

But ... it \I<would> be nice to see which talks are \X<related>. Can this be done
\I<automatically>?

It can! That's what \X<PerlPoint> \X<index references> were invented for. This is the base idea:

* The list of \IX<index entries> is a very \I<condensed, short description> of what themes the
  talk is about and related to.

* Index entries (and \X<key phrase lists>) are written by the \IX<speakers> or their
  \X<custodians>, who know well what the talks are about. So they will be \I<always up to date>.

* Finding pages with \X<matching index entries> means finding articles that are probably
  related, with a really good probability.

So PerlPointCD produces \IX<index based cross references>. They are added to a page whenever
related pages were found, sorted in the order of match counts.

There are three configuration settings controlling the search. They are accessible as
\XOM<makefile | macros>\OREF{n="Configure the make call"}<makefile macros> and default
to values that produced good results.

\BU<Base search depth>

There can be subchapters in a page we are searching related pages for. The start page
has index entries, and the subchapters add probably more. Which number of subchapter levels
should be taken into account when building our index entry base?

Provide one of the keywords \CX<startpage> or \CX<full> to the \CX<makefile> macro
\CX<INDEXREL_READDEPTH>.

||co|c||  # include the start page only
  \RED<INDEXREL_READDEPTH=startpage>

  # include all subchapters
  \RED<INDEXREL_READDEPTH=full>

As it seems best to find a base of as much key phrases as possible, this setting defaults to
\C<full>.


\BU<Related page search depth>

Related pages might have subchapters as well. How many of their subchapter levels should be
taken into account when searching for matches to the start page?

Again, provide one of the keywords \CX<startpage> or \CX<full> to the \CX<makefile> macro
\CX<INDEXREL_RELDEPTH>.

||co|c||  # consider the he start page only
  \RED<INDEXREL_RELDEPTH=1>

  # scan all subchapters
  \RED<INDEXREL_RELDEPTH=full>

This setting defaults to \C<full> as well.



\BU<Threshold>

Configured by the \C<makefile> macro \CX<INDEXREL_THRESHOLD>, this setting controls which
number or percentage of the start file index entries must be found on another page to call
this other page related. Matches below this threshold are discarded.

The setting can be made absolutely or by a percentage value, with \C<20%> as the default.


||co|c||  # skip everything below a threshold of 30%
  \RED<INDEXREL_THRESHOLD=30%>

  # require three matches at least
  \RED<INDEXREL_THRESHOLD=3>
  



\TS\CENTER<\I<To get really good results, \OREF{n="Asking for materials"}<encourage your
speakers> to make (lots of ;-)) index entries!>>





