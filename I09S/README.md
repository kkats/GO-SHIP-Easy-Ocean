# I09S
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 3 occupations.

### 1995
+ [316N145_5](https://cchdo.ucsd.edu/cruise/316N145_5)
+ [09AR9404_1](https://cchdo.ucsd.edu/cruise/09AR9404_1)

### 2004
+ [09AR20041223](https://cchdo.ucsd.edu/cruise/09AR20041223)

### 2012
+ [09AR20120105](https://cchdo.ucsd.edu/cruise/09AR20120105)

# 2. Glitches

### 1995

Bottom depths are missing. Two cruises were used for this one section, but fortunately their station numbers do not clash.
Use the depth file;
~~~
% awk '/BE/ && ($3 > 10) {print $3, $4, $16}' i08ssu.txt > i09s_1995.depth
% awk '/S04/ && /BO/ && ($3 <= 10) {print $3, $4, $16}' s03su.txt >> i09s_1995.depth
~~~

### 2004

Some bottom depths are zero. The "0" depths in the station list 'i09s_2004.list' are manually rewritten to '-999'.
