
docsrc := $(wildcard $(srcdir)/*.abw)
doctrg_ := $(patsubst $(srcdir)/%, ./%, $(docsrc))
doctrg := $(doctrg_:.abw=.html)

# $(helpdir) must be in where this file is included
help_DATA = \
	$(doctrg)

EXTRA_DIST = \
	$(docsrc) \
	$(wildcard $(srcdir)/*.info) \
	header.xhtml \
	footer.xhtml

CLEANFILES = \
	$(doctrg)

html_export_options = "html4: no; use-awml: no; embed-css: yes; embed-images:yes"

%.html: %.abw
	$(ABIWORD) --to=html --to-name="$@" --exp-props=$(html_export_options) "$^"
	info=`echo "$^" | sed -e "s|.abw|.info|g"` && \
	$(top_srcdir)/make-abidoc.pl -B "$@" -I "$$info" -S $(srcdir)/header.xhtml -F $(srcdir)/footer.xhtml > "$@.tmp" && \
	mv "$@.tmp" "$@"
