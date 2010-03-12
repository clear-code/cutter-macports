#!/bin/sh

if [ $# != 1 ]; then
        echo "Usage: $0 VERSIOIN"
        echo " e.g.: $0 1.1.0"
        exit 1
fi

cd $(dirname $0)

version=$1
tar_gz=cutter-$version.tar.gz
portfile=devel/cutter/Portfile

sed -E -i'' -e "s/^(version +)[a-z0-9.\-]+/\1$version/" $portfile

curl -o $tar_gz -L http://downloads.sourceforge.net/cutter/$tar_gz

for type in md5 sha1 rmd160; do
        hash=$(openssl dgst -$type $tar_gz | cut -f 2 -d ' ')
        sed -E -i'' -e "s/($type +)[a-z0-9]+/\1$hash/" $portfile
done

portindex

rm $tar_gz
