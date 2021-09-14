# A22
## 1. Source

### 1997
+ [316N151_4](https://cchdo.ucsd.edu/cruise/316N151_4)

### 2003
+ [316N200310](https://cchdo.ucsd.edu/cruise/316N200310)

### 2012
+ [33AT20120324](https://cchdo.ucsd.edu/cruise/33AT20120324)

### 2021
+ [325020210420](https://cchdo.ucsd.edu/cruise/325020210420)

## 2. Glitches

### 1997

No depth data. Use SUM file;
```
awk '/ROS/ && /BE/ {print $1, $3, $4, $16}' a22su.txt > a22_1997.depth
```

- `a22_00007_00001_ct1.csv`: Salinity is spiky below 2500 dbar.
- `a22_00035_00001_ct1.csv`: Temperature and salinity spike around 2612 dbar. We do not have
any clue to call these values as erroneous/spurious, we leave them antouched.

### 2021
The pressure flag column does not exist in the CTD exchange files. Use `read_ctd_exchange_2021.m`.

The cruise document dated 16 Aug 2021 indicates the IAPSO Standard SeaWater batch
number of P-166, which is a typography of P-164 (confirmed by the PI through
personal communication).
