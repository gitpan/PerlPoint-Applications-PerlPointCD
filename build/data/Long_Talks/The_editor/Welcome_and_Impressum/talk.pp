
To complete the CD, one can add a \X<welcome text> and an \X<impressum>, both written in
\X<PerlPoint> or \X<POD> as usual.

The \CX<makefile> has \X<macros> to add these parts:

* The \CX<INTROFILE> macro integrates an optional \X<startup part>.

* The \CX<IMPRESSUM> macro adds an optional \X<postambel>.

They can be used like this:

  make \RED<\B<INTROFILE>=prepare/welcome.pp \\
       \B<IMPRESSUM>=prepare/impressum.pp>

The \C<prepare> directory used in this example is the recommended place for such sources,
according to the \X<directory structure>, but you are free to choose your own.

