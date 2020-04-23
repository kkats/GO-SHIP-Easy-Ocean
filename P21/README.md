# P21
## 1. Source

### 1994
+ [31MWESTW_4](https://cchdo.ucsd.edu/cruise/318MWESTW_4)

### 2009
+ [49NZ20090410](https://cchdo.ucsd.edu/cruise/49NZ20090410)
+ [49NZ20090521](https://cchdo.ucsd.edu/cruise/49NZ20090521)

## 2. Glitches

At the time of writing, only the `whp_netcdf` format is available
for 49NZ20090521.

### 1992

The dates in the JOA files has a week `offset`. For example, station 240
was at 10 June 1994 according to the CTD and SUM, but the date is 17 June 1994
on JOA file (reported as of 10 May 2019). Use the following patch for now;
```
--- findJstations.m.dist        2019-05-10 15:26:02.642241400 +0900
+++ findJstations.m     2019-05-10 15:27:15.915421500 +0900
@@ -68,7 +68,7 @@
     %         (3) JOA time (bottle time) is always the same or at most a day
     %             after the CCHDO time (CTD BO (sometimes BE) time)
     s0 = stations(ig1).Stnnbr;
-    timediff = datenum(joa(n).date) - stations(ig1).Time;
+    timediff = datenum(joa(n).date) - stations(ig1).Time - 7;
     len = max([length(joa(n).stnnum), length(s0)]);
     if strncmp(joa(n).stnnum, s0, len) ~= true ...
        || joa(n).cast ~= stations(ig1).Cast ...
```
