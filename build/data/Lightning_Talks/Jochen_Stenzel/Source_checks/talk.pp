
CD \X<source files> are contributed by several people and combined by the tool. But a source
might have \IX<errors>, which can make the whole production fail. In preparing the CD, it is
helpful to get a list of such errors \I<and> a CD made on base of the remaining sources, which
are clean. Both is provided by the \IX<check mode>.

Check mode is activated when running \CX<make> with the target \CX<safely>.

||c||  make \RED<safely>

This call takes care for sources that cannot be compiled. Such sources are excluded one by
one as long as the CD can be built. Error messages are collected in a file, which then can
be sent to the CD team, organizers or custodians. This makes it suitable for nightly builds.

This special mode is set up by a few \CX<makefile> macros:

||co|c||  # check logfile
  \RED<CHECKLOG>=ppcd.log

  # intermediate data file
  \RED<CHECKDATA>=PerlPointCD/.checkdata.ppcd

These files are rewritten every time a new check starts.




