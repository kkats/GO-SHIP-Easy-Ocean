# I06S
## 1. Source

### 1993
+ [35MFCIVA_1](https://cchdo.ucsd.edu/cruise/35MFCIVA_1)

### 1996
+ [35MF103_1](https://cchdo.ucsd.edu/cruise/35MF103_1)

### 2008
+ [33RR20080204](https://cchdo.ucsd.edu/cruise/33RR20080204)

### 2019
+ [325020190403](https://cchdo.ucsd.edu/cruise/325020190403)

## 2. Glitches

### 1993

More than a few CTD files in the exchange format
(e.g. `i06sa_00006_00001_ct1.csv`, `i06sa_00010_00001_ct1.csv`, ...)
carry a wrong unit line
`DBAR,,DEG,,C,,PSS-78,,` instead of the correct
`DBAR,,DEG_C,,PSS-78,,UMOL/KG,,`.
Use `read_ctd_exchange_1993.m`.

### 2019
CTDOXY from stations 5 to 8 show abnormality although flag=2 (as of 3 Jun 2020).
Manually removed by using `read_ctd_exchange_2019.m`.
