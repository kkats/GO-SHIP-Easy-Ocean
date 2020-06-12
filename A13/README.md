# A13

South of 50S overlaps with section A12.

## 1. Source
### 1983
+ [316N19831007](https://cchdo.ucsd.edu/cruise/316N19831007)
+ [316N19840111](https://cchdo.ucsd.edu/cruise/316N19840111)

### 2010
+ [33RO20100308](https://cchdo.ucsd.edu/cruise/33RO20100308)

## 2. Glitches

### 1983

The CTD file is a text file with own format. Use `read_ctd_ajax.m` to produce
the raw matlab files, which requires EXPO input as the 2nd argument. See `batch.m`.

Cast number is zero for all stations, which is different from the cast number in
[JOA file](http://joa.ucsd.edu/data_files/best/Atlantic_sections/A13.5_AJAX_1983/A13.5_AJAX_1983_bottle.poa). Apply the following patch to `findJstations.m` to ignore the cast number;
```
--- findJstations.m     2020-02-19 13:50:38.380460961 +0900
+++ findJstations_A13.m 2020-03-04 12:11:25.836090451 +0900
@@ -64,14 +64,12 @@
     end
     % double check
     % compare (1) first 3 characters of stnnum
-    %         (2) cast number
     %         (3) JOA time (bottle time) is always the same or at most a day
     %             after the CCHDO time (CTD BO (sometimes BE) time)
     s0 = stations(ig1).Stnnbr;
     timediff = datenum(joa(n).date) - stations(ig1).Time;
     len = max([length(joa(n).stnnum), length(s0)]);
     if strncmp(joa(n).stnnum, s0, len) ~= true ...
-       || joa(n).cast ~= stations(ig1).Cast ...
        || timediff < -1 || timediff > 1
         % closest station found but fails comparison (1)(2)(3)
         joa(n).pair = ig1;
```

The document says "The deep and bottom water salinities less than 35 listed in this
report are correct relative to the SSW (Wormley Standard Seawater), but salinities
greater than 35 may have a systematic offset of 0.002 to 0.003 salinity" (p.5).


