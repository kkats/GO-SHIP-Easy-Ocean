# A20
## 1. Source
### 1997
+ [316N151_3](https://cchdo.ucsd.edu/cruise/316N151_3)

### 2003
+ [316N200309](https://cchdo.ucsd.edu/cruise/316N200309)

### 2012

+ [33AT20120419](https://cchdo.ucsd.edu/cruise/33AT20120419)

### 2021
+ [325020210316](https://cchdo.ucsd.edu/cruise/325020210316)

## 2. Glitches

No Atlas station data available.

1997 data lacks depth. Use `awk '/ROS/ && /BE/ {print $1, $3, $4, $16}'` to the
[SUM file](https://cchdo.ucsd.edu/data/2655/a20su.txt) to produce the depth file.

### 2021
The pressure flag column does not exist in the CTD exchange files. Use `read_ctd_exchange_2021.m`.

The cruise document dated 16 Aug 2021 indicates the IAPSO Standard SeaWater batch
number of P-166, which is a typography of P-164 (confirmed by the PI through
personal communication).
