
When integrating \X<binary files> like the \X<photo> collections of several
\OREF{n=Archives}<archived> conference years, it makes sense to store them
in \I<one> central place. That's what the \CX<bindata> directory under \CX<build>
is intended for.

To use this directory, just copy all those files into it and refer to them by URL's:

||c||  \\URL{a="\RED<bindata>/proceedings-2003.pdf"}<PDF file>

Please note:

* This technique neither works nor is necessary for \OREF{n="Integrating images"}<images>
  integrated via \CX<\\IMAGE> tags.

* This approach applies to CD sources \I<only>. Stuff provided by speakers can be stored
  unmodified in the talk directories as \OREF{n="Integrating stuff"}<described>.

