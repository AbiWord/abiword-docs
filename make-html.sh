#! /bin/sh

#  The AbiWord Document Merger
#
#  Copyright (C) 2002 Free Software Foundation.
#
#  make-html.sh is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  make-html.sh is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

CVS=`pwd -P`

export ABISUITE_HOME=/usr/local/share/AbiSuite

for help_language in en-US fr-FR
do

	for dir in ./ howto info interface problems tutorial plugins
	do
		cd ABW/$help_language/$dir
		for i in $(ls -1 *.abw)
		do
		      n=`echo $i|cut -f1 -d .`
		      echo $i
		      abiword --to=xhtml `basename $i`
		      $CVS/make-abidoc.pl -I $n.info -S header.xhtml -F footer.xhtml>$n.html
		      rm -f $n.xhtml
		done

		cd $CVS
	done

	cd $CVS/ABW/$help_language
	rm -rf $CVS/help/$help_language
	mkdir -p $CVS/help/$help_language
	cp -r */ $CVS/help/$help_language
	cp *.html $CVS/help/$help_language
	cp *.css $CVS/help/$help_language
	find $CVS/help -name CVS -exec rm -fr {} \;

	for i in $(ls -1d $CVS/help/$help_language/*/ )
	do
		rm -f $i/*.xhtml
		rm -f $i/*.info
		rm -f $i/*.abw
	done

	cd $CVS
done

