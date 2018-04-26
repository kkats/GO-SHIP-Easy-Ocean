# P06
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 4 occupations.
### 1967
+ ?

### 1992
+ [316N138_3](https://cchdo.ucsd.edu/cruise/316N138_3)
+ [316N138_4](https://cchdo.ucsd.edu/cruise/316N138_4)
+ [316N138_5](https://cchdo.ucsd.edu/cruise/316N138_5)

### 2003
+ [49NZ20030803](https://cchdo.ucsd.edu/cruise/49NZ20030803)
+ [49NZ20030909](https://cchdo.ucsd.edu/cruise/49NZ20030909)

### 2010
+ [318M20091121](https://cchdo.ucsd.edu/cruise/318M20091121)
+ [318M20100105](https://cchdo.ucsd.edu/cruise/318M20100105)

### 2017
+ [320620170703](https://cchdo.ucsd.edu/cruise/320620170703)
+ [320620170820](https://cchdo.ucsd.edu/cruise/320620170820)

# 2. Glitches
### 1992
#### `findJOAstations`
1. Not found
~~~
Warning: not found( 1)  32-1     -32.5010    273.4500 1992-05-13 d=3917
~~~
JOA's longitude is 86.55W = 273.45E, while CTD files has 86.0W = 274.0E. The SUM file supports the latter.
1. Not match
~~~
Warning: 1 JOA     3-1     -32.5013    288.3323 1992-05-04 d=5818
Warning: 1 CCHDO   5-1     -32.5013    288.3323 1992-05-04 d= 486
~~~
CTD file for station 3 does not exist.
1. Not match
~~~
Warning: 2 JOA    32-1     -32.5010    273.4500 1992-05-13 d=3917
Warning: 2 CCHDO  33-1     -32.5135    273.3270 1992-05-13 d=3782
~~~
As explained above in 3.1.1.
1. Not match
~~~
Warning: 3 JOA   234-1     -30.0845    156.5153 1992-07-23 d=4826
Warning: 3 CCHDO 233-1     -30.0810    156.4958 1992-07-23 d=4815
~~~
JOA's location corresponds to that at BO in the SUM. CTD files for station 234 has lat=-30.0828 & lon=156.5297 which is BE in the SUM.


