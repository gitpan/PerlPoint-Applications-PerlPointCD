
Just to mention it, \X<images> can be easily integrated. There's a PerlPoint \CX<\\IMAGE> tag
to do this:

||c||  \RED<\\IMAGE{src="your.gif"}>

The tag accepts more options. PerlPoint specific options fine tune the inclusion. Additionally,
simply all HTML \CX<<IMG\>> options are supported when producing HTML - they are passed through.

||c||  \GREEN<// include an image, right aligned>
  \\IMAGE{src="your.gif" \RED<align=right>}

Here's a visual example:

||c||\IMAGE{src="PPL13s1a-o.jpg"}

