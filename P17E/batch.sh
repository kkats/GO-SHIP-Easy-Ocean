#!/bin/sh
DIR=P17E
name=p17e
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1992 2017
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
