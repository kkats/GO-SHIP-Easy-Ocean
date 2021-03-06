# P17E

Some confusion over what is P17E; on [CCHDO](https://cchdo.ucsd.edu/search?q=P17E) it might be both the E/W and N/S parts, but on [GO-SHIP website](http://www.go-ship.org/RefSecs/goship_ref_secs.html), it is just the N/S part as this has had a repeat in 1992/3 and 2017. In the [WOCE Atlas](http://whp-atlas.ucsd.edu/pacific/p17e/track/track.htm), P17E refers to the zonal section, which is what the original cruise proposal meant (Talley, personal communication).

## 1. Source

### 1992
+ [316N138_10](https://cchdo.ucsd.edu/cruise/316N138_10)

### 2017
+ [49NZ20170208](https://cchdo.ucsd.edu/cruise/49NZ20170208)

## 2. Other
Java Ocean atlas section for 1992/3 bottle data available. P17_1991_92_93_bottle.csv

Purkey's product available for both 1992/3 and 2017.

Has two sets of data from 1992/3 and 2017 in a structure (D_ctd). 
D_ctd(1).stn is empty. D_ctd(2).stn has station numbers 1 to 26.

WOCE Atlas bottle/station file is labelled as P17 (bottom section relates to P17E definition on GO-Ship). p17_sta_bdep.txt. 
The WOCE Atlas p17e file relates to the Swift station locations from 1992/3 and includes the bottom of P16 and the E/W section in between P16 and P17E.

## 3. Glitches

### 1992/3

Station numbers in the CCHDO data are different from the ATLAS station numbers, which refer to the entire P17 line, not just the southern part at 125W.

### 2017

The exchange file has an exctra column ("SVLSAL") between salinity and oxygen.
Use `read_ctd_exchange_2017.m` in this directory.

Stations 14, 17, 19 were not completed during the 2017 occupation.

1992 configuration file uses P120.
2017 configuration file uses P159.
