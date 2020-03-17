# A12
South of 50S overlaps with Setion A13.
## 1. Source
### 1992
+ [06AQANTX_4](https://cchdo.ucsd.edu/cruise/06AQANTX_4)

### 1996
+ [06AQANTXIII_4](https://cchdo.ucsd.edu/cruise/06AQANTXIII_4)

### 1999
+ [06AQ199901_2](https://cchdo.ucsd.edu/cruise/06AQ199901_2)

### 2000
+ [06AQ200012_3](https://cchdo.ucsd.edu/cruise/06AQ200012_3)

### 2002
+ [06AQ200211_2](https://cchdo.ucsd.edu/cruise/06AQ200211_2)

### 2005
+ [06AQ20050122](https://cchdo.ucsd.edu/cruise/06AQ20050122)

### 2008a
+ [35MF20080207](https://cchdo.ucsd.edu/cruise/35MF20080207)

### 2008b
+ [06AQ20080210](https://cchdo.ucsd.edu/cruise/06AQ20080210)

### 2010
+ [06AQ20101128](https://cchdo.ucsd.edu/cruise/06AQ20101128)

### 2014
+ [06AQ20141202](https://cchdo.ucsd.edu/cruise/06AQ20141202)

## 2. Glitches

For a quick look at the station locations, one who finds our convention of (longitude > 0)
not useful might like `longitude_filter.sh`.

### 1992
For JOA for 1992, `A12_1992_clean_bottle.joa` has less stations than
`A12_1992_clean_CTD.joa`. Use the latter.

### 2002a
The CTD file `a12_2002a_00060_00001_ct1.csv` has a pressure reverse at the very deepest
line. Deleted the last line.

### 2005

This is the same data as [SR04/](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/SR04/README.md)2005. Use the same patch to `read_ctd_exchange.m`.

### 2008b

See 2005 above.

### 2010

Slightly different patch from above two;
```
--- read_ctd_exchange.m	2019-10-24 17:28:08.243345989 +0900
+++ read_ctd_exchange_2010.m	2019-11-14 14:19:05.985768267 +0900
@@ -96,21 +96,23 @@
             fclose(fid);
             break;
         end
-        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
+        %a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
+        % no flag
+        a = sscanf(tline, '%f,%f,%f,%f,%f,%d');
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
+        %t(m)= a(3);
+        t(m)= a(2);
+        %tf(m) = a(4);
+        s(m) = a(3);
+        %sf(m) = a(6);
+        if (~isempty(strfind(ounit, 'UMOL/L')))
+            o(m) = a(4);
+            of(m) = 2; % XXX
         end
+        % dummy
+        pf(m) = 2; tf(m) = 2; sf(m) = 2;
         clear a;
     end
     if m > mmax
@@ -141,8 +143,10 @@
     stations(i).Time   = time;
     stations(i).Depth  = dep;
     stations(i).CTDtemUnit = tunit;
-    stations(i).CTDsalUnit = sunit;
-    stations(i).CTDoxyUnit = ounit;
+    stations(i).CTDsalUnit = 'PSS-78'; %sunit='PSU', assuming it is PSU078
+    if (~isempty(strfind(ounit, 'UMOL/L')))
+        stations(i).CTDoxyUnit = ounit;
+    end
 end
 
 pr(mmax+1:end,:) = [];
```
