# I01

There were problems with the CTD data from
[316N145_11](https://cchdo.ucsd.edu/cruise/316N145_11), resulting in
`flag=3`  or ["questionable"(PDF!)](https://dornsife.usc.edu/assets/sites/463/docs/WOCE_QualityFlags.pdf). But the overall impression was "Despite the difficulties,
the data set produced by cruise end is of fair quality" (P.21 of
[Cruise Report](https://cchdo.ucsd.edu/data/137/i01edo.pdf).


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

### 1995b
For 1995b occupation, We therefore apply a patch to use data with `flag=3` (i.e. use `read_ctd_exchange_1995b.m`).
