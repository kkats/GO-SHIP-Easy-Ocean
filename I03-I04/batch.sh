#!/bin/sh
DIR=I03-I04
name=i03-i04
PREFIX=/local/Shared
(cd $PREFIX/output/gridded/$DIR; gzip *xyz)
for year in 1995 2003
do
    (cd $PREFIX/output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
rm -f $PREFIX/output/reported/work/LOCK
