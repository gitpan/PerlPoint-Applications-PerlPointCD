
Not all CD text in generated pages is produced from source files. There are phrases that are
inserted automatically, like \I<"Proceedings"> as title of the link generated to a speakers
additional materials.

The language these texts are written in is set by a \XO<makefile macro>\C<makefile> macro
\CX<DEFAULT_LANGUAGE>.
It is optional and defaults to \CX<en>, which means English. As this tool was developed for
the \GPW, the
second language setting currently supported is \CX<de> (for German). More languages can be
easily added on request.

So a call of \CX<make> can use this macro to configure the default language settting:

||c||  make \RED<DEFAULT_LANGUAGE=de>

If this is a permanent setting for a project, it is easier to edit this setting inside the
\CX<makefile>:

||co|c||  # default language (falls back to "en")
  \RED<DEFAULT_LANGUAGE=de>

Nevertheless, not all speakers provide abstracts in the default language, which can lead to
inconsistent pages.

||c||  If the default language is German, "Unterlagen"
  below an English abstract doesn't look perfect.

So the language setting can be modified for every single page, in a file named
\C<<directory level type\>.lang> (\CX<author.lang>, \CX<talk.lang> etc.). The language shortcut
is expected in the first line. Here is an example:

||c||  de




