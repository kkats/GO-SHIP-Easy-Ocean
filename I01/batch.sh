#!/bin/sh
DIR=I01
name=i01
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1995a 1995b
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
