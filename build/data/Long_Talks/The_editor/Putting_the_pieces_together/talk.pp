
Here is the CD team again. The \X<custodians> sent us the speaker materials, usually in the
form of author \X<directories>.

Such a directory looks like this:

  \GREEN<\I<James_Fletcher>>
    |
    |-- author.pp
    |
    |-- \I<Burning_a_CD>
          |
          |-- talk.pp
          |
          |-- \I<data>
                |
                |-- index.html
                |
                |-- <more stuff>

It is made part of the CD by storing it in the appropriate \X<talk type directory> - remember
we have \X<Tutorials>, \X<Long Talks> etc.

If Mr. Fletcher gives a "Long Talk", the resulting directory structure is this:

  \RED<\I<working directory (the one with a makefile)>
    |
    |-- \IX<build>
          |
          |-- \IX<data>
                |
                |-- \IBX<Long_Talks>>
                      |
                      |-- \GREEN<\I<James_Fletcher>>
                            |
                            |-- author.pp
                            |
                            |-- \I<Burning_a_CD>
                            |
                            |...

Doing this for various talks (and running \CX<make>, subsequently ;-) results in a (hopefully)
complete presentation of the talks.

And so the base part is done.



