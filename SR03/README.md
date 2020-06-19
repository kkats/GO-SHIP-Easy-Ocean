# SR03
## 1. Source

### 1991
+ [09AR9101_1](https://cchdo.ucsd.edu/cruise/09AR9101_1)

### 1993
+ [09AR9309_1](https://cchdo.ucsd.edu/cruise/09AR9309_1)

### 1994a
+ [09AR9404_1](https://cchdo.ucsd.edu/cruise/09AR9404_1)

### 1994b
+ [09AR9407_1](https://cchdo.ucsd.edu/cruise/09AR9407_1)

### 1995
+ [09AR9501_1](https://cchdo.ucsd.edu/cruise/09AR9501_1)

### 1996
+ [09AR9601_1](https://cchdo.ucsd.edu/cruise/09AR9601_1)

###  2001
+ [09AR20011029](https://cchdo.ucsd.edu/cruise/09AR20011029)

###  2008
+ [09AR20080322](https://cchdo.ucsd.edu/cruise/20080322)

###  2011
+ [09AR20080104](https://cchdo.ucsd.edu/cruise/20110104)

## 2. Glitches

### 1991
Missing depths. Use topo file;
```
% awk '$8=="BO" {print $1, $3, $4, substr($0,85,6)}' sr03_asu.txt > sr03_1991.depth
```
which requires a few manual edits (mostly to use BE depth).

### 1993
Missing depths. Use topo file;
```
% awk '$8=="BO" {print $1, $3, $4, substr($0,85,6)}' sr03_bsu.txt > sr03_1993.depth
```
which still requires lots of manual edits.


### 1994a and 1995

JOA files `SR03_1995_clean_bottle.jos` and `SR03_1995_decimated_CTD.jos` correspond
to our 1994a. Both yield the same flagJ.

### 2001

`SR03_2001_decimated_CTD.jos` gives more near-by stations that `SR03_1995_clean_bottle.jos`.

Standard seawater used on stations 10--13 was documted as "P133 and P137". We treat these stations as "unknown SSW". The same for stations 31--36.

Salinity and oxygen have wrong units ('C' and 'PSS-78', respectively). Use this `reported_data_2001.m`.
