# A02
## 1. Source
### 1994
+ [06MT30_2](https://cchdo.ucsd.edu/cruise/06MT30_2)

### 1997
+ [06MT39_3](https://cchdo.ucsd.edu/cruise/06MT30_3)

### 2017
+ [45CE20170427](https://cchdo.ucsd.edu/cruise/45CE20170427)

## 2. Glitches

No Atlas station data available.
No JOA profile available.

The 1994 data have a salinity unit in "PSS-68". We suspect it is a typographical error of "PSS-78".

The CTD oxygen data from the 1997 occupation is extremely sparse west of 28W. Interpolation
data exist but need care when interpreting.

The pressure from the 2017 data have all FLAG=1. We consider them as usable by
applying the following patch;
```
--- read_ctd_exchange.m 2019-10-24 17:28:08.243345989 +0900
+++ read_ctd_exchange_A02_2017.m        2019-10-24 17:48:04.913486650 +0900
@@ -162,7 +162,7 @@

 % QC flag
 % retain only flag==2
-pr(pr_flg ~= 2) = NaN;
+pr(pr_flg ~= 2 & pr_flg ~= 1) = NaN;
 te(te_flg ~= 2) = NaN;
 sa(sa_flg ~= 2) = NaN;
 ox(ox_flg ~= 2) = NaN;
```
