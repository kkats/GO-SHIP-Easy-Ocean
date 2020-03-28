# I09S
## 1. Source

### 1995
+ [316N145_5](https://cchdo.ucsd.edu/cruise/316N145_5)
+ [09AR9404_1](https://cchdo.ucsd.edu/cruise/09AR9404_1)

### 2004
+ [09AR20041223](https://cchdo.ucsd.edu/cruise/09AR20041223)

### 2012
+ [09AR20120105](https://cchdo.ucsd.edu/cruise/09AR20120105)

## 2. Glitches

### 1995

Bottom depths are missing. Use the depth file;
~~~
% awk '$8=="BE" {print $1, $3, $4, $16}' s03su.txt > i09s_1995.depth
% awk '$8=="BE" {print $1, $3, $4, $16}' i08ssu.txt >> i09s_1995.depth
~~~

Salinity batch information for 316N145_5: salinity was analysed by two groups (WHOI and Scripps). Batches used by SIO include P124, p126 and p128.
WHOI used only p128 and was responsible for the I08S/I09S legs.
SIO was responsible for other sections covered in this big voyage.

### 2004

Some bottom depths are zero. The "0" depths in the station list 'i09s_2004.list' are manually rewritten to '-999'.


Data files were made and uploaded by Bec Cowley, scripts made by Kats.
