# P16
## 1. Source
### (1980, not used)
+ [32NM19800810](https://cchdo.ucsd.edu/cruise/32NM19800810)

### (1984, not used)
+ [31WTMARAII](https://cchdo.ucsd.edu/cruise/31WTMARAII)

### 1992
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

## 2. Glitches
### 2006
#### `findJOAstations.m` used with `P16S_2005_2006_CTD.csv`
~~~
Warning: 1 station pairs did not match
Warning: 1 JOA    61-3     -45.9995    210.0015 2005-01-27 d=5198
Warning: 1 CCHDO  61-2     -45.9994    210.0020 2005-01-27 d=5134
~~~
According to the SUM file, 61-2 is a shallow cast only to 257 dbar.

### 2015
Some CTD file (e.g. `320620140320_00033_00001_ct1.csv`) shows a wrong DEPTH (e.g. = 3032 while SUM shows 4767 m).
Use SUM to use a depth file.

```
% awk '$8=="BO" {print $1, $3, $4, $16}' 320620140320su.txt > p16_2015.depth
```

Some depths are missing (e.g. Station 58). Edit `p16_2015.depth` manually by comparing the depths measured at `BE` or `EN`.
Also note that some `BE` or `EN` depths are abnormal (e.g. `EN` of Station 60).
