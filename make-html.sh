#! /bin/bash
CVS=/home/cal/abiword/abiword-docs

for i in $(ls -1 *.abw);do abiword -to xhtml $i; done

for i in $(ls -1 *.info);
 do $CVS/make-abidoc.pl -I $i -S header.xhtml -F footer.xhtml>`n=$i && echo $n|cut -f1 -d .`.html;
 done

echo "DONE WITH TOP...#######################################"

# for dir in how-to info interface problems tutorial;
for dir in tutorial info problems ;
do
cd $dir
echo `pwd`
    for i in $(ls -1 *.abw);
    do
     abiword -to xhtml `basename $i`;
    done

    for i in $(ls -1 *.info);
     do $CVS/make-abidoc.pl -I $i -S header.xhtml -F footer.xhtml>`n=$i && echo $n|cut -f1 -d .`.html;
     done
cd ..;
done
