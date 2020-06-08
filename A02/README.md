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
using `read_ctd_exchange_2017.m`.
