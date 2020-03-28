# A20
## 1. Source
### 1997
+ [316N151_3](https://cchdo.ucsd.edu/cruise/316N151_3)

### 2003
+ [316N200309](https://cchdo.ucsd.edu/cruise/316N200309)

### 2012
+ [33AT20120419](https://cchdo.ucsd.edu/cruise/33AT20120419)

## 2. Glitches

No Atlas station data available.

1997 data lacks depth. Use `awk '/ROS/ && /BE/ {print $1, $3, $4, $16}'` to the
[SUM file](https://cchdo.ucsd.edu/data/2655/a20su.txt) to produce the depth file.
