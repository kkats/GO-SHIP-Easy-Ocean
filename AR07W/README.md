# AR07W, A01W
## 1. Source
### 1990
+ [18DA90012_1](https://cchdo.ucsd.edu/cruise/18DA90012_1)

### 1992
+ [18HU92014_1](https://cchdo.ucsd.edu/cruise/18HU92014_1)

### 1993
+ [18HU93019_1](https://cchdo.ucsd.edu/cruise/18HU93019_1)

### 1994
+ [06MT30_3](https://cchdo.ucsd.edu/cruise/06MT30_3)
+ [18HU94008_1](https://cchdo.ucsd.edu/cruise/18HU94008_1)

### 1995
+ [18HU95011_1](https://cchdo.ucsd.edu/cruise/18HU95011_1)

### 1996
+ [18HU96006_1](https://cchdo.ucsd.edu/cruise/18HU96006_1)

### 1997
+ [18HU97009_1](https://cchdo.ucsd.edu/cruise/18HU97009_1)

### 1998
+ [18HU98023_1](https://cchdo.ucsd.edu/cruise/18HU98023_1)

### 2011b
+ [06MT20110624](https://cchdo.ucsd.edu/cruise/06MT20110624)

### 2012
+ [18MF20120601](https://cchdo.ucsd.edu/cruise/18MF20120601)

### 2013a
+ [18HU20130507](https://cchdo.ucsd.edu/cruise/18HU20130507)

### 2013b
+ [06M220130509](https://cchdo.ucsd.edu/cruise/06M220130509)

## 2. Glitches

Atlas data are not found online.

The 2007 cruise [64PE20070830](https://cchdo.ucsd.edu/cruise/64PE20070830)
covered western several stations of A01E but diverts in the central and eastern
parts and thus not considered here as reoccupation.

A 1994 CTD file `ar07w_e_00046_00001_ct1.csv` has duplicate data at CTDPRS=302.
```
    300.0,2,   3.6904,2,  34.8795,2,    294.3,2
    302.0,2,   3.6882,2,  34.8797,2,    294.5,2
    302.0,2,   3.6887,2,  34.8790,2,    295.1,2
    304.0,2,   3.6881,2,  34.8794,2,    294.6,2
```
The second line was manually removed. Similarly a 1996 CTD file `ar07w_f_00048_00003_ct1.csv`
has 2 data for CTDPRS=140.

## 3. Uncalibrated data

The data listed at the end have FLAG=1 (["NOT CALIBRATED"](https://exchange-format.readthedocs.io/en/v1.0.1/quality.html)). It is possible to include these data by applying the following patch to `read_ctd_exchange.m`,
but you should know what you are doing.

~~~
*** read_ctd_exchange.m 2021-01-20 16:30:20.108766833 +0900
--- AR07W/read_ctd_exchange_FLAG1.m     2021-01-26 16:34:01.644763959 +0900
***************
*** 161,171 ****
  ox(ox < -100) = NaN;

  % QC flag
! % retain only flag==2
! pr(pr_flg ~= 2) = NaN;
! te(te_flg ~= 2) = NaN;
! sa(sa_flg ~= 2) = NaN;
! ox(ox_flg ~= 2) = NaN;

  % sort in time
  for i = 1:length(stations)
--- 161,171 ----
  ox(ox < -100) = NaN;

  % QC flag
! % retain only flag==2 and flag==1
! pr(pr_flg ~= 2 & pr_flg ~= 1) = NaN;
! te(te_flg ~= 2 & te_flg ~= 1) = NaN;
! sa(sa_flg ~= 2 & sa_flg ~= 1) = NaN;
! ox(ox_flg ~= 2 & ox_flg ~= 1) = NaN;

  % sort in time
  for i = 1:length(stations)
~~~
+ [18HU19990627](https://cchdo.ucsd.edu/cruise/18HU19990627)
+ [18HU20010530](https://cchdo.ucsd.edu/cruise/18HU20010530)
+ [18HU20020623](https://cchdo.ucsd.edu/cruise/18HU20020623)
+ [18HU20021129](https://cchdo.ucsd.edu/cruise/18HU20021129)
+ [18HU20030713](https://cchdo.ucsd.edu/cruise/18HU20030713)
+ [18HU20040515](https://cchdo.ucsd.edu/cruise/18HU20040515)
+ [18HU20050526](https://cchdo.ucsd.edu/cruise/18HU20050526)
+ [18HU20060524](https://cchdo.ucsd.edu/cruise/18HU20060524)
+ [18HU20070510](https://cchdo.ucsd.edu/cruise/18HU20070510)
+ [18HU20080520](https://cchdo.ucsd.edu/cruise/18HU20080520)
+ [18HU20090517](https://cchdo.ucsd.edu/cruise/18HU20090517)
+ [18HU20100513](https://cchdo.ucsd.edu/cruise/18HU20100513)
+ [18HU20110506](https://cchdo.ucsd.edu/cruise/18HU2011a0506)
