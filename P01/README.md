# P01
## 1. Source

### 1985
+ [31TTTPS47](https://cchdo.ucsd.edu/cruise/31TTTPS47)

### 1999
+ [18DD199905_1](https://cchdo.ucsd.edu/cruise/18DD199905_1)
+ [49NZ199905_1](https://cchdo.ucsd.edu/cruise/49NZ199905_1)
+ [49NZ199909_2](https://cchdo.ucsd.edu/cruise/49NZ199909_2)
+ [49KA199905_2](https://cchdo.ucsd.edu/cruise/49KA199905_1)

### 2007
+ [49NZ20070724](https://cchdo.ucsd.edu/cruise/49NZ20070724)
+ [49NZ20071008](https://cchdo.ucsd.edu/cruise/49NZ20071008)

### 2014
+ [49NZ20140717](https://cchdo.ucsd.edu/cruise/49NZ20140717)

### 2021
+ [49NZ20210713](https://cchdo.ucsd.edu/cruise/49NZ20210713)


## 2. Glitches

### 1999
Some pressure data from `49NZ199901_1` (a.k.a. `49NZ199908_1`) have flag=1 (uncalibrated).
To include these data, edit `read_ctd_exchange.m` (c. line 160) and reprocess.

Many near-surface salinity spikes are found for `49KA199905_2`. Untouched.
