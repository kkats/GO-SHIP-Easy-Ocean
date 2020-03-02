#!/bin/sh
DIR=IR06-I10
name=ir06-i10
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1995a 1995b 1995 2000 2015
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
