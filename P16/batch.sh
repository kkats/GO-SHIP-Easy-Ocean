#!/bin/sh
DIR=P16
name=p16
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1992 2006 2015
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
