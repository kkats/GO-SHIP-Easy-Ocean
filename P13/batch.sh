#!/bin/sh
DIR=P13
name=p13
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1991 1992 2011
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
