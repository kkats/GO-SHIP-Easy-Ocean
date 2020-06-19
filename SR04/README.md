# SR04
## 1. Source

### 1989
+ [06AQANTVIII_2](https://cchdo.ucsd.edu/cruise/06AQANTVIII_2)

### 1990
+ [06AQANTIX_2](https://cchdo.ucsd.edu/cruise/06AQANTIX_2)

### 1992b
+ [06AQANTX_7](https://cchdo.ucsd.edu/cruise/06AQANTX_7)

### 1996
+ [06AQANTXIII_4](https://cchdo.ucsd.edu/cruise/06AQANTXIII_4)

### 1998
+ [06AQANTXV_4](https://cchdo.ucsd.edu/cruise/06AQANTXV_4)

### 2005
+ [06AQ20050122](https://cchdo.ucsd.edu/cruise/06AQ20050122)

### 2008
+ [06AQ20080210](https://cchdo.ucsd.edu/cruise/06AQ20080210)

### 2010
+ [06AQ20101128](https://cchdo.ucsd.edu/cruise/06AQ20101128)


## 2. Glitches

[06AQANTX_4](https://cchdo.ucsd.edu/cruise/06AQANTX_4) was not used as only less than
10 stations overlap with other occupations.

### 1992
This is `D_ctd(5)` in the Purkey's Matlab output.

The file `070764_ct1.csv` is broken. Not used (not on the section anyway).

The files in the exchange format have columns in an unusual order, i.e.,
`THETA,CTDPRS,CTDTMP,CTDSAL,CTDNOBS` and lack flags. Use `read_ctd_exchange_1992.m`.

### 1996
JOA file 'S04A_1996_decimated_CTD.joa' gives more flags than 'S04A_1996_clean_bottle.joa'.
Use the former.

Missing depths. Use topo file
```
awk '$8=="BE" {print $1, $3, $4, $16}' s04asu.txt > sr04_1996.depth
```

### 1998
`sr04_3_00002_ct1.csv` says its year is in 1999 -- probaly a typo of 1998
(or April Fool's Day?). The unit line has excessive commas and confuses
`read_ctd_exchange.m`. Use `read_ctd_exchange_1998.m`.

### 2005
This is `D_ctd(6)` in the Purkey's Matlab output.

The data do not have flags. We assume all data are good and use `read_ctd_exchange_2005.m`.
We also assume their salinity unit 'PSU' is 'PSS_78'.

### 2008

Exactly the same problem with year 2005. Use the same patch.

### 2010
Beware of the unit of oxygen (umol/L).

The files in the exchange format lack flags, i.e., the columns are
`CTDPRS,CTDTMP,CTDSAL,CTDOXY,FLOURM,XMISS,CTDNOBS`. Use `read_ctd_exchange_2010.m`.
