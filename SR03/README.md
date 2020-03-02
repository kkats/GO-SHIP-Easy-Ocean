# SR03
## 1. Source

### 1991
+ [09AR9101_1](https://cchdo.ucsd.edu/cruise/09AR9101_1)

### 1993
+ [09AR9309_1](https://cchdo.ucsd.edu/cruise/09AR9309_1)

### 1994a
+ [09AR9404_1](https://cchdo.ucsd.edu/cruise/09AR9404_1)

### 1994b
+ [09AR9407_1](https://cchdo.ucsd.edu/cruise/09AR9407_1)

### 1995
+ [09AR9501_1](https://cchdo.ucsd.edu/cruise/09AR9501_1)

### 1996
+ [09AR9601_1](https://cchdo.ucsd.edu/cruise/09AR9601_1)

###  2001
+ [09AR20011029](https://cchdo.ucsd.edu/cruise/20011029)

###  2008
+ [09AR20080322](https://cchdo.ucsd.edu/cruise/20080322)

###  2011
+ [09AR20080104](https://cchdo.ucsd.edu/cruise/20110104)

## 2. Glitches

### 1994a and 1995

JOA files `SR03_1995_clean_bottle.jos` and `SR03_1995_decimated_CTD.jos` correspond
to our 1994a. Both yield the same flagJ.

### 2001

`SR03_2001_decimated_CTD.jos` gives more near-by stations that `SR03_1995_clean_bottle.jos`.

Standard seawater used on stations 10--13 was documted as "P133 and P137". We treat these stations with "unknown SSW". The same for stations 31--36.

Salinity and oxygen have wrong units ('C' and 'PSS-78', respectively). Use this patch;
```
--- ../reported_data.m.dist	2019-04-12 14:13:22.000276932 +0900
+++ ../reported_data.m	2019-04-12 14:39:40.237722938 +0900
@@ -47,6 +47,13 @@
 nstn = length(good)
 [lats, lons, deps] = deal(NaN(1,nstn));
 
+% 09AR20011029
+for i = 1:length(stations)
+    if strcmp(stations(i).CTDsalUnit, 'C') && strcmp(stations(i).CTDoxyUnit, 'PSS-78')
+        stations(i).CTDsalUnit = 'PSS-78';
+        stations(i).CTDoxyUnit = 'mol/kg';
+    end
+end
 
 for i = 1:nstn
     lats(i) = stations(good(i)).Lat;
@@ -54,6 +61,8 @@
     deps(i) = stations(good(i)).Depth;
 end
 
+
+
 [idx, nlons, isAtlanticZonal] = sort_stations(lons, lats);
 
 %%%
```
