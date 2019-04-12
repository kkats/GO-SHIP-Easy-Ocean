#!/bin/sh
(cd ../output/gridded/A16-A23; gzip *xyz)
for year in 1988 1993 1995 2003 2011 2013;
do
    (cd ../output/reported/work; zip ../A16-A23/a16-a23_${year}_ct1.zip a16-a23_${year}_????_ct1.csv; rm -fr a16-a23_${year}_????_ct1.csv)
done
