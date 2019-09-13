#!/bin/sh
DIR=P18
name=p18
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1994 2007 2016
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
