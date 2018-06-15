# I05
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 5 occupations.

### 1987
+ [74AB29_1](https://cchdo.ucsd.edu/cruise/74AB29_1)

### (1995, not used)
+ [316N145_7](https://cchdo.ucsd.edu/cruise/306N145_7)
+ [316N145_9](https://cchdo.ucsd.edu/cruise/306N145_9)

### (2000, not used)
+ [09FA20000926](https://cchdo.ucsd.edu/cruise/09FA20000926)

### 2002
+ [74AB20020301](https://cchdo.ucsd.edu/cruise/74AB20020301)

### 2009
+ [33RO20090320](https://cchdo.ucsd.edu/cruise/33RO20090320)

# 2. Glitches

## 1987
### `findJOAstations`
~~~
Warning: 1 JOA    15-1     -32.5460     33.4110 1998-11-17 d=3539
Warning: 1 CCHDO  15-1     -32.5467     33.4117 1987-11-17 d=3485
~~~
The [documentation](https://cchdo.ucsd.edu/data/2179/i05pdo.txt) says 3491 m.

## 2002
All CTD stations have `BOTTOM_DEPTH_METERS = 4`.
See section 4-1 of [Procedure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Procedure.md).

## 2009
Some CTD stations have `BOTTOM_DEPTH_METERS = 0`
See section 4-1 of [Procedure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Procedure.md).
