
# how to call perl
PERL=perl

# declare directory macros
PPCD=PerlPointCD
PREPARE=prepare
BUILD=build
IMPORTFILTERDIR=${PPCD}/ifilters
STYLES=${PREPARE}/styles
DEFAULTS=${PREPARE}/defaults
IMAGESRCDIR=${BUILD}/images
IMAGEREFDIR=images
DATA=${BUILD}/data

# conference and project data
CONFERENCE=Demo Workshop
PROJECT=demo-cd
TITLE=PerlPointCD
TOCTITLE=TOC
CDAUTHORMAIL=cd@conference.org
CDDESCRIPTION=PerlPointCD Demo
CDINITIALURL=/index.html
CDSTARTURL=http://www.perl-workshop.de

# import order, talk style order
IMPORTORDER=pod
TALKSTYLEORDER=${PREPARE}/talkStyleOrder.cfg

# PerlPoint init file (comment this out in case you do not want to use own team macros)
INITFILE=${PREPARE}/macros.pp

# intro settings
INTROTITLE=Welcome to the demo CD
INTROFILE=${PREPARE}/welcome.pp

# impressum (comment this out if there is no impressum/postambel)
IMPRESSUM=${PREPARE}/impressum.pp

# default language (falls back to "en")
# DEFAULT_LANGUAGE=de

# trace settings - modify TRACE if in need of tracing
TRACE=0

# check logfile and datafile
CHECKLOG=ppcd.log
CHECKDATA=$(PPCD)/.checkdata.ppcd

# configure index based relation search (defaults to full relation depth, full
# read depth and a threshold of 20%, to modify these values activate the
# following lines and adapt them)
#INDEXREL_RELDEPTH=full
#INDEXREL_READDEPTH=full
#INDEXREL_THRESHOLD=20%

# build option string
OPTIONS=-trace ${TRACE} \
        -title "${TITLE}" \
        -contents_header "${TOCTITLE}" \
        -style_dir ${STYLES} -target_dir ${BUILD} \
        -image_dir ${IMAGESRCDIR} -image_ref ${IMAGEREFDIR} \
        -author "${CDAUTHORMAIL}" \
        -description "${CDDESCRIPTION}" \
        -bootstrapaddress "${CDINITIALURL}" \
        -startaddress "${CDSTARTURL}" \
	-set ppcdImportFilterDir="${IMPORTFILTERDIR}" \
	-set ppcdImportOrder="${IMPORTORDER}" \
        -set ppcdConferenceTitle="${CONFERENCE}" \
        -set ppcdWelcome=${INTROFILE} \
        -set ppcdIntroTitle="${INTROTITLE}" \
        -set ppcdDefaultLanguage=${DEFAULT_LANGUAGE} \
        -set ppcdTalkStyleOrder=${TALKSTYLEORDER} \
        -set ppcdImpressum=${IMPRESSUM} \
        -set ppcdDataDir=${DATA} \
        -set ppcdDefaultsDir=${DEFAULTS} \
        -set ppcdIndexrelRelDepth=${INDEXREL_RELDEPTH} \
        -set ppcdIndexrelReadDepth=${INDEXREL_READDEPTH} \
        -set ppcdIndexrelThreshold=${INDEXREL_THRESHOLD} \
        -set ppcdCheckData=${CHECKDATA}

SDFOPTIONS=-trace ${TRACE} \
	-set ppcdImportFilterDir="${IMPORTFILTERDIR}" \
	-set ppcdImportOrder="${IMPORTORDER}" \
        -set ppcdConferenceTitle="${CONFERENCE}" \
        -set ppcdWelcome=${INTROFILE} \
        -set ppcdIntroTitle="${INTROTITLE}" \
        -set ppcdDefaultLanguage=${DEFAULT_LANGUAGE} \
        -set ppcdTalkStyleOrder=${TALKSTYLEORDER} \
        -set ppcdImpressum=${IMPRESSUM} \
        -set ppcdDataDir=${DATA} \
        -set ppcdDefaultsDir=${DEFAULTS} \
        -set ppcdIndexrelRelDepth=${INDEXREL_RELDEPTH} \
        -set ppcdIndexrelReadDepth=${INDEXREL_READDEPTH} \
        -set ppcdIndexrelThreshold=${INDEXREL_THRESHOLD} \
        -set ppcdCheckData=${CHECKDATA}


# produce HTML (long directory names, no error check)
html: explode
	# test new tool
	# pp2tdo -target SDF -sdffile pp2tdo.sdf -style_dir ${STYLES} -style demo-cd @${PREPARE}/${PROJECT}-sdf.cfg ${SDFOPTIONS} ${INITFILE} ${PPCD}/${PROJECT}.pp
	# pp2sdf -sdffile pp2sdf.sdf @${PREPARE}/${PROJECT}-sdf.cfg ${SDFOPTIONS} ${INITFILE} ${PPCD}/${PROJECT}.pp
	# design 1
	${PPCD}/pp2html @${PREPARE}/${PROJECT}.cfg ${OPTIONS} -validate ${INITFILE} ${PPCD}/${PROJECT}.pp
	# design 2
	${PPCD}/pp2html @${PREPARE}/${PROJECT}-css.cfg ${OPTIONS} -validate ${INITFILE} ${PPCD}/${PROJECT}.pp


# produce HTML (long directory names, error check)
safely: explode
	# make sure the frame is valid, use any design (if this succeeds, the following loop should terminate)
	${PPCD}/pp2html -critical_semantics @${PREPARE}/${PROJECT}.cfg ${OPTIONS} -validate -set ppcdCheck -set ppcdFrameOnly ${INITFILE} ${PPCD}/${PROJECT}.pp
	# design 1 (only the first design needs to be looped)
	${PERL} ${PPCD}/ppcdCheckLoop ${CHECKLOG} ${CHECKDATA} ${PPCD}/pp2html -critical_semantics @${PREPARE}/${PROJECT}.cfg ${OPTIONS} -validate -set ppcdCheck ${INITFILE} ${PPCD}/${PROJECT}.pp
	# design 2
	${PPCD}/pp2html -critical_semantics @${PREPARE}/${PROJECT}-css.cfg ${OPTIONS} -validate -set ppcdCheck ${INITFILE} ${PPCD}/${PROJECT}.pp


# make a cd - this is similar to the "html" target but deactivates validation and implodes
# the directory tree
cd: implode
	# design 1
	${PPCD}/pp2html @${PREPARE}/${PROJECT}.cfg ${INITFILE} ${OPTIONS} ${PPCD}/${PROJECT}.pp
	# design 2
	${PPCD}/pp2html @${PREPARE}/${PROJECT}-css.cfg ${OPTIONS} ${INITFILE} ${PPCD}/${PROJECT}.pp

explode:
        # explode tree, if necessary
	-${PERL} ${PPCD}/ppcdImplode ${DATA}

implode:
        # implode tree, if necessary
	-${PERL} ${PPCD}/ppcdImplode ${DATA} 1




