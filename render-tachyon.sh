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
   path=`dirname $file`
   sed -i 's/Resolution.*/Resolution 7664 4164/' ${file}
   tachyon  -aasamples 12 ${file} -format TARGA -o ${path}/${basefile}.tga
   #tga2png.sh ${basefile}.tga
   convert -trim ${path}/${basefile}.tga ${path}/${basefile}.png
   rm ${path}/${basefile}.tga
done
