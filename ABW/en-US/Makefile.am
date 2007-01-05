
SUBDIRS = \
	howto \
	info \
	interface \
	plugins \
	problems \
	tutorial

helpdir = $(ABIWORD_EXTRAS_PKGDATADIR)/help/en-US

cssdir = $(helpdir)
css_DATA = \
	histyle.css \
	style.css

include $(top_srcdir)/make-html.mk

EXTRA_DIST += \
	$(css_DATA) \
	template

dist-hook:
	rm -rf `find $(distdir)/template -name CVS`
