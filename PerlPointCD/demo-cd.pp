
// ----------------------------------------------
//
//    PerlPoint script to make a conference cd.
//                 Version 0.19.
//
//           (c) Jochen Stenzel, 2002-2003,
//                all rights reserved.
//
//  See attached README file for usage details.
//
//  To configure the script, please adapt the
//  attached makefile.
//
// ----------------------------------------------


// declare a separator variable
$empty=

// declare a few macros
+DATE:\EMBED{lang=perl}use POSIX; strftime("%d.%m.%Y, %H:%M", localtime);\END_EMBED

+BU:\B<\U<__body__>>

+BX:\B<\X<__body__>>

+BC:\B<\C<__body__>>

+CX:\C<\X<__body__>>

+BCX:\B<\C<\X<__body__>>>

+IB:\I<\B<__body__>>

+IX:\I<\X<__body__>>

+IBX:\I<\B<\X<__body__>>>

+URL:\L{target=_blank url="__a__"}<__body__>

+URLT:\EMBED{lang=perl}
      {
       my ($address, $body);
       $address=$body=q(__body__);
       $address="http://$address" unless $address=~m#^[^:/]+://#;
       qq(\\URL{a="$address"}<$body>);
      }
      \END_EMBED

+MAILTO:\L{url="mailto:__body__"}<__body__>

+MAIL:\L{url="mailto:__addr__"}<__body__>



+XO:\X{mode=index_only}<__body__>

// like \XO, but allow to specify multiple links at once
+XOM:\EMBED{lang=perl}
     my ($delimiter)=('__d__');
     $delimiter='|' unless $delimiter;
     join('', map {s/^\s+//; s/\s+$//; qq(\\X{mode="index_only"}<$_>)} split(quotemeta($delimiter), '__body__'));
     \END_EMBED

+CENTER:\EMBED{lang=html}<center>\END_EMBED__body__\EMBED{lang=html}</center>\END_EMBED

+CENTER_ON:\EMBED{lang=html}<center>\END_EMBED

+CENTER_OFF:\EMBED{lang=html}</center>\END_EMBED

+INDENT:\EMBED{lang=html}<ul>\END_EMBED__body__\EMBED{lang=html}</ul>\END_EMBED

+INDENT_ON:\EMBED{lang=html}<ul>\END_EMBED

+INDENT_OFF:\EMBED{lang=html}</ul>\END_EMBED

+SMALL:\EMBED{lang=html}<small>\END_EMBED__body__\EMBED{lang=html}</small>\END_EMBED

// colors
+RED:\F{color=red}<__body__>

+GREEN:\F{color=green}<__body__>

+BLUE:\F{color=blue}<__body__>

// copyright HTML
+COPYRIGHT:\EMBED{lang=html}&copy;\END_EMBED

// link builder
+CPAN_MODULE:\EMBED{lang=perl}
             {
	      my $name='__body__';
              $seenModules{$name}{$chapterHints->[0]}{$chapterHints->[1]}=$chapterHints->[2];
              $name=~s(::)(-)g;
              $name=~s/::/\%3A\%3A/g;
              qq(\\XO<__body__>\\C<\\URL{a="http://search.cpan.org/dist/$name"}<__body__>>);
             }
             \END_EMBED

// -----------------------------------------


// declare paragraph filters
\EMBED{lang=perl}

# center examples
sub center
 {
#  warn "\n\n\\CENTER_ON\n\n|$main::_pfilterText|\n\n\\CENTER_OFF\n\n";
#  getc;

  # just wrap what you found
  "\n\n\\CENTER_ON\n\n$main::_pfilterText\n\n\\CENTER_OFF\n\n";
 }

# highlight Perl examples
sub formatComments
 {
  $main::_pfilterText=~s/((?<!([\":\$]))#.+)$/\\GREEN<$1>/mg;
  $main::_pfilterText;
 }

# declare shortcuts ...
*c=\&center;
*co=\&formatComments;

# supply dummy PerlPoint code
'';

\END_EMBED


// -----------------------------------------




\EMBED{lang=perl}

# load modules
use Cwd;
use Storable qw(nstore retrieve);

# declare common variables
my (
    $archiveDirname,               # 1
    $checkdata,                    # 2
    $checkdataFile,                # 3
    %collection,                   # 4
    %authordata,                   # 5
    %authornames,                  # 6
    %flags,                        # 7
    @ifilters,                     # 8
   )=(
      'Archive',                   # 1
       {},                         # 2
     );

# declare (and init) variables
my ($result)=('');

# scan user settings
my @cdSettings=grep(/^ppcd/, keys %{$PerlPoint->{userSettings}});
if (@cdSettings)
 {
  foreach my $setting (@cdSettings)
    {
     my ($option, $value)=split(/=/, $setting);
     $cdSettings{$option}=$value;
    }
 }

# check settings
die qq([Fatal] Please set up the INTROFILE macro.\n) unless exists $cdSettings{ppcdWelcome};
die qq([Fatal] Please set up the INTROTITLE macro.\n) unless exists $cdSettings{ppcdIntroTitle};
die qq([Fatal] Please set up the DATA macro.\n) unless exists $cdSettings{ppcdDataDir};
die qq([Fatal] Please set up the DEFAULTS macro.\n) unless exists $cdSettings{ppcdDefaultsDir};
die qq([Fatal] Please set up the CONFERENCETITLE macro.\n) unless exists $cdSettings{ppcdConferenceTitle};
die qq([Fatal] Please set up the CHECKDATA macro.\n) if exists $cdSettings{ppcdCheck} and not exists $cdSettings{ppcdCheckData};

# warnings
warn qq(\n[Warn] Unknown DEFAULT_LANGUAGE setting "$cdSettings{ppcdDefaultLanguage}" will be ignored.\n\n) if exists $cdSettings{ppcdDefaultLanguage} and $cdSettings{ppcdDefaultLanguage}!~/^(\s*|de|en)$/;

# check mode setup take over
$flags{check}=exists $cdSettings{ppcdCheck};
$flags{frameonly}=exists $cdSettings{ppcdFrameOnly};

# make file specs absolute, if necessary
$cdSettings{ppcdWelcome}=join('/', cwd(), '..', $cdSettings{ppcdWelcome}) unless $cdSettings{ppcdWelcome}=~m#^/# or not (exists $cdSettings{ppcdWelcome} and $cdSettings{ppcdWelcome});
$cdSettings{ppcdDataDir}=join('/', cwd(), '..', $cdSettings{ppcdDataDir}) unless $cdSettings{ppcdDataDir}=~m#^/#;
$cdSettings{ppcdDefaultsDir}=join('/', cwd(), '..', $cdSettings{ppcdDefaultsDir}) unless $cdSettings{ppcdDefaultsDir}=~m#^/#;
$cdSettings{ppcdImportFilterDir}=join('/', cwd(), '..', $cdSettings{ppcdImportFilterDir}) unless not exists $cdSettings{ppcdImportFilterDir} or $cdSettings{ppcdImportFilterDir}=~m#^/#;
$cdSettings{ppcdTalkStyleOrder}=join('/', cwd(), '..', $cdSettings{ppcdTalkStyleOrder}) unless $cdSettings{ppcdTalkStyleOrder}=~m#^/#;
$cdSettings{ppcdCheckData}=join('/', cwd(), '..', $cdSettings{ppcdCheckData}) unless not exists $cdSettings{ppcdCheck} or $cdSettings{ppcdCheckData}=~m#^/#;

# check directory names
die qq([Fatal] DATA macro $cdSettings{ppcdDataDir} is no directory.\n) unless -d $cdSettings{ppcdDataDir};
die qq([Fatal] DEFAULTS setting $cdSettings{ppcdDefaultsDir} is no directory.\n) unless -d $cdSettings{ppcdDefaultsDir};
die qq([Fatal] IMPORTFILTERDIR macro $cdSettings{ppcdImportFilterDir} is no directory.\n) if exists $cdSettings{ppcdImportFilterDir} and not -d $cdSettings{ppcdImportFilterDir};

# set defaults as necessary
$cdSettings{ppcdDefaultLanguage}='en' unless exists $cdSettings{ppcdDefaultLanguage} and $cdSettings{ppcdDefaultLanguage}=~/^(de|en)$/;

$cdSettings{ppcdIndexrelRelDepth}='full' unless exists $cdSettings{ppcdIndexrelRelDepth} and $cdSettings{ppcdIndexrelRelDepth}=~/^(full)$/;
$cdSettings{ppcdIndexrelReadDepth}='full' unless exists $cdSettings{ppcdIndexrelReadDepth} and $cdSettings{ppcdIndexrelReadDepth}=~/^(full)$/;
$cdSettings{ppcdIndexrelThreshold}='20%' unless exists $cdSettings{ppcdIndexrelThreshold} and $cdSettings{ppcdIndexrelThreshold}=~/^(\d{1,2}|100)\%$/;


# produce intro, if set up
$result.=<<EOM if exists $cdSettings{ppcdWelcome} and $cdSettings{ppcdWelcome};


=$cdSettings{ppcdIntroTitle}


\\INCLUDE{type=pp file="$cdSettings{ppcdWelcome}"}  

EOM


# declare variables to declare the preferred sort order of expected style directories
my (%styleOrder, @styleOrder);

# register import filters, if necessary
if (exists $cdSettings{ppcdImportFilterDir})
 {
  # get filter names
  opendir(IFD, $cdSettings{ppcdImportFilterDir}) or die qq([Fatal] Could not open import filter directory $cdSettings{ppcdImportFilterDir}: $!.);
  foreach (readdir(IFD))
    {
     # search for filters named ifilter.<extension=source format>
     next unless /^ifilter\.(\w+)$/;
     # import the filter code
     $result.=qq(\n\n\\INCLUDE{type=perl file="$cdSettings{ppcdImportFilterDir}/$_"}\n\n);
     # register the filter
     push(@ifilters, lc($1));
    }
  closedir(IFD);

  # (mis)use the style order feature to sort import filters (a more common sort function
  # would be a better solution ...)
  @styleOrder=exists $cdSettings{ppcdImportOrder} ? split(/\s+/, $cdSettings{ppcdImportOrder}) : ();
  @styleOrder{@styleOrder}=(1..@styleOrder);
  @ifilters=map {$_->[1]} sort byStyle map {['', $_]} @ifilters;

  # reset style order variables
  undef @styleOrder;
  undef %styleOrder;
 }

# read style order specification
if (exists $cdSettings{ppcdTalkStyleOrder})
 {
  # read first line
  warn cwd();
  open(S, $cdSettings{ppcdTalkStyleOrder}) or die qq([Fatal] Could not open style order spec file $cdSettings{ppcdTalkStyleOrder}.\n);
  while (<S>)
    {
     # skip empty and comment lines
     next if /^\s*$/ or /^\s*#/;

     # a chapter string: remove leading and trailing whitespaces
     s/^\s+//;
     s/\s+$//;

     # store it
     push(@styleOrder, $_);
    }
  close(S);
 }

# now store the preferred order
@styleOrder{@styleOrder}=(1..@styleOrder);


# bootstrap: traverse the file system
# -----------------------------------

# declare data to control recursive directory processing
my %ctrl=(
          # settings: proceed subchapters, subchapter style, subchapter sorting (lexically (0),
          # by *last* word (true non reference value) or subroutine (sub reference))
          archive  => [1, 'workshop', 1, 1,            0,],
          workshop => [1, 'style',    1, \('byStyle'), 0,],
          style    => [1, 'author',   1, 1,            0,],
          author   => [1, 'talk',     1, 0,            1,],
          talk     => [0, '',         0, 0,            0,],
         );

# change directory, store path of defaults directory by the way
my $startdir=cwd;
my $defaultsDir=$cdSettings{ppcdDefaultsDir};
my $dataDir=$cdSettings{ppcdDataDir};
chdir($dataDir) or die qq([Fatal] Could not change into start directory "$dataDir".\n);

# init check data, if necessary
$checkdataFile=$cdSettings{ppcdCheckData};
$checkdata=retrieve($checkdataFile) if $flags{check} and -e $checkdataFile;

# read directory contents
opendir(D, '.');
my @dirs=map {dirTranslation('.', $_)} sort grep((!/^\.{1,2}$/ and -d and $_ ne $archiveDirname), readdir(D));
closedir(D);

# process current workshop directories
$result.=processDir(1, 'style', $dataDir, 'data', $_) foreach (sort byStyle @dirs);

# process workshop archive directories, if necessary
$result.=processDir(1, 'archive', $dataDir, 'data', [($archiveDirname) x 2]) if -d $archiveDirname;

# back to startup directory
chdir($startdir) or die qq([Fatal] Could not change back into startup directory "$startdir".\n);

# update navigation hints
$result.=join('', "\n\n", '$', "youAreHereTop=Authors<BR>\n\n");
$result.=join('', "\n\n", '$', "youAreHereBottom=<BR>Authors\n\n");

# start author chapters
$result.="\n\n=Authors\n\n";

# replace the following by LOCALTOC - as soon as it supports bullets ...
if (%authordata)
 {
  $result.=qq(\\CENTER_ON\n\n\\TABLE{separator="##########" border=0}\n);
  for (sort {lc($a) cmp lc($b)} keys %authordata)
   {$result.=qq(\\SECTIONREF{name="Authors|$authornames{$_}"}\n);}
  # $result.="\\LOCALTOC{type=linked depth=1}\n\n";
  $result.="\\END_TABLE\n\n\\CENTER_OFF\n";
 }

foreach my $author (sort {lc($a) cmp lc($b)} keys %authordata)
 {
  # scopy
  my ($workshop, $iformat)=('');

  $result.=qq(==$authornames{$author}\n\n\\XO<$authornames{$author}>\\XO<$author>\n\n);

  # there may be an introducting text in the defaults tree
  (my $authorWithUnderscores=$authornames{$author})=~s/ /_/g;
  if (-e (my $filename="$defaultsDir/author/$authorWithUnderscores/author.pp"))
   {
    # can we include this file?
    if (checkFile($filename))
     {
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
      $result.=qq(\n\n\\INCLUDE{type=pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
     }
   }
  elsif ($iformat=findImportableFile("$defaultsDir/author/$authorWithUnderscores", "author"))
   {
    # can we include this file?
    if (checkFile((my $filename="$defaultsDir/author/$authorWithUnderscores/author.$iformat")))
     {
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
      $result.=qq(\n\n\\INCLUDE{type=pp ifilter=\${iformat}2pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
     }
   }

  foreach my $record (@{$authordata{$author}})
   {
    # open a new workshop section, if necessary
    unless ($record->[0] eq $workshop)
      {
       $workshop=$record->[0];
       $result.=join('',
                     qq(\\INDENT<\\BU<\\XREF{name="),
                     $workshop eq $cdSettings{ppcdConferenceTitle} ? $cdSettings{ppcdIntroTitle} : $workshop,
                     qq("}<$workshop>>>\n\n)
                    );
      }

    # add talk data
    $result.=join('',
                  qq(* \\XREF{name="$record->[2]"}<$record->[1]>),
                  defined $record->[3] ? " / $record->[3]" : (),
                  qq(\n\n),
                 );
   }
 }

# store check data in check mode
nstore($checkdata, $checkdataFile) if $flags{check};

# provide result
$result;


# SUBROUTINE SECTION #######################

# process a directory of a certain type on a certain headline level
sub processDir
 {
  # get and check parameters
  my ($level, $type, $path, $headlinePath, $dir)=@_;
  die "[BUG] Missing valid level parameter" unless $level and $level>0;
  die "[BUG] Missing valid type parameter" unless $type and exists $ctrl{$type};
  die "[BUG] Missing relative path parameter" unless defined $path;
  die "[BUG] Missing $type directory parameter" unless $dir;

  # declare variables
  my ($result, $short, $dirname, $dirchapter, $iformat, @dirchapter)=('', '', @$dir);

  # change directory
  my $startdir=cwd;
  chdir($dirname) or die qq([Fatal] Could not change into $type directory "$dirname".\n);

  # inform user
  warn "[Info] Scanning $type $dirchapter.\n";

  # read subdirectories
  opendir(D, '.');
  my @dirs=map {dirTranslation('.', $_)} grep((!/^\.{1,2}$/ and -d), readdir(D));

  # sort them
  unless (ref($ctrl{$type}[3]) eq 'SCALAR')
    {
     # sort by default or by the last word
     @dirs=sort {$ctrl{$type}[3] ? ((split(/[_\s]+/, $a->[1]))[-1] cmp (split(/[_\s]+/, $b->[1]))[-1]) : ($a->[1] cmp $b->[1])} @dirs;
    }
  else
    {
     # sort by function (is there a better way than eval()?)
     eval "\@dirs=sort ${$ctrl{$type}[3]} \@dirs";
    }
  closedir(D);

  # there might be a short title hint
  if (-e "$type.short")
    {
     # read first line
     open(S, "$type.short");
     chomp((my $hint)=<S>);
     close(S);

     # set short title, if known
     $short=" ~ $hint" if $hint;
    }

  # start slide headline, named like the directory (with underscores translated into spaces)
  $dirchapter=~s/_/ /g;
  $result.=join('', "\n\n//$type $dirchapter\n\n", '=' x $level, "$dirchapter$short\n\n");

  # now add a generic index entry
  $result.="\\X{mode=index_only}<$dirchapter>\n\n";

  # now that we have this data, store it
  $collection{$type}=$dirchapter;

  {
   # update data collection as necessary here
   $collection{workshop}=$cdSettings{ppcdConferenceTitle} unless exists $collection{workshop};

   # prepare hierarchy
   my $hierarchy="$headlinePath/$dirchapter";
   $hierarchy=~s/_/ /g;
   my @hierarchy=split(m(/), $hierarchy);
   shift(@hierarchy);
   $hierarchy=join('|', @hierarchy);

   # add position hints to be read by macros
   $result.=join('', qq(\\EMBED{lang=perl}), '$', qq(chapterHints=["$collection{workshop}", "$dirchapter", "$hierarchy"]; ''; \\END), "_EMBED\n\n");
  }

  # add author links, if necessary
  if ($type eq 'author')
   {
    # there might be several authors
    $result.="\\CENTER_ON\\SMALL<";
    $result.=join(', ',
                  map {
                       qq(\\XREF{name="Authors | $_"}<$_>)
                      } (@dirchapter=map {split(/\s*,\s*/, $_)} split(/\s+[au]nd\s+/, $dirchapter))
                 );
    $result.=">\\CENTER_OFF\n\n";
   }

  # there may be an explicit list of more index entries
  if (-e "$type-index")
   {
    # read all words from this file and add them to the index
    open(I, "$type-index") or die "[Fatal] Could not open $dirname/type-index\n";
    while (<I>)
     {
      next if /^\s*$/ or /^\s*#/;
      s/^\s+//; s/\s*$//;
      $result.="\\X{mode=index_only}<$_>\n" for (map {s/_____/ /g; $_} split);
     }
    $result.="\n\n";
    close(I);
   }

  # there may be an introducting text, either here or in the defaults tree
  if (-e "$type.pp")
   {
    # include file, if possible
    if (checkFile(my $filename="$path/$dirname/$type.pp"))
     {
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
      $result.=qq(\n\n\\INCLUDE{type=pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
     }
   }
  # ok, try alternative formats
  elsif ($iformat=findImportableFile('.', $type))
   {
    # include file, if possible
    if (checkFile(my $filename="$path/$dirname/$type.$iformat"))
     {
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
      $result.=qq(\n\n\\INCLUDE{type=pp ifilter=\${iformat}2pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
      $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
     }
   }
  else
   {
    # multiple parts?
    unless (@dirchapter>1)
     {
      # all in one
      (my $part=$dirchapter)=~s/ /_/g;

      if (-e (my $filename="$defaultsDir/$type/$part/$type.pp"))
        {
         # include file, if possible
         if (checkFile($filename))
          {
           $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
           $result.=qq(\n\n\\INCLUDE{type=pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
           $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
          }
        }
      elsif ($iformat=findImportableFile("$defaultsDir/$type/$part", $type))
        {
         # include file, if possible
         if (checkFile(my $filename="$defaultsDir/$type/$part/$type.$iformat"))
          {
           $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
           $result.=qq(\n\n\\INCLUDE{type=pp ifilter=\${iformat}2pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
           $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
          }
        }
     }
    else
     {
      # there are several parts, handle them one by one
      foreach (@dirchapter)
       {
        (my $part=$_)=~s/ /_/g;

        if (-e (my $filename="$defaultsDir/$type/$part/$type.pp"))
          {
           # include file, if possible
           if (checkFile($filename))
            {
             $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
             $result.=qq(\n\n\\BU<$_>\n\n\\INCLUDE{type=pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
             $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
            }
          }
        elsif ($iformat=findImportableFile("$defaultsDir/$type/$part", $type))
          {
           # include file, if possible
           if (checkFile(my $filename="$defaultsDir/$type/$part/$type.$iformat"))
            {
             $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileInit("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
             $result.=qq(\n\n\\BU<$_>\n\n\\INCLUDE{type=pp ifilter=\${iformat}2pp file="$filename" headlinebase=CURRENT_LEVEL}\n\n);
             $result.=join('', qq(\n\n\\EMBED{lang=perl}checkFileOK("$filename")\\END_), qq(EMBED\n\n)) if $flags{check};
            }
          }
       }
     }
   }

  # are we in a node or in a leaf?
  if ($ctrl{$type}[0])
   {
    # node: make a subchapter TOC and proceed with subchapters (can be replaced by localtoc later)
    # $result.='\LOCALTOC{depth=1 type=linked}';
    $result.="\\INDENT_ON\n";
    for (@dirs) {my ($n, $p)=($_->[1], "$headlinePath/$dirchapter"); $n=~s/_/ /g; $p=~s/_/ /g; my @p=split(m(/), $p); shift(@p); $p=join('|', @p); $result.=qq(* \\SECTIONREF{name="$p|$n"}\n\n);}
    $result.="\\INDENT_OFF\n";
    $result.=processDir($level+1, $ctrl{$type}[1], "$path/$dirname", "$headlinePath/$dirchapter", $_) for @dirs;
   }
  else
   {
    # scopies
    my ($lang, $proceedings)=($cdSettings{ppcdDefaultLanguage});

    # browsers need special path characters sometimes
    my ($bpath, $bdirname)=($path, $dirname);
    $bpath=~s/:/%3A/g; $bpath=~s/\?/%3F/g;
    $bdirname=~s/:/%3A/g; $bdirname=~s/\?/%3F/g;

    # there might be a language hint
    if (-e "$type.lang")
     {
      # read first line
      open(L, "$type.lang");
      my $langhint=<L>;
      close(L);

      # set language, if known
      $lang='de' if $langhint=~/^de/i;
     }

    # leaf: link index page if available, directory otherwise
    if (-d 'data')
     {
      $proceedings=join('',
                        '\URL{a="',
                        "$bpath/$bdirname/data", -e 'data/index.html' ? '/index.html' : (),
                        '"}<',
                        $lang eq 'en' ? 'Proceedings' : 'Unterlagen',
                        '>',
                       );
      $result.="\n\n\\CENTER<$proceedings>\n\n";
     }

    # build crossref, if necessary
    if ($type eq 'talk')
      {
       my $indexRelated=$lang eq 'en' ? 'Index-related' : 'Indexverwandte Beiträge';
       $result.=qq(\n\n\\INDEXRELATIONS{reldepth=$cdSettings{ppcdIndexrelRelDepth} readdepth=$cdSettings{ppcdIndexrelReadDepth} threshold="$cdSettings{ppcdIndexrelThreshold}" type=linked intro="$indexRelated:"}\n\n);
      }

    # update data collections
    $collection{workshop}=$cdSettings{ppcdConferenceTitle} unless exists $collection{workshop};
    $collection{style}=~s/([^s])s$/$1/;

    # prepare hierarchy
    my $hierarchy="$headlinePath/$dirchapter";
    $hierarchy=~s/_/ /g;
    my @hierarchy=split(m(/), $hierarchy);
    shift(@hierarchy);
    $hierarchy=join('|', @hierarchy);

    # there may be several authors (use cascaded split() calls to avoid parens in split() regexps)
    foreach my $author (map {split(/\s*,\s*/, $_)} split(/\s+[au]nd\s+/, $collection{author}))
     {
      my $rname=[split(/\s+/, $author)];
      $rname=join(', ', $rname->[-1], join(' ', @{$rname}[0..($#{$rname}-1)]));

      # store name "translation"
      $authornames{$rname}=$author;

      # store talk data
      push(@{$authordata{$rname}}, [
                                    $collection{workshop},
                                    "$collection{talk} ($collection{style})",
                                    $hierarchy,
                                    defined $proceedings ? $proceedings : undef,
                                   ]
          );
      }

    # clean up data buffer
    undef(%collections);
   }

  # back to startup directory
  chdir($startdir) or die qq([Fatal] Could not change back into previous directory "$startdir".\n);

  # provide this styles result
  $result;
 }

# sort routine
sub byStyle
 {
     (
          exists $styleOrder{$a->[1]}
      and exists $styleOrder{$b->[1]}
      and $styleOrder{$a->[1]}<=>$styleOrder{$b->[1]}
     )
  or (
          exists $styleOrder{$a->[1]}
      and 1<=>2
     )
  or (
          exists $styleOrder{$b->[1]}
      and 2<=>1
     )
  or $a->[1] cmp $b->[1];
 }

sub dirTranslation
 {
  # get parameters
  my ($basedir, $subdir)=@_;

  # inits
  my ($org, $hintfile)=($subdir, ".dpwcddirhint");
        
  # hintfile?
  if (-e "$basedir/$subdir/$hintfile")
   {
    # read the hint
    open(F, "$basedir/$subdir/$hintfile") or die;
    $org=<F>;
    close(F);
   }

  # supply array
  [$subdir, $org];
 }

sub findImportableFile
 {
  # get and check parameters
  my ($dir, $basename)=@_;
  die "[BUG] Missing valid directory parameter" unless $dir;
  die "[BUG] Missing file basename parameter" unless $basename;
  
  # try all registered import filters if there is a file that we can import
  -e "$dir/$basename.$_" and return $_ for @ifilters;

  # flag that we found nothing
  '';
 }


sub checkFileInit {checkFileSet('INVALID', @_)}
sub checkFileOK   {checkFileSet('OK', @_)}

sub checkFileSet
 {
  # get and check parameters
  my ($status, $file)=@_;
  die "[BUG] Missing status parameter" unless $status;
  die "[BUG] Missing file parameter" unless $file;

  # get data, modify and save it
  $checkdata=retrieve($checkdataFile) if -e $checkdataFile;
  $checkdata->{$file}=[time, $status];
  nstore($checkdata, $checkdataFile);

  # make sure to supply an empty string
  "";
 }

sub checkFile
 {
  # get and check parameters
  my ($file)=@_;
  die "[BUG] Missing file parameter" unless $file;

  # in any case, flag that the file cannot be included if we are working in the
  # "include nothing" mode
  return 0 if $flags{frameonly};

  # please check what we know about this file, if necessary
  return 0 if     $flags{check}
              and exists $checkdata->{$file}
              and $checkdata->{$file}[0]>($^T-(-C $file)*60*60*24)
              and $checkdata->{$file}[1] eq 'INVALID';

  # all right
  1;
 }


\END_EMBED


// add module part (in an extra embedded part - because the result of the first part has to be parsed first)
\EMBED{lang=perl}

# start module chapters
$result="\n\n=Modules\n\n";

# replace the following by LOCALTOC - as soon as it supports bullets ...
if (%seenModules)
 {
  $result.=qq(\\CENTER_ON\n\n\\TABLE{separator="##########" border=0}\n);
  for (sort {lc($a) cmp lc($b)} keys %seenModules)
    {$result.=qq(\\SECTIONREF{name="Modules|$_"}\n);}
  # $result.="\\LOCALTOC{type=linked depth=1}\n\n";
  $result.="\\END_TABLE\n\n\\CENTER_OFF\n";
 }

my %modules=%seenModules;
undef %seenModules;

# generate a file with all module names
open(M, ">foundModuleNames.ctrl");
print M map {"$_\n"} sort keys %modules;
use Data::Dumper; print M Dumper(\%modules);
close(M);

foreach my $module (sort keys %modules)
 {
  # headline: module name
  $result.=qq(==$module\n\n\\XO<$module>\n\n);

  # add a link to the CPAN page
  $result.="\\CENTER<\\SMALL<\\CPAN_MODULE<$module>>>\n\n";

  # add talk links
  foreach my $workshop (sort keys %{$modules{$module}})
   {
    # skip the "Sponsors" page
    next if join('', keys %{$modules{$module}{$workshop}}) eq 'Sponsors';

    # open a new workshop section
    $result.=join('',
                  qq(\\INDENT<\\BU<\\XREF{name="),
                  $workshop eq $cdSettings{ppcdConferenceTitle} ? $cdSettings{ppcdIntroTitle} : $workshop,
                  qq("}<$workshop>>>\n\n),
                 );

    # add talk data, sorted by title
    foreach my $talk (sort grep(($_ ne 'Sponsors'), keys %{$modules{$module}{$workshop}}))
      {$result.=qq(* \\XREF{name="$modules{$module}{$workshop}{$talk}"}<$talk>\n\n);}
   }

 }


# finally, add an impressum, if requested
$result.=qq(\\INCLUDE{type=pp file="../$cdSettings{ppcdImpressum}"}) if (exists $cdSettings{ppcdImpressum} and $cdSettings{ppcdImpressum});

# provide result
$result;

\END_EMBED
