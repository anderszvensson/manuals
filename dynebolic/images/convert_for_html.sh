#!/bin/sh

lang=$1
target=$2

case $target in
    html)
	outdir="$lang/html/images"
	;;
    pdf)
	outdir="$lang/images"
	;;
    *)
	echo "ERROR in image/convert.sh - must specify a target, i.e: convert.sh EN html"
	exit 0
	;;
esac
	
mkdir -p $outdir

for i in `ls images/*.png`; do
  file="`basename $i | cut -d. -f1`"
  echo "converting $file to jpeg"
  convert $i "$outdir/${file}"
done

echo "images prepared in $outdir"