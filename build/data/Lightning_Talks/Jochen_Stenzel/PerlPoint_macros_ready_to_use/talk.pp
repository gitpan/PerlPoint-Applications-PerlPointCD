
PerlPointCD is a \X<PerlPoint> application, which means that it generates PerlPoint on the fly
and finally transformes it into HTML. For reasons of convenience, the generated PerlPoint
defines and uses various \XO<PerlPoint macros>PerlPoint \I<macros>.

Speaker bios, talk abstracts and other CD sources are preferably written in \X<PerlPoint> as
well. Due to the fact that they are made parts of the generated PerlPoint they can access the
"internal" macros as well. These macros are available:

||c||@##
macro               ## description ## example
\BCX<\\BU>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: format bold and underline ## \C<\\BU<text\>>
\BCX<\\BX>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: format bold and index ## \C<\\BX<text\>>
\BCX<\\BC>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: format bold and as code ## \C<\\BC<text\>>
\BCX<\\CX>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: format as code and index ## \C<\\CX<text\>>
\BCX<\\BCX>         ## \C<\\B<\\U<>...\C<\>\>> shortcut: format bold and as code and index ## \C<\\BCX<text\>>
\BCX<\\IB>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: italize and format bold ## \C<\\IB<text\>>
\BCX<\\IX>          ## \C<\\B<\\U<>...\C<\>\>> shortcut: italize and index ## \C<\\IX<text\>>
\BCX<\\IBX>         ## \C<\\B<\\U<>...\C<\>\>> shortcut: format bold italic and index ## \C<\\IBX<text\>>
\BCX<\\URL>         ## makes the body a link to the target specified by option \C<a> ## \C<\\URL{a="htp://search.cpan.org"}<CPAN search\>>
\BCX<\\URLT>        ## makes the body a link to the target specified by the body text, adds a \C<http://> prefix unless the address already specifies a link type ## \C<\\URLT<www.perlworkshop.de\>>
\BCX<\\MAILTO>      ## makes the body a mail link to the address specified by the body ## \C<\\MAILTO<perl@jochen-stenzel.de\>>
\BCX<\\MAIL>        ## makes the body a mail link to the address specified by option \C<addr> ## \C<\\MAIL{addr="perl@jochen-stenzel.de"}<PPCD author\>>
\BCX<\\XO>          ## "index only": body is made an index entry and \I<hidden> ## \C<\\XO<entry\>>
\BCX<\\XOM>         ## "index only, multiply": body is treated as a \I<list> of phrases to be made index entries. (Phrases are delimited by (whitespaces and) "|" unless another delimiter string is specified via option \C<d>.) At the current position, the body text remains invisible. ## \C<\\XOM<entry, in context | context entry\>>
\BCX<\\CENTER>      ## centers the body ## \C<\\CENTER<centered\>>
\BCX<\\CENTER_ON>   ## activates HTML centering (by inserting a \C<<CENTER\>> tag) ## \C<\\CENTER_ON>
\BCX<\\CENTER_OFF>  ## deactivates HTML centering (by inserting a \C<</CENTER\>> tag) ## \C<\\CENTER_OFF>
\BCX<\\INDENT>      ## indents the body ## \C<\\INDENT<indented\>>
\BCX<\\INDENT_ON>   ## opens a new indentation level ## \C<\\INDENT_ON>
\BCX<\\INDENT_OFF>  ## closes an indentation level ## \C<\\INDENT_OFF>
\BCX<\\SMALL>       ## formats the body using the HTML tag \C<<SMALL\>>  ## \C<\\SMALL<small text\>>
\BCX<\\RED>         ## red colorization ## \C<\\RED<colored\>>
\BCX<\\GREEN>       ## green colorization ## \C<\\GREEN<colored\>>
\BCX<\\BLUE>        ## blue colorization ## \C<\\BLUE<colored\>>
\BCX<\\CPAN_MODULE> ## The body is treated as the name of a CPAN module. The body text is made a link to the modules page on \URLT<search.cpan.org> (the address is built generically). Additionally, the reference is registered and used when the \OREF{n="Module index"}<module index> is built. ## \C<\\CPAN_MODULE<PerlPoint::Package\>>
\BCX<\\DATE>        ## inserts the current date and time ## \C<\\DATE>
\BCX<\\COPYRIGHT>   ## inserts an HTML copyright character ## \C<\\COPYRIGHT>


When asking speakers for their files, a list of these standard macros could be passed to let
them know which features are available by default.

In case you want to provide even more predeclared macros, write the definitions to a file, store
it in the PerlPointCD directories (preferably under \CX<prepare>) and integrate it by using the
\CX<makefile> \X<macro> \CX<INITFILE>.

||c||  make \RED<INITFILE=prepare/macros.pp>

Please note that the tool macros (listed above) are read \I<later> then this initfile, which
means that the initfile cannot redefine or reset them.

For this demonstration, I defined macros for footnotes and convenient cross references. These
macros are available with the distribution as well (see \C<prepare/macros.pp>).

||c||@|
macro          | description | options | example
\BX<\\FN>      | Defines a footnote. The footnote name should be exclusive. | \C<n>: name (mandatory) | \C<\\FN{"footnote example"}<An example footnote.\>>
\BX<\\FNR>     | A footnote reference. Multiple references to the same note are possible. | \C<n>: name (mandatory) | \C<\\FNR{"footnote example"}>
\BX<\\TS>      | A helper macro to start a footnote text paragraph. Usually, if a text paragraph starts with a tag or macro, PerlPoint delays paragraph type recognition till the tag/macro is closed, which means the tag or macro body needs to be found on the same line. For (possibly long) footnotes, this is not convenient. The \C<\\TS> macro is a workaround: it closes immediately and produces no contents. This means the paragraph type (text) is recognized very quickly, and a subsequent and possibly long tag or macro can be split up upon lines. | | \C<\RED<\\TS>\\FN{"footnote example"}<An example footnote.\>>
\BX<\\OREF>    | An \I<o>ptional \I<ref>erence. A link is produced \I<only if the target exists>, otherwise just the macro body shows up. Non existing targets will cause info messages, but no error. | \C<n>: target name (mandatory) | \C<\\OREF{n="A possibly existing chapter"}<chapter\>>





