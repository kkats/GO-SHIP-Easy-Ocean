#!/bin/sh
(cd output/gridded/I05; gzip *xyz)
for year in 1987 2002 2009
do
    (cd output/reported/work; zip ../I05/i05_${year}_ct1.zip i05_${year}_????_ct1.csv; rm -fr i05_${year}_????_ct1.csv)
done
