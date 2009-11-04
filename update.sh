#!/bin/sh

if [ $# != 1 ]; then
        echo "Usage: $0 VERSIOIN"
        echo " e.g.: $0 1.1.0"
fi

version=$1
tar_gz=cutter-$version.tar.gz

curl -o $tar_gz -L http://downloads.sourceforge.net/cutter/$tar_gz

for type in md5 sha1 rmd160; do
        openssl dgst -$type $tar_gz | cut -f 2 -d ' '
done
