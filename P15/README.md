# P15
## 1. Source
### 1990
+ [3175CG90_1](https://cchdo.ucsd.edu/cruise/3175CG90_1)
+ [18DD9403_1](https://cchdo.ucsd.edu/cruise/18DD9403_1)
+ [18DD9403_2](https://cchdo.ucsd.edu/cruise/18DD9403_2)
+ [31DSCG96_1](https://cchdo.ucsd.edu/cruise/31DSCG96_1)

### 2001
+ [09FA20010524](https://cchdo.ucsd.edu/cruise/09FA20010524)

### 2009
+ [09SS20090203](https://cchdo.ucsd.edu/cruise/09SS20090203)
+ [320620110219](https://cchdo.ucsd.edu/cruise/320620110219)

### 2016
+ [096U20160426](https://cchdo.ucsd.edu/cruise/096U20160426)

## 2. Glitches

- For 1990 occupation,
the Atlas file `P15_sta_bdep.txt` has stations with the same labels
and `findAflags.m` does not work. Set `A` flags manually

- The salt batch offset for 09SS20090203 is known to be P148/P150, but
station-wise usage is not known. We use the average of the offsets
for P148 and P150.

- The `depth_file` for 1990 needs a bit of effort as some station numbers
are shared between different cruises.
```
% cat p15nasu.txt p15nbsu.txt | awk 'NR>4 && ($17 != -9) $$ ($5 == "ROS") {print $3, $4, $17}' > p15_1990.depth
```
Then apply the following patch to `reported_data.m` to produce `reported_data_p15.m`
```
--- reported_data.m     2019-09-25 14:44:03.006582341 +0900
+++ reported_data_p15.m 2019-10-04 15:32:07.762670726 +0900
@@ -134,7 +134,8 @@
         % if depth_file exists
         if ~isempty(dtable)
             for j = 1:length(dtable)
-                if strcmp(ss.Stnnbr, dtable(j).station) && ss.Cast == dtable(j).cast
+                if strcmp(ss.Stnnbr, dtable(j).station) && ss.Cast == dtable(j).cast ...
+                   && strncmp(ss.EXPO, '18DD9403', 8)
                     d = (-1) * dtable(j).depth;
                     break;
                 end
```
