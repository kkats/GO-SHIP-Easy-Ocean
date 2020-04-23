# A22
## 1. Source

### 1997
+ [316N151_4](https://cchdo.ucsd.edu/cruise/316N151_4)

### 2003
+ [316N200310](https://cchdo.ucsd.edu/cruise/316N200310)

### 2012
+ [33AT20120324](https://cchdo.ucsd.edu/cruise/33AT20120324)

## 2. Glitches

### 1997

No depth data. Use SUM file;
```
awk '/ROS/ && /BE/ {print $1, $3, $4, $16}' a22su.txt > a22_1997.depth
```
