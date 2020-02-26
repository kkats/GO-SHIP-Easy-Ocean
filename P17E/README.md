# P17E
Some confusion over what is P17E - on CCHDO it might be both the E/W and N/S parts, but on Go-Ship website, it is just the N/S part as this has had a repeat in 1992/3 and 2017. 
I will construct the N/S part (at 125W) and if needed, can go back and do the single E/W transect.

## 1. Source
### 1992
+ [316N138_10](https://cchdo.ucsd.edu/cruise/316N138_10)

### 2017
+ [49NZ20170208](https://cchdo.ucsd.edu/cruise/49NZ20170208)
+ [320620161224](https://cchdo.ucsd.edu/cruise/320620161224) %this one might have one station at the bottom of P17E. Not used as yet.

# 2. Other
Java Ocean atlas section for 1992/3 bottle data available. P17_1991_92_93_bottle.csv

Purkey's product available for both 1992/3 and 2017.

Has two sets of data from 1992/3 and 2017 in a structure (D_ctd). 
D_ctd(1).stn is empty. D_ctd(2).stn has station numbers 1 to 26.

WOCE Atlas bottle/station file is labelled as P17 (bottom section relates to P17E definition on GO-Ship). p17_sta_bdep.txt. 
The WOCE Atlas p17e file relates to the Swift station locations from 1992/3 and includes the bottom of P16 and the E/W section in between P16 and P17E.

# 3. Glitches

### 1992/3

Station numbers in the CCHDO data are different from the ATLAS station numbers, which refer to the entire P17 line, not just the southern part at 125W.

### 2017

The exchange file has an exctra column ("SVLSAL") between salinity and oxygen.
The following patch is necessary for `read_ctd_exchange.m`;
```
--- read_ctd_exchange.m 2020-02-19 13:50:38.380460961 +0900
+++ read_ctd_exchange_P17E2017.m        2020-02-26 16:01:16.226759333 +0900
@@ -68,7 +68,9 @@
     [punit, r1] = strtok(uline, ',');
     [tunit, r2] = strtok(r1, ',');
     [sunit, r3] = strtok(r2, ',');
-    ounit = strtok(r3, ',');
+    % for 49NZ20170208
+    [ounit, r4] = strtok(r3, ',');
+    ounit = strtok(r4, ',');

     expo = itemEq(header, 'EXPOCODE');
     station = itemEq(header, 'STNNBR');
@@ -96,7 +98,7 @@
             fclose(fid);
             break;
         end
-        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
+        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d,%f,%d');
         m = m + 1;
         p(m) = a(1);
         pf(m) = a(2);
@@ -104,13 +106,9 @@
         tf(m) = a(4);
         s(m) = a(5);
         sf(m) = a(6);
-        if length(a) > 7
-            o(m) = a(7);
-            of(m) = a(8);
-        else
-            o(m) = nan;
-            of(m) = nan;
-        end
+        % for 49NZ20170208
+        o(m) = a(9);
+        of(m) = a(10);
         clear a;
     end
     if m > mmax
```

Stations 14, 17, 19 were not completed during the 2017 occupation.

1992 configuration file uses P120.
2017 configuration file uses P159.

Gridding:
>> pr_grid = [0:10:6500];
>> ll_grid = [-66.328:(1/10):-52.511]; %grid along latitude.
