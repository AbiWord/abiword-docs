
SUBDIRS = \
	howto \
	info \
	interface \
	plugins \
	problems \
	tutorial

helpdir = $(ABIWORD_EXTRAS_PKGDATADIR)/help/pl-PL

cssdir = $(helpdir)
css_DATA = \
	histyle.css \
	style.css

include $(top_srcdir)/make-html.mk

EXTRA_DIST += \
	$(css_DATA)
