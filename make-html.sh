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


for dir in ./ howto info interface problems tutorial

do
cd ABW/en-US/$dir

  for i in $(ls -1 *.abw)
    do
      n=`echo $i|cut -f1 -d .`
      echo $i
      abiword -to xhtml `basename $i`
      $CVS/make-abidoc.pl -I $n.info -S header.xhtml -F footer.xhtml>$n.html
      rm -f $n.xhtml
    done

cd $CVS

done


cd $CVS/ABW/en-US
rm -rf $CVS/help/en-US
mkdir $CVS/help/en-US
cp -r */ $CVS/help/en-US
cp *.html $CVS/help/en-US
cp *.css $CVS/help/en-US

for i in $(ls -1d $CVS/help/en-US/*/ )
do
rm -f $i/*.xhtml
rm -f $i/*.info
rm -f $i/*.abw
done
