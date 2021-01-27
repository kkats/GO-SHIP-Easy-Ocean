# AR07E, A01E
## 1. Source
### 1990
+ [64TR90_3](https://cchdo.ucsd.edu/cruise/64TR90_3)

### 1991a
+ [64TR91_1](https://cchdo.ucsd.edu/cruise/64TR91_1)

### 1991b
+ [74AB62_1](https://cchdo.ucsd.edu/cruise/74AB62_1)

### 1991c
+ [06MT18_1](https://cchdo.ucsd.edu/cruise/06MT18_1)

### 1992
+ [06AZ129_1](https://cchdo.ucsd.edu/cruise/06AZ129_1)

### 1994
+ [06AZ144](https://cchdo.ucsd.edu/cruise/06AZ144)
+ [06MT30_3](https://cchdo.ucsd.edu/cruise/06MT30_3)

### 1995
+ [06AZ152](https://cchdo.ucsd.edu/cruise/06AZ152)

### 1996
+ [06AZ161_2](https://cchdo.ucsd.edu/cruise/06AZ161_2)

### 1997
+ [06MT39_5](https://cchdo.ucsd.edu/cruise/06MT39_5)

### 2000
+ [64PE20000926](https://cchdo.ucsd.edu/cruise/64PE20000926)

### 2005
+ [64PE20050907](https://cchdo.ucsd.edu/cruise/64PE20050907)

### 2014a
+ [35PK20140515](https://cchdo.ucsd.edu/cruise/35PK20140515)

### 2014b
+ [74JC20140606](https://cchdo.ucsd.edu/cruise/74JC20140606)

### 2015
+ [58GS20150410](https://cchdo.ucsd.edu/cruise/58GS20150410)

## 2. Glitches

Atlas data are not found online.

JOA data not available at the time of writing.

The 2007 cruise [64PE20070830](https://cchdo.ucsd.edu/cruise/64PE20070830)
covered western several stations of A01E but diverts in the central and eastern
parts and thus not considered here as reoccupation.
The stations on [45CE20100209](https://cchdo.ucsd.edu/cruise/45CE20100209) in 2010
are located too far east and not considered as reoccupation.

Data from year 2000 do not have flags. We assume all are good (flag=2) and
use `read_ctd_exchange_2000.m`. The rightmost column is CTDFLUOR, not oxygen.
Similarly, the rightmost column for 2005 data is not oxygen. Use
`read_ctd_exchange_2005.m`.
