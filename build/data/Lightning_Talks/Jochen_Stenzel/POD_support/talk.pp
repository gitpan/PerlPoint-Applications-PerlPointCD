
All sources can be written in either \X<PerlPoint> or \X<POD>. While PerlPoint is the prefered
and more powerful format, POD makes writing easy for authors familiar with Perl.

POD sources \I<can>, but do not need to, contain POD directives like \CX<=pod> to mark
where POD begins. If there is at least one such directive, PerlPointCD will treat the result
the same way \CPAN_MODULE<Pod::Simple> would do. (This means that text outside a
\C<=<pod directive\>> / \CX<=cut> sequence will be ignored.) If there is \I<no> such directive
(this means if \C<Pod::Simple> would not detect any POD in the text), PerlPointCD arranges
the text a way to be treated as POD \I<completely>.

