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

for help_language in en-US fr-FR pl-PL #de-DE
do

	for dir in ./ howto info interface problems tutorial plugins
	do
		cd ABW/$help_language/$dir
		for i in $(ls -1 *.abw)
		do
		      n=`echo $i|cut -f1 -d .`
		      echo $i

		      # save to docbook, rename to .xml
		      AbiWord-2.0 --to=dbk `basename $i` 2>/dev/null
		      mv $n.dbk $n.xml
		done

		cd $CVS
	done

	gnome_help_language=`echo $help_language|cut -f1 -d -`

	cd $CVS/ABW/$help_language
	rm -rf $CVS/help/$gnome_help_language
	mkdir -p $CVS/help/$gnome_help_language
	cp -r */ $CVS/help/$gnome_help_language
	cp *.xml $CVS/help/$gnome_help_language
	#find $CVS/help -name CVS -exec rm -fr {} \;

	for i in $(ls -1d $CVS/help/$gnome_help_language/*/ )
	do
		rm -f $i/*.info
		rm -f $i/*.xhtml
		rm -f $i/*.abw
	done

	cd $CVS
done

# move english help to "C"
mv $CVS/help/en $CVS/help/C

