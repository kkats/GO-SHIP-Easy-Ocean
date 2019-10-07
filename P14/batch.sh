#!/bin/sh
DIR=P14
name=p14
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1992 2007
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
