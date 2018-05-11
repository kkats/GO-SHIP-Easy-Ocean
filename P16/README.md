# P16
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 7 occupations.
### 1980
+ [32NM19800810](https://cchdo.ucsd.edu/cruise/32NM19800810)

### 1984
+ [31WTMARAII](https://cchdo.ucsd.edu/cruise/31WTMARAII)

### 1991
+ [316N138_9](https://cchdo.ucsd.edu/cruise/316N138_9)
+ [31DSCGC91_1](https://cchdo.ucsd.edu/cruise/31DSCGC91_1)
+ [31WTTUNES_2](https://cchdo.ucsd.edu/cruise/31WTTUNES_2)
+ [31WTTUNES_3](https://cchdo.ucsd.edu/cruise/31WTTUNES_3)

### 2005-2006
+ [325020060213](https://cchdo.ucsd.edu/cruise/325020060213)
+ [33RR20050106](https://cchdo.ucsd.edu/cruise/33RR200501)

### (2008, not used)
+ [325020080826](https://cchdo.ucsd.edu/cruise/325020080826)

### 2014
+ [320620140320](https://cchdo.ucsd.edu/cruise/320620140320)

### 2015
+ [33RO20150410](https://cchdo.ucsd.edu/cruise/33RO20150410)
+ [33RO20150525](https://cchdo.ucsd.edu/cruise/33RO20150525)

# 2. Glitches
## 2006
### `findJOAstations.m` used with `P16S_2005_2006_CTD.csv`
1. Not match
~~~
Warning: 1 station pairs did not match
Warning: 1 JOA    61-3     -45.9995    210.0015 2005-01-27 d=5198
Warning: 1 CCHDO  61-2     -45.9994    210.0020 2005-01-27 d=5134
~~~
According to the SUM file, 61-2 is a shallow cast only to 257 dbar.

## 2015
Salinity offset
