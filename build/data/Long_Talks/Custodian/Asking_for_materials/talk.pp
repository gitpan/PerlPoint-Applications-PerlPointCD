
Speakers in conference \X<preparation> are \IX<busy> people. There can be a lot of \X<tasks>:
writing an \X<article>, reimplementing the presented project, drawing illustrations and diagrams
and preparing the \X<slides>. Providing CD stuff needs to be easy to fit in the time frame.

So, to make it as easy as possible I just ask my authors for these:

* A short \X<bio> to introduce themselves.

* An \X<abstract>.

* An optional list of \X<keywords> (not already mentioned in the abstract).

* Optional \X<stuff> they want to provide.

Bio and abstract can be pure \X<text>,
\URL{a="http://www.sourceforge.net/projects/perlpoint"}<PerlPoint> or \X<POD>. \X<PerlPoint>
is the preferred format and really easy to start with. Here are sample abstracts:

\INDENT_ON

\I<Text:>

  This talk is about CPAN, modules and Perl
  in general. But especially *perl*.

\I<PerlPoint:>

  This talk is about \\X<CPAN>, \\X<modules> and \\X<Perl>
  in general. But especially \\I<\\C<perl>>.

\I<POD:>

  This talk is about X<CPAN>, X<modules> and X<Perl>
  in general. But especially I<C<perl>>.

\INDENT_OFF

POD is well known in the Perl community. To start with \I<PerlPoint>, just think that the POD
tags \CX<B>, \CX<C>, \CX<I> and \CX<X> are preceeded by a backslash, and that headlines begin
with \C<=> characters, one for each level - but most abstracts and bio's will not need
headlines. \FNR{n="PerlPoint feature hint"}

The \BCX<\\X> tags (or \CX<X>, for POD) are important. I ask the speakers to mark keywords
this way. Marked phrases will go into the \XO<index>\OREF{n="Index"}<index> and form the
base of \OREF{n="Automatic cross references"}<automatic cross references>.

Ah, the additional stuff. What format to use there? That's up to the speakers. They know it
will be presented on a CD with \X<HTML> GUI - so browsable contents is preferred, but archives
or plain files are welcome as well.


\HR

// footnotes
\TS\FN{n="PerlPoint feature hint"}<But in case you are curious, it let's you add tables, macros,
                                   footnotes, embedded Perl, ...>
