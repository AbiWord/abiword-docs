
LANGUAGES = \
	en-US \
	fr-FR \
	pl-PL

MODULES = \
	. \
	howto \
	info \
	interface \
	plugins \
	problems \
	tutorial

html_export_options = "html4: no; use-awml: no; embed-css: yes; embed-images:yes"

helpdir = $(ABIWORD_EXTRAS_PKGDATADIR)/help

EXTRA_DIST = $(LANGUAGES)

CLEANFILES = doc-stamp

all-local: doc-stamp

install-hook: 
	for f in `find . -name '*.html *.css'`; do	\
		echo "installing $$f";			\
	done

doc-stamp:
	for lang in $(LANGUAGES); do							\
		for module in $(MODULES); do						\
			trgdir="./$$lang/$$module";					\
			echo "creating '$$trgdir' ...";					\
			mkdir -p "$$trgdir";						\
			for src in `ls -1 $(srcdir)/$$lang/$$module/*.abw`; do		\
				trg="$$trgdir/`basename $$src .abw`";			\
				abiword --to=html --to-name='fd://1' --exp-props=$(html_export_options) 'fd://0' < "$$src" > "$$trg.html"; \
				info=`echo "$$src" | sed -e "s|.abw|.info|g"`;		\
				header=`dirname "$$src"`/header.xhtml;			\
				footer=`dirname "$$src"`/footer.xhtml;			\
				$(top_srcdir)/make-abidoc.pl -B "$$trg.html" -I "$$info" -S "$$header" -F "$$footer" > "$$trg.html.tmp" && \
				mv "$$trg.html.tmp" "$$trg.html";			\
			done								\
		done;									\
		cp $(srcdir)/$$lang/*.css "./$$lang/";					\
	done;										\
	touch $@

dist-hook:
	for lang in $(LANGUAGES); do				\
		rm -rf `find $(distdir)/$$lang -name CVS`;	\
	done
