#!/bin/sh
DIR=I05
name=i05
(cd ../output/gridded/$DIR; gzip *xyz)
for year in 1987 1995 2002 2009
do
    (cd ../output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
