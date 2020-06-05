# I06S
## 1. Source

### 1993
+ [35MFCIVA_1](https://cchdo.ucsd.edu/cruise/35MFCIVA_1)

### 1996
+ [35MF103_1](https://cchdo.ucsd.edu/cruise/35MF103_1)

### 2008
+ [33RR20080204](https://cchdo.ucsd.edu/cruise/33RR20080204)

### 2019
+ [325020190403](https://cchdo.ucsd.edu/cruise/325020190403)

## 2. Glitches

### 1993

More than a few CTD files in the exchange format
(e.g. `i06sa_00006_00001_ct1.csv`, `i06sa_00010_00001_ct1.csv`, ...)
carry a wrong unit line
`DBAR,,DEG,,C,,PSS-78,,` instead of the correct
`DBAR,,DEG_C,,PSS-78,,UMOL/KG,,`.
Use this _ad-hoc_ patch in `read_ctd_exchange.m`.
~~~
*** read_ctd_exchange.m      2018-11-13 10:58:12.693620240 +0900
--- read_ctd_exchange_I06S_1993.m    2018-11-15 15:18:56.343377100 +0900
***************
*** 68,73 ****
--- 68,78 ----
      [sunit, r3] = strtok(r2, ',');
      ounit = strtok(r3, ',');

+     if strcmp(sunit, 'C') && strcmp(ounit, 'PSS-78')
+         sunit = 'PSS-78';
+         ounit = 'UMOL/KG';
+     end
+
      expo = itemEq(header, 'EXPOCODE');
      station = itemEq(header, 'STNNBR');
      cast = str2num(itemEq(header, 'CASTNO'));
~~~

### 2019
CTDOXY from stations 5 to 8 show abnormality although flag=2 (as of 3 Jun 2020).
Manually removed by the following patch.
~~~
*** read_ctd_exchange.m 2020-06-02 12:58:59.936428666 +0900
--- read_ctd_exchange_I06S2019.m        2020-06-03 09:19:13.428061625 +0900
***************
*** 178,183 ****
--- 178,185 ----
  sa = sa(:,idx);
  ox = ox(:,idx);

+ ox(:,5:7) = NaN;
+
  % finally save .mat files
  if length(outputfname) > 4 && strcmp(outputfname(end-3:end), '.mat')
      outputfname = outputfname(1:end-4);
~~~
