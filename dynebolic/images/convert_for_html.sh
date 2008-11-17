#!/bin/sh

mkdir -p html/images

for i in `ls images/*.png`; do
  file="`basename $i | cut -d. -f1`"
  echo "converting $file to jpeg"
  convert $i "html/images/${file}"
done

echo "images prepared in html/images"
