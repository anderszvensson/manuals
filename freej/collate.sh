#!/bin/bash

# collate a sgml book together, setup for freej manual
# GNU GPL v3 - jrml, dec 2008

# get which language we're compiling
lang=$1

if ! [ -x $lang ]; then
    echo "There is no translation of this manual in [$lang]"
    exit 1
fi

name=freej-manual


# collate the example scripts for language bindings

for l in ruby python; do
    rm -f $lang/$l.sgml
    cat $lang/${l}_intro.sgml > $lang/$l.sgml
    cat $lang/examples.sgml | awk -v lang=$l '
BEGIN   { tmpl = 0 }
/^%/    { print "<screen>"
          split($1, file, "%");
          cmd = sprintf("cat %s/%s.src", lang, file[2]); 
          system(cmd)
          print "</screen>"
          tmpl = 1 }
        { if(tmpl==0) print $0
          else tmpl = 0 }
'                     >> "$lang/$l.sgml"
    echo "</chapter>" >> "$lang/$l.sgml"
done


# list all chapter entities for the selected translation
entities=`ls $lang/*.sgml| grep -v '$(name)'| grep -v 'authors.sgml' | grep -v '_intro.sgml$'`

# set the known chapters and their order
ordered="
intro
install
veejay
javascript
stream
python
ruby
devel
"


#initialise output file
out=$lang/$name-$lang.sgml
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
