#!/bin/sh
DIR=AR07E
name=ar07e
PREFIX=/local/Shared
(cd $PREFIX/output/gridded/$DIR; gzip *xyz)
for year in 1990 1991a 1991b 1991c 1992 1994 1995 1996 1997 2000 2005 2014a 2014b 2015 2020
do
    (cd $PREFIX/output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
rm -f $PREFIX/output/reported/work/LOCK
