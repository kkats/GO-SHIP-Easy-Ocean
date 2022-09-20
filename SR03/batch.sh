#!/bin/sh
DIR=SR03
name=sr03
PREFIX=/local/data/CTD
(cd $PREFIX/output/gridded/$DIR; gzip *xyz)
for year in 1991 1993 1994a 1994b 1995 1996 2001 2008 2011 2018
do
    (cd $PREFIX/output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
rm -f $PREFIX/output/reported/work/LOCK
