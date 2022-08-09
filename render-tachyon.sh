#!/bin/bash
set -e
set -o pipefail
shopt -s globstar

args=("$@")

n=0

for ((n=0; n<$#; ++n));
do
   file=${args[$n]}
   if [ ! -f $file ]; then
      continue
   fi

   echo $file
   basefile=`basename $file .dat`
   sed -i 's/Resolution.*/Resolution 7664 4164/' $file
   tachyon  -aasamples 12 $file -format TARGA -o ${basefile}.tga
   #tga2png.sh ${basefile}.tga
   convert -trim ${basefile}.tga ${basefile}.png
   rm ${basefile}.tga
done
