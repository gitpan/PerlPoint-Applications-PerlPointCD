
Every conference has several \X<types of talks>. At the
\GPW we use to have \IX<Tutorials>,
\IX<Long Talks>, \IX<Short Talks> and even \IX<Lightning Talks>. More, there are special types
like \IX<Invited Talks>, \IX<BOFs> and the like.

For each presentation type, there are speakers talking. Several speakers just hold one talk.
Others provide lots of them.

The point is that the talks can be easily categorized. Here is how PerlPointCD does it:

* A conference has \CPAN_MODULE<Event> types. Oops, this should read \I<\X<event types>>. ;-)
  (Internally, event types are refered as "styles".)

* There are \I<speakers> for each type of event.

* Every speaker gives \I<talks>.

So the \X<hierarchy> is \RED<\X<style> - \X<author> - \X<talk>>. Pretty easy. And the
\X<directory structure> reflects it.

For every hierarchy \X<level>, the tool expects a corresponding directory level in the
\BCX<data> subdirectory of \CX<build>. So to organize the talks for the CD, just make the
directories.

||c||  Let's say we have two \I<Long Talks> by
  \I<James Fletcher> about \I<"The art
  of presentation"> and \I<"Burning a CD">.
  The second one is held together with his
  wife \I<Jane>.

  The corresponding directory structure is

    Long_Talk/James_Fletcher/The_art_of_presentation
    Long_Talk/James_Fletcher,_Jane_Fletcher/Burning_a_CD

  in the build/data directory.

What about the underscores? They represent spaces. If the file system supports spaces in file
names, spaces can be used directly as well (but it might make handling handier to stay with the
underscores).

\XO<multiple authors>Please note how the Fletchers were combined in the authors directory name.
The convention is to use a \X<comma> and optional whitespaces around it.

Working on a directory base makes it easy to \I<move> talks around.

||c||  If Mr. Fletcher decides to give Tutorials
  instead of Long Talks, all I have to do is
  to move the \C<Fletcher> directories from
  \I<Long_Talks> to \I<Tutorials>.

It's also easy to add or cancel events at any time during conference preparation.

Now, I suggest to play around and add a few talks, aehm, directories. There is no need for
contents - the directories will make a pretty nice CD frame.




