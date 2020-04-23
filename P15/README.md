# P15
## 1. Source
### 1990
+ [3175CG90_1](https://cchdo.ucsd.edu/cruise/3175CG90_1)
+ [18DD9403_1](https://cchdo.ucsd.edu/cruise/18DD9403_1)
+ [18DD9403_2](https://cchdo.ucsd.edu/cruise/18DD9403_2)
+ [31DSCG96_1](https://cchdo.ucsd.edu/cruise/31DSCG96_1)

### 2001
+ [09FA20010524](https://cchdo.ucsd.edu/cruise/09FA20010524)

### 2009
+ [09SS20090203](https://cchdo.ucsd.edu/cruise/09SS20090203)
+ [320620110219](https://cchdo.ucsd.edu/cruise/320620110219)

### 2016
+ [096U20160426](https://cchdo.ucsd.edu/cruise/096U20160426)

## 2. Glitches

### 1990
The Atlas file `P15_sta_bdep.txt` has stations with the same labels
and `findAflags.m` does not work. Set `A` flags manually

The salt batch offset for 09SS20090203 is known to be P148/P150, but
station-wise usage is not known. We use the average of the offsets
for P148 and P150.

Depths are missing. Use topo file;
```
% awk '$5=="ROS" {print $1, $3, $4, $16}' p15sasu.txt  >p15_1990.depth
% awk '$2=="P15N" && $5=="ROS" && $8=="BE" {print $1, $3, $4, $16}' p15nasu.txt >>p15_1990.depth
% awk '$2=="P15N" && $5=="ROS" && $8=="BE" {print $1, $3, $4, $16}' p15nbsu.txt >>p15_1990.depth
```
It is necessary to edit station numbers (e.g. `003` to `3`) manually.
