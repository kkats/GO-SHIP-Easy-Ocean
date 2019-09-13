#!/bin/sh
DIR=P04
name=p04
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1989
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
