# I01

There were problems with the CTD data from
[316N145_11](https://cchdo.ucsd.edu/cruise/316N145_11), resulting in
`flag=3`  or ["questionable"(PDF!)](https://dornsife.usc.edu/assets/sites/463/docs/WOCE_QualityFlags.pdf). But the overall impression was "Despite the difficulties,
the data set produced by cruise end is of fair quality" (P.21 of
[Cruise Report](https://cchdo.ucsd.edu/data/137/i01edo.pdf).

For 1995b occupation, We therefore apply a patch to use data with `flag=3`;
```
--- read_ctd_exchange.m 2020-02-19 13:50:38.380460961 +0900
+++ read_ctd_exchange_I01W.m    2020-03-12 13:45:44.698605883 +0900
@@ -162,10 +162,10 @@

 % QC flag
 % retain only flag==2
-pr(pr_flg ~= 2) = NaN;
-te(te_flg ~= 2) = NaN;
-sa(sa_flg ~= 2) = NaN;
-ox(ox_flg ~= 2) = NaN;
+pr(pr_flg ~= 2 & pr_flg ~= 3) = NaN;
+te(te_flg ~= 2 & te_flg ~= 3) = NaN;
+sa(sa_flg ~= 2 & sa_flg ~= 3) = NaN;
+ox(ox_flg ~= 2 & ox_flg ~= 3) = NaN;

 % sort in time
 for i = 1:length(stations)
```


## 1. Source
### 1995a
+ [3175MB95_04](https://cchdo.ucsd.edu/cruise/3175MB95_04)

[06MT32_1](https://cchdo.ucsd.edu/cruise/06MT32_1) and
[06BE89_1](https://cchdo.ucsd.edu/cruise/06BE89_1) occupied a few stations
on I01 but the number is small and not included.

### 1995b
+ [316N145_11](https://cchdo.ucsd.edu/cruise/316N145_11)
+ [316N145_12](https://cchdo.ucsd.edu/cruise/316N145_12)

## 2. Glitches

