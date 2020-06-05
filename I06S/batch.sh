#!/bin/sh
DIR=I06S
name=i06s
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1993 1996 2008 2019
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
