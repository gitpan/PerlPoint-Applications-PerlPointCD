
Mostly for examples, it can be of interest that it is easy to \IX<highlight> Perl comments in a
paragraph. (Of course this applies to all languages using \CX<#> to mark comments.) Just add
\CX<||co||> to the paragraph.

||c||  \RED<||co||>  # call function
    $rc=function($arg);

This becomes

||co|c||  # call function
  $rc=function($arg);

This is called a \IX<PerlPoint paragraph filter>. Please note that the paragraph itself (after
the filter prefix) should begin as usual - the example paragraph \I<needs> to start with
whitespaces, still.

Several filters can be chained:

||c||  \I<||co\RED<|>c||> # call function
    $rc=function($arg);

    # \C<c> is \OREF{n="Center paragraphs"}<another predeclared filter>.

Paragraph filters are Perl functions. The implementation of \C<co()> is really straight forward,
so it does not work in every case, but mostly. But it can relieve an author from many keystrokes
and keeps the examples actually unchanged, so it is worth to try it out.
