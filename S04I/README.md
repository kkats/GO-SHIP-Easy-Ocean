# S04I
## 1. Source

### 1994
+ [09AR9404_1](https://cchdo.ucsd.edu/cruise/09AR9404_1)
+ [320696_3](https://cchdo.ucsd.edu/cruise/320696_3)

### 2012
+ [49NZ20121128](https://cchdo.ucsd.edu/cruise/49NZ20121128)
+ [49NZ20130106](https://cchdo.ucsd.edu/cruise/49NZ20130106)

## 2. Glitches

### 1994
Use of `S04IE_1995_clean_bottle.joa` and `S04IE_1995_decimated_CTD.joa` gives the same `flagJ`.
The former is quicker. Same for `S04IW_1996_clean_bottle.joa` and `S04IW_1996_decimated_CTD.joa`.

 awk '$8=="BO" {print $1, $3, $4, substr($0,85,5)}' s03su.txt > s04i_1993.depth

