#!/bin/bash

# collate a sgml book together, setup for dynebolic manual
# GNU GPL v3 - jrml, dec 2008

# get which language we're compiling
lang=$1

# list all chapter entities for the selected translation
entities=`ls $lang/*.sgml| grep -v 'dynebolic-manual'| grep -v 'authors.sgml'`

# set the known chapters and their order
ordered="
intro
system
install
video
audio
image
text
network
console
devel
"


#initialise output file
out=$lang/dynebolic-manual-$lang.sgml
rm -f $out

cat <<EOF > $out
<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"
[
EOF


# collate the chapters

for ch in $entities; do
    ent="`echo $ch|cut -d. -f1|cut -d/ -f2`"
    echo "<!ENTITY $ent SYSTEM \"$ent.sgml\">" >> $out
done

# at last the index
echo "<!ENTITY index SYSTEM \"index.sgml\">" >> $out

echo "]>" >> $out

cat $lang/authors.sgml >> $out

for ch in $ordered; do
    if [ -r $lang/$ch.sgml ]; then
	echo "Including chapter $ch ($lang)"
	echo "&$ch;" >> $out
    fi
done

# at last the index
echo "&index;" >> $out

echo "</book>" >> $out
