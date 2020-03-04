#!/bin/sh
DIR=A13
name=a13
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1983 2010
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
