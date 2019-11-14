# SR04
## 1. Source

### 1989
+ [06AQANTVIII_2](https://cchdo.ucsd.edu/cruise/06AQANTVIII_2)

### 1990
+ [06AQANTIX_2](https://cchdo.ucsd.edu/cruise/06AQANTVIX_2)

### 1992b
+ [06AQANTX_7](https://cchdo.ucsd.edu/cruise/06AQANTX_7)

### 1996
+ [06AQANTXIII_4](https://cchdo.ucsd.edu/cruise/06AQANTXIII_4)

### 1998
+ [06AQANTXV_4](https://cchdo.ucsd.edu/cruise/06AQANTXV_4)

### 2005
+ [06AQ20050122](https://cchdo.ucsd.edu/cruise/06AQ20050122)

### 2008
+ [06AQ20080210](https://cchdo.ucsd.edu/cruise/06AQ20080210)

### 2010
+ [06AQ20101128](https://cchdo.ucsd.edu/cruise/06AQ20101128)


# 2. Glitches

[06AQANTX_4](https://cchdo.ucsd.edu/cruise/06AQANTX_4) was not used as only less than
10 stations overlap with other occupations.

### 1992
This is `D_ctd(5)` in the Purkey's Matlab output.

The file `070764_ct1.csv` is broken. Not used (not on the section anyway).

The files in the exchange format have columns in an unusual order, i.e.,
`THETA,CTDPRS,CTDTMP,CTDSAL,CTDNOBS` and lack flags. Use this patch;
```
--- read_ctd_exchange.m	2019-04-24 17:44:22.050684191 +0900
+++ read_ctd_exchage_1992b.m	2019-04-24 11:40:38.213658283 +0900
@@ -41,7 +41,7 @@
         error(['read_ctd_exchange.m:', msg]);
     end
 
-    % Whatever before 'DBAR,' is header
+    % Whatever before 'DEG C' is header
     header = {};
     while 1
         tline = fgetl(fid);
@@ -49,7 +49,7 @@
             fclose(fid);
             error('read_ctd_exchange.m: premature header termination');
         end
-        if length(tline) > 5 && strcmp(tline(1:5), 'DBAR,')
+        if length(tline) > 5 && strcmp(tline(1:5), 'DEG C')
             break;
         end
         header = {header{1:end}, tline};
@@ -63,11 +63,11 @@
             m = m + 1;
         end
     end
-    % strtok can skip consecutive separator, i.e. [a,b] = strtok(',,ABC',','); gives a='ABC'
-    [punit, r1] = strtok(uline, ',');
-    [tunit, r2] = strtok(r1, ',');
-    [sunit, r3] = strtok(r2, ',');
-    ounit = strtok(r3, ',');
+    [dunit, r1] = strtok(uline, ',');
+    [punit, r2] = strtok(r1, ',');
+    [tunit, r3] = strtok(r2, ',');
+    sunit = strtok(r3, ',');
+    ounit = '';
 
     expo = itemEq(header, 'EXPOCODE');
     station = itemEq(header, 'STNNBR');
@@ -95,15 +95,15 @@
             fclose(fid);
             break;
         end
-        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
+        a = sscanf(tline, '%f,%f,%f,%f,%f');
         m = m + 1;
-        p(m) = a(1);
-        pf(m) = a(2);
+        p(m) = a(2);
+        pf(m) = 2; % dummy
         t(m)= a(3);
-        tf(m) = a(4);
-        s(m) = a(5);
-        sf(m) = a(6);
-        if length(a) > 7
+        tf(m) = 2; % dummy
+        s(m) = a(4);
+        sf(m) = 2; % dummy
+        if 0
             o(m) = a(7);
             of(m) = a(8);
         else
```

### 1996
JOA file 'S04A_1996_decimated_CTD.joa' gives more flags than 'S04A_1996_clean_bottle.joa'.
Use the former.


### 1998
`sr04_3_00002_ct1.csv` says its year is in 1999 -- probaly a type of 1998
(or April Fool's Day?). The unit line has excessive commas and confuses
`read_ctd_exchange.m`. Use this patch;
```
--- read_ctd_exchange.m      2019-04-24 17:44:22.050684191 +0900
+++ read_ctd_exchage_1998.m     2019-04-24 17:51:36.620278571 +0900
@@ -69,6 +69,12 @@
     [sunit, r3] = strtok(r2, ',');
     ounit = strtok(r3, ',');

+    if strcmp(sunit, 'C') && strcmp(ounit, 'PSS-78')
+        tunit = 'DEG_C';
+        sunit = 'PSS-78';
+        ounit = '';
+    end
+
     expo = itemEq(header, 'EXPOCODE');
     station = itemEq(header, 'STNNBR');
     cast = str2num(itemEq(header, 'CASTNO'));
```

### 2005
This is `D_ctd(6)` in the Purkey's Matlab output.

The data do not have flags. We assume all data are good and apply the following patch
to `read_ctd_exchange.m`. We also their salinity unit 'PSU' is 'PSS_78'.

```
--- read_ctd_exchange.m	2019-10-24 17:28:08.243345989 +0900
+++ read_ctd_exchange_2005.m	2019-11-13 17:16:06.619119742 +0900
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
+        if (~isempty(strfind(ounit, 'ML/L')))
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
+    if (~isempty(strfind(ounit, 'ML/L')))
+        stations(i).CTDoxyUnit = ounit;
+    end
 end
 
 pr(mmax+1:end,:) = [];
```

### 2008

Exactly the same problem with year 2005. Use the same patch.

### 2010
Beware of the unit of oxygen (umol/L).

The files in the exchange format lack flags, i.e., the columns are
`CTDPRS,CTDTMP,CTDSAL,CTDOXY,FLOURM,XMISS,CTDNOBS`. Use this patch;

```
--- read_ctd_exchange.m	2019-10-24 17:28:08.243345989 +0900
+++ read_ctd_exchange_2010.m	2019-11-13 17:18:47.858206891 +0900
@@ -49,13 +49,12 @@
             fclose(fid);
             error('read_ctd_exchange.m: premature header termination');
         end
-        % 06MT030_2 uses "DBARS" instead of "DBAR"
-        if length(tline) > 5 && (strcmp(tline(1:5), 'DBAR,') || strcmp(tline(1:6), 'DBARS,'))
+        if length(tline) > 5 && strcmp(tline(1:5), 'DBAR,')
             break;
         end
         header = {header{1:end}, tline};
     end
-    % check first unit
+    % check first unit --- strtok will skip blank entries (',,')
     % get rid of extra spaces
     m = 1;
     for n = 1:length(tline)
@@ -64,7 +63,6 @@
             m = m + 1;
         end
     end
-    % strtok skips consecutive separator, i.e. [a,b] = strtok(',,ABC',','); gives a='ABC'
     [punit, r1] = strtok(uline, ',');
     [tunit, r2] = strtok(r1, ',');
     [sunit, r3] = strtok(r2, ',');
@@ -96,21 +94,21 @@
             fclose(fid);
             break;
         end
-        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
+        a = sscanf(tline, '%f,%f,%f,%f');
         m = m + 1;
         p(m) = a(1);
-        pf(m) = a(2);
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
+        pf(m) = 2; % dummy
+        t(m)= a(2);
+        tf(m) = 2; % dummy
+        s(m) = a(3);
+        sf(m) = 2; % dummy
+        %if length(a) > 7
+            o(m) = a(4);
+            of(m) = 2; % dummy
+        %else
+        %    o(m) = nan;
+        %    of(m) = 2; % dummy
+        %end
         clear a;
     end
     if m > mmax
```
