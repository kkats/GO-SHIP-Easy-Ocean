# A05
## 1. Source
### 1992
+ [29HE06_1](https://cchdo.ucsd.edu/cruise/29HE06_1)

### 1998
+ [31RBOACES24N_2](https://cchdo.ucsd.edu/cruise/31RBOACES24N_2)

### 2004
+ [74DI20040404](https://cchdo.ucsd.edu/cruise/74DI20040404)

### 2010
+ [74DI20100106](https://cchdo.ucsd.edu/cruise/74DI20100106)

### 2011
+ [29AH20110128](https://cchdo.ucsd.edu/cruise/29AH20110128)

### 2015
+ [74EQ20151206](https://cchdo.ucsd.edu/cruise/74EQ20151206)

## 2. Glitches

No Atlas station data available.

### 1998
We need a depth file for 1998, produced from the SUM file. Note station 6, 29 do not
have depth and need to hand edit `a05_1998.depth` to remove these 2 lines.
```
% cat ar01_asu.txt| grep ROS | grep BE | awk '{print $1, $3, $4, $16}' > a05_1998.depth
```

### 2011
No SUM file for 2011.

The columns are in the order of "pressure, oxygen, temperaure, salinity", instead of
regular "pressure, temperature, salinity, oxygen". Apply this patch to `read_ctd_exchange.m`.
```
--- read_ctd_exchange.m	2019-10-24 17:28:08.243345989 +0900
+++ read_ctd_A05_2011.m	2019-11-01 14:04:13.244146496 +0900
@@ -66,9 +66,9 @@
     end
     % strtok skips consecutive separator, i.e. [a,b] = strtok(',,ABC',','); gives a='ABC'
     [punit, r1] = strtok(uline, ',');
-    [tunit, r2] = strtok(r1, ',');
-    [sunit, r3] = strtok(r2, ',');
-    ounit = strtok(r3, ',');
+    [ounit, r2] = strtok(r1, ',');
+    [tunit, r3] = strtok(r2, ',');
+    sunit = strtok(r3, ',');
 
     expo = itemEq(header, 'EXPOCODE');
     station = itemEq(header, 'STNNBR');
@@ -86,8 +86,7 @@
     end
 
     % read body assuming leftmost 8 columns are
-    % PRS, PRS_FLAG, TMP, TMP_FLAG, SAL, SAL_FLAG, OXY, OXY_FLAG
-    % if not, CTDtemUnit/CTDsalUnit/CTDoxyUnit might show something.
+    % PRS, PRS_FLAG, OXY, OXY_FLAG, TMP, TMP_FLAG, SAL, SAL_FLAG
     [p, pf, t, tf, s, sf, o, of] = deal(NaN(7500,1));
     m = 0;
     while 1
@@ -100,17 +99,12 @@
         m = m + 1;
         p(m) = a(1);
         pf(m) = a(2);
-        t(m)= a(3);
-        tf(m) = a(4);
-        s(m) = a(5);
-        sf(m) = a(6);
-        if length(a) > 7
-            o(m) = a(7);
-            of(m) = a(8);
-        else
-            o(m) = nan;
-            of(m) = nan;
-        end
+        t(m)= a(5);
+        tf(m) = a(6);
+        s(m) = a(7);
+        sf(m) = a(8);
+        o(m) = a(3);
+        of(m) = a(4);
         clear a;
     end
     if m > mmax
```
