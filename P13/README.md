# P13
## 1. Source
### 1991
+ [49HH915_1](https://cchdo.ucsd.edu/cruise/49HH915_1)
+ [49HH915_2](https://cchdo.ucsd.edu/cruise/49HH915_2)
+ [49HH932_1](https://cchdo.ucsd.edu/cruise/49HH932_1)

### 1992
+ [3220CGC92_1](https://cchdo.ucsd.edu/cruise/3220CGC92_1)

### 2011
+ [49RY20110515](https://cchdo.ucsd.edu/cruise/49RY20110515)

# 2. Glitches

- For 1991 occupation, IAPSO SSW is documented as P112 and P114 for 49HH915_1/2,
but station-wise usage is not described. Since the former has an offset
of 1.9, the latter 2.0, we apply the value 1.95 for all stations.

- Use [P13J_sta_bdep.txt](http://whp-atlas.ucsd.edu/pacific/p13j/info/P13J_sta_bdep.txt)
for 1991 occupation, and [p13_sta_bdep.txt](http://whp-atlas.ucsd.edu/pacific/p13/info/p13_sta_bdep.txt) for 1992 occupation.

- `findAstations.m` does not work with 1991 occupation where the stationname has
a prefix 'C'. Use this patch
```
--- findAstations.m     2019-09-25 12:12:32.617687360 +0900
+++ findAstations_P13.m 2019-09-25 12:22:31.845986908 +0900
@@ -32,8 +32,9 @@
     for j = 1:N
         % stations number (and cast match)
         c = stations(j);
-        len = max([length(c.Stnnbr), length(a.stnnum)]);
-        if strncmp(c.Stnnbr, a.stnnum, len) == true
+        stnnum = sprintf('C%02d', str2num(a.stnnum));
+        len = max([length(c.Stnnbr), length(stnnum)]);
+        if strncmp(c.Stnnbr, stnnum, len) == true
             % check others
             if abs(c.Lat - a.lat) > 0.1 || abs(c.Lon - a.lon) > 0.1
 % no timestamp available in Atlas data % || abs(c.Time - a.time) > 0.25
```

The original station numbers for 1991 occupations overlap between `49HH915_1/2`
and `49HH932_1`. Hand editing of `A` flag was necessary on `p13_1991.list`.

- `p13_1992.list` misses some depths. Use the SUM file to fill some of the missing depths; when `BO` is missing, I substituted `EN` value. Some casts were totally without depths (documented under "A.5 MAJOR PROBLEMS").
