#!/bin/sh
DIR=SR01
name=sr01
PREFIX=/local/Shared/
(cd $PREFIX/output/gridded/$DIR; gzip *xyz)
for year in 1993 1994 1996 1997 2000 2001 2002 2003 2009a 2009b 2011 2015a 2015b 2016 2018 2021
do
    (cd $PREFIX/output/reported/work; zip ../$DIR/${name}_${year}_ct1.zip ${name}_${year}_????_ct1.csv; rm -fr ${name}_${year}_????_ct1.csv)
done
rm -f $PREFIX/output/reported/work/LOCK
