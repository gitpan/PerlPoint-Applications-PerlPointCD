
Having a CD of the current confenerence is great. Having a CD of the whole conference series
is greater. Especially with \OREF{n="Automatic cross references"}<cross references> between the
talks. Why not include previous years?

PerlPointCD supports archives by treating a \X<type level> directory
\RED<\B<"\X<Archive>">> special. It is handled as of a special type \RED<"archive">, holding
directories of type \GREEN<"workshop">\FNR{n="workshop level hint"}. Every \IX<workshop level>
directory is the root of a usual \X<directory structure> as known for the current conference, containing type,
author and talk directories.

Keep cool. Here's a picture.

||c||  \GREEN<<CD root - current conference\>>
    |
    |- Tutorials
    |
    |- Long_Talks
    |
    ...
    |
    |- \RED<Archive>
         |
         |- \GREEN<One_year_before>
         |    |
         |    |- Tutorials
         |    |
         |    |- Long_Talks
         |    |
         |    ...
         |
         |- \GREEN<Two_years_before>
         |    |
         |    |- Tutorials
         |    |
         |    |- Long_Talks
         |    |
         |    ...
         |
         ...

Please note the green levels. Their substructures are absolutely equal. And this means that
after having the CD sources of one year, this year can be archived by

* making a new conference directory under "Archive"

* and moving all the contents of the CD root directory into it. \FNR{n="recursive archive move"}

\HR

// footnotes
\TS\FN{n="workshop level hint"}<This could read "conference", of course. But you know, this all
                                started with the \I<\GPW> CDs ... And by the
                                way, that's the reason to name this directory "Archive", not
                                "Archives". It is wonderfully multilingual in this context.>

\TS\FN{n="recursive archive move"}<Avoid to move "Archive".>


