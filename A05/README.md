# A05
## 1. Source
### 1992
+ [29HE06_1](https://cchdo.ucsd.edu/cruise/29HE06_1)

### 1998
+ [31RBOACES24N_2](https://cchdo.ucsd.edu/cruise/31RBOACES24N_2)

### 2004
+ [74DI20040404](https://cchdo.ucsd.edu/cruise/74DI20040404)

### 2010
+ [74DI20100106](https://cchdo.ucsd.edu/cruise/74DI20100106)

### 2011
+ [29AH20110128](https://cchdo.ucsd.edu/cruise/29AH20110128)

### 2015
+ [74EQ20151206](https://cchdo.ucsd.edu/cruise/74EQ20151206)

### 2020
+ [740H20200119](https://cchdo.ucsd.edu/cruise/740H20200119)

## 2. Glitches

No Atlas station data available.



### 1998
We need a depth file for 1998, produced from the SUM file. Note station 6, 29 do not
have depth and need to hand edit `a05_1998.depth` to remove these 2 lines.
```
% cat ar01_asu.txt| grep ROS | grep BE | awk '{print $1, $3, $4, $16}' > a05_1998.depth
```

### 2011
No SUM file for 2011.

The columns are in the order of "pressure, oxygen, temperaure, salinity", instead of
regular "pressure, temperature, salinity, oxygen". Use `read_ctd_exchange_2011.m`.

`29AH20110128_00006_00001_ct1.csv` shows an unusual gap in all quantities between 566 and 570 dbar. We removed data below 568 dbar.

### 2020
No SUM file as of 26 Jan 2021.

### 2022
[74EQ20220209](https://cchdo.ucsd.edu/cruise/74EQ20220209) occupied only a segment of about 3 degree longitude length and not included in the product.
