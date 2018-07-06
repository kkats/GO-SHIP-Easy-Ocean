#!/bin/sh
DIR=I08S-I09N
name=i08s-i09n
(cd output/gridded/$DIR; gzip *xyz)
for year in 1995 2007 2016
do
    (cd output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
