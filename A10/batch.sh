#!/bin/sh
(cd output/gridded/A10; gzip *xyz)
for year in 1992 2003 2009 2011;
do
    (cd output/reported/work; zip ../A10/a10_${year}_ct1.zip a10_${year}_????_ct1.csv; rm -fr a10_${year}_????_ct1.csv)
done
