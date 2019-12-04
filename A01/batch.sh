#!/bin/sh
DIR=A01
name=a01
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1990 1991 1992 1994 1996 1997 2014
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
