
PerlPoint layouts allow to use navigation references, like in this demo: each page has a
navigation bar with links to the next and the previous page.

If a title of a talk is very long, the resulting navigation bars can look a little bit
misdesigned. In this case one can declare a \IX<short title> version by adding a \CX<talk.short>
file to the talk \X<directory> (where \CX<talk.pp> is located). This file should contain
the short title version in its first line.

||c||  For an example of the effect, look at the
  navigation links \I<to> this page - in the
  navigation bars of the previous and following
  pages.

This feature works for \I<all> levels of the \X<directory structure> - files need to be
named level specific like \CX<style.short>, \CX<author.short> etc. -  but most likely the
talk level is the one where it is mostly required.

