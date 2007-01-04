
EXTRA_DIST = \
	ABW \
	\
	autogen.sh \
	make-abidoc.pl \
	make-html.sh

all-am:
	ABI_DOC_SOURCE=`pwd`/$(srcdir) ABI_DOC_SOURCE=. $(srcdir)/make-html.sh

dist-hook:
	rm -rf `find $(distdir)/ABW -name CVS`
