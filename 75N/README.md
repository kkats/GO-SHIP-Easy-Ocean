# 75N
## 1. Source
### 1994
+ [06AQ19940706](https://cchdo.ucsd.edu/cruise/06AQ19940706)

### 1995
+ [06AQ19950922](https://cchdo.ucsd.edu/cruise/06AQ19950922)

### 1997
+ [06AQ19970813](https://cchdo.ucsd.edu/cruise/06AQ19970813)

### 1998
+ [06AQ19980827](https://cchdo.ucsd.edu/cruise/06AQ19980827)

### 1999
+ [06AQ19990623](https://cchdo.ucsd.edu/cruise/06AQ19990623)

### 2000
+ [06AQ20000630](https://cchdo.ucsd.edu/cruise/06AQ20000630)

### 2001
+ [06AQ20010619](https://cchdo.ucsd.edu/cruise/06AQ20010619)

### 2006
+ [58GS20060721](https://cchdo.ucsd.edu/cruise/58GS20060721)

### 2016
+ [58GS20160802](https://cchdo.ucsd.edu/cruise/58GS20160802)

## 2. Glitches

JOA has a 75N file but in different locations in the Arctic Ocean.

### 1994

'666575_ct1.csv' has duplicate entries at depths 3991, 3992, and 3993 dbar. Hand editted.
'666585_ct1.csv' has duplicate entries at depths 3772, and  3773. Hand editted.
'098900_ct1.csv' has duplicate entries at a depth 3277 dbar. Hand editted.

### 1999

'666483_ct1.csv' has duplicate entries at a depth 3677 dbar. Hand editted.

### 2000
'126477_ct1.csv' has duplicate entries at a depth 3125 dbar. Hand editted.
'126450_ct1.csv' has duplicate entries at a depth 2747 dbar. Hand editted.
'126433_ct1.csv' has duplicate entries at depths 1021, 1022 dbar Hand editted.
'126432_ct1.csv' has duplicate entries at a depth 317 dbar Hand editted.

### 2001

'671939_ct1.csv' has duplicate entries at a depth 3481 dbar. Hand editted.
'671901_ct1.csv' has duplicate entries at a depth 1781 dbar. Hand editted.

### 1994, 1995, 1998, 1999, 2000, 2001
All have potential temperature raw in front of the pressure. Use `read_ctd_exchange_75N.m`.
DEPTH recorded as floating number, not integer, such that some `list` files are corrupted (but usable).

### 1997
Now potential temperature raw is gone. Use `read_ctd_exchange_1997.m`.
Salinity for `098925_ct1.csv` is spiky.

### 2006
No flag. Negative oxygen in `57GS20060721_00260`. Use `read_ctd_exchange_2006.m`. No depth, no SUM.
First data of `58GS20060721_00266_00001_ct1.csv` has bad values. Manually removed.
