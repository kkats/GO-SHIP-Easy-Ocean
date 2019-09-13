#!/bin/sh
DIR=P02
name=p02
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1993 2004 2013
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
