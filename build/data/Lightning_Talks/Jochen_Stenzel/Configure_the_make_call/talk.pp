
PerlPointCD configurations are mostly done by \CX<makefile> \X<macros>. As usual with \CX<make>,
those macros can be modified in the \C<makefile> or overwritten by assignments passed to
\C<make>.

Here is a list of the available settings.


||c||@|
Macro                   | Description
\BX<PERL>               | the command to invoke \CX<perl>
\BX<PPCD>               | the directory of PerlPointCD tools, usually \CX<PerlPointCD>
\BX<PREPARE>            | the directory of user preparations, usually \CX<prepare>
\BX<BUILD>              | the directory to build the CD in, usually \CX<build>
\BX<STYLES>             | the root directory of \X<PerlPoint> \X<styles> (or \X<layouts>), usually \C<${PREPARE}/styles>
\BX<DEFAULTS>           | the directory of \OREF{n=Defaults}<defaults>, usually \C<${PREPARE}/\X<defaults>>
\BX<IMAGESRCDIR>        | the directory to \I<find> \OREF{n="Integrating images"}<images> in when parsing the PerlPoint sources, \I<relative to the tool start directory>, usually \C<${BUILD}/images>
\BX<IMAGEREFDIR>        | the directory to \I<display> \OREF{n="Integrating images"}<images> from in generated pages, \I<relative to the CD root>, usually \C<images>
\BX<DATA>               | the base directory of the talk \X<directory structure>, usually \C<${BUILD}/\X<data>>
\BX<CONFERENCE>         | the title of the current workshop, used when building links to the workshop startup page in \OREF{n="Author index"}<author> and \OREF{n="Module index"}<module> index entries
\BX<PROJECT>            | the base name of the PerlPointCD script, \C<demo-cd> in this distribution
\BX<TITLE>              | the title displayed in generated pages
\BX<TOCTITLE>           | the title of the TOC page, usually "Contents"
\BX<CDAUTHORMAIL>       | the mail address of the conference organizers, stored in generated meta tags
\BX<CDDESCRIPTION>      | CD description string, stored in generated meta tags
\BX<CDINITIALURL>       | initial startup URL of the CD - used when linking to the startup page and only working if the CD is installed on a Webserver, usually \C</index.html>
\BX<CDSTARTURL>         | CD start URL (including server name), used when generating \OREF{n="Validation support"}<validation links>
\BX<TALKSTYLEORDER>     | \OREF{n="Directory order"}<talk style order> configuration
\BX<INITFILE>           | \OREF{n="PerlPoint macros ready to use"}<initial PerlPoint file> to declare macros, variables, code etc. available to all team members and contributing speakers
\BX<INTROTITLE>         | title of the optional \OREF{n="Welcome and Impressum"}<intro page>
\BX<INTROFILE>          | an optional \OREF{n="Welcome and Impressum"}<intro page>
\BX<IMPRESSUM>          | an optional \OREF{n="Welcome and Impressum"}<impressum>
\BX<IMPORTFILTERDIR>    | directory of pluggable \OREF{n="Import filters can be added"}<import filters>
\BX<IMPORTORDER>        | the order alternative formats should be taken into account if a PerlPoint source is missing (\I<e.g. if \C<author.pod> or \C<author.wiki> should be chosen if there is no \C<author.pp>, both files exist and \OREF{n="Import filters can be added"}<filters> were defined for both>)
\BX<DEFAULT_LANGUAGE>   | configures the \OREF{n="Language support"}<default language> of generated texts
\BX<CHECKLOG>           | the logfile written in \OREF{n="Source checks"}<check mode>, overwritten by each checking call
\BX<CHECKDATA>          | a data file used in \OREF{n="Source checks"}<check mode>, overwritten by each checking call
\BX<TRACE>              | \X<PerlPoint> \X<trace level>, see the documentation of \CX<pp2html> for details
\BX<INDEXREL_READDEPTH> | \OREF{n="Automatic cross references"}<index based cross references>: number of sublevels to be searched for index entries on \I<referencing> pages, defaults to \C<full>
\BX<INDEXREL_RELDEPTH>  | \OREF{n="Automatic cross references"}<index based cross references>: number of sublevels to be taken into account on \I<referenced> pages, defaults to \C<full>
\BX<INDEXREL_THRESHOLD> | \OREF{n="Automatic cross references"}<index based cross references>: threshold, defaults to \C<20%>

