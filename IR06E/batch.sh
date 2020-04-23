#!/bin/sh
DIR=IR06E
name=ir06e
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1989 1992 2000
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
