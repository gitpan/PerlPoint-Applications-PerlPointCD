
Mostly for examples, it can be of interest that it is easy to \IX<center> a paragraph. Just add
\CX<||c||> to the paragraph.

||c|| \RED<||c||>  $rc=function($arg);

This is called a \IX<PerlPoint paragraph filter>. Please note that the paragraph itself (after
the filter prefix) should begin as usual - the example paragraph \I<needs> to start with
whitespaces, still.

Several filters can be chained:

||c||  \I<||co\RED<|>c||>  # call the function
    $rc=function($arg);

    # \C<co> is \OREF{n="Highlight examples"}<another predeclared filter>.

