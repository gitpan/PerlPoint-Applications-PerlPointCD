
Besides \X<PerlPoint>, each source file can be provided in \X<POD> as well. This feature
is enabled by a PerlPoint \X<input filter>, which can be compared to the \IX<import filters> of
usual applications.

But this feature is not limited to POD - in fact, \I<any> \XO<format>\X<input format> can be
supported by \IX<user defined import filters>. A PerlPointCD import filter for a certain
\I<format> is a Perl file named \CX<ifilter.<format\>> in an \IX<import filter directory>,
defining a filter function \CX<<format\>2pp()>.

Please note that formats are recognized by file extensions, so the \X<extension> of a filter
source file and the extensions of sources in the corresponding format need to be equal.

||c||  ifilter.\RED<pod> defines a filter
  \RED<pod>2pp for *.\RED<pod> files.

  ifilter.\BLUE<wi\B<K>i> defines a filter
  \BLUE<wi\B<K>i>2pp for *.\BLUE<wi\B<K>i> files,
  not *.wi\I<k>i files.

Writing a filter is easy: a filter function gets the source lines in an \I<array>
\CX<@main::_ifilterText> and supplies a PerlPoint \I<string>. See the distributed POD
filter for an example.

The \X<filter directory> is set up by a \X<makefile> \X<macro> \RED<\CX<IMPORTFILTERDIR>>. A
second macro, \RED<\CX<IMPORTORDER>>, specifies the search order for alternative formats.

||co|c||  # set up import filters
  \RED<IMPORTFILTERDIR>=PerlPointCD/ifilters
  \RED<IMPORTORDER>=pod twiki kwiki


