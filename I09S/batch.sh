#!/bin/sh
DIR=I09S
name=i09s
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1995 2004 2012
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
