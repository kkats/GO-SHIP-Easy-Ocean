# I05
## 1. Source

### 1987
+ [74AB29_1](https://cchdo.ucsd.edu/cruise/74AB29_1)

### 1995
+ [316N145_7](https://cchdo.ucsd.edu/cruise/316N145_7)
+ [316N145_9](https://cchdo.ucsd.edu/cruise/316N145_9)

### 2002
+ [74AB20020301](https://cchdo.ucsd.edu/cruise/74AB20020301)

### 2009
+ [33RR20090320](https://cchdo.ucsd.edu/cruise/33RR20090320)

## 2. Glitches

### 1987
#### `findJOAstations`
~~~
Warning: 1 JOA    15-1     -32.5460     33.4110 1998-11-17 d=3539
Warning: 1 CCHDO  15-1     -32.5467     33.4117 1987-11-17 d=3485
~~~
The [documentation](https://cchdo.ucsd.edu/data/2179/i05pdo.txt) says 3491 m.

### 2002
The CTD data `i05_00024_00001_ctd.nc` and 
`i05_00024_0001_ct1.csv` have two apparently same profiles packed into one.
Delete the latter half.

All CTD stations have `BOTTOM_DEPTH_METERS = 4`.
Use bottom file
```
% awk '$8=="BE" {print $1, $3, $4, $16}' i05_74AB20020301su.txt >i05_2002.depth
```

### 2009
Some CTD stations have `BOTTOM_DEPTH_METERS = 0`
Use bottom file
```
% awk '$8=="BO" {print $1, $3, $4, $16}' i05_33rr20090320su.txt >i05_2009.depth
```
