
While waiting for the materials, we can take care of the CD \X<layout>. It is configured
by \I<\X<PerlPoint> layouts>, typically stored in the \C<\X<prepare>/\X<styles>> subdirectory.

\LOCALTOC{type=linked}

=Layout configuration

When installed initially, PerlPointCD comes with two demo layouts: \CX<demo-cd> builds
\X<frame> based HTML pages with \X<Java> navigation, while \CX<demo-cd-css> constructs CSS
based slides. Prefering one or the other is a matter of personal taste, so the initial
\CX<makefile> uses \I<both> of them to offer alternatives.

Feel free to modify the demo layouts. To use your own, just store them in the \C<style>
directory as well. (While it is possible to store them anywhere in the PerlPoint include path,
integration with the tool directories makes it easier to share a CD package with a team.)

Layout integration is controlled by various files. First, replace the config files with your
own ones, or just edit the original files (which can be
found as \C<prepare/demo-cd.cfg> and \C<prepare/demo-cd-css.cfg>). In any case,
adapting these configurations is the next step. I recommend to stay with the frame

||co|c|| # base configuration
 @demo-cd-base.cfg

 # style
 \RED<-style demo-cd>

 # use your own filenames
 \RED<-start_page   jindex.htm
 -slide_prefix jslide>

 # activate browser navigation
 -linknavigation

and to adapt just the \CX<-style>, \CX<-start_page> and \CX<-slide_prefix> options.

Second, the following lines in the \CX<makefile> need to be
\OREF{n="Configure the make call"}<adapted> to integrate your layouts:

||co|c|| html: explode
   # design 1
   ${PPCD}/pp2html @\RED<${PREPARE}/${PROJECT}.cfg> ...
   # design 2
   ${PPCD}/pp2html @\RED<${PREPARE}/${PROJECT}-css.cfg> ...

If you prefer to have even more layouts or just one, add or delete lines appropriately.

=Startup page

Having several \X<layout> variants requires to have a \X<startup page> that offers the choices.
For the \GPW, we used an \CX<index.html> file in the \CX<build> directory
(which becomes the \X<CD startup directory> later on). A derived copy of this page is
provided with this demo, so please have a look. This page is \I<handcrafted>, so one can
imagine all kinds of solutions. Our page tried to detect whether the user has \X<Java>
activated or not, and then tries to redirect automatically to the layout that is probably
preferred - after a period of 60 seconds or so.


