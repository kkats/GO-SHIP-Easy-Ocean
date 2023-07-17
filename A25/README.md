# A25
The French cruises are also known as OVIDE --
Observatoire de la Variabilité Interannuelle à DEcennale en Atlantique Nord.
Note that OVIDE cruises deviate from the original WOCE occupation in 1997.
## 1. Source
### 1997
+ [74DI230_1](https://cchdo.ucsd.edu/cruise/74DI230_1)

### 2002
+ [35TH20020610](https://cchdo.ucsd.edu/cruise/35TH20020610)

### 2004
+ [35TH20040604](https://cchdo.ucsd.edu/cruise/35TH20040604)

### 2006
+ [06MM20060523](https://cchdo.ucsd.edu/cruise/06MM20060523)

### 2008
+ [35TH20080610](https://cchdo.ucsd.edu/cruise/35TH20080610)

### 2010
+ [35TH20100610](https://cchdo.ucsd.edu/cruise/35TH20100610)

### 2018
+ [35TH20180611](https://cchdo.ucsd.edu/cruise/35TH20180611)

## 2. Glitches

### 2002, 2004, 2008
`read_ctd_exchange_OVIDE.m` be used in the place of `read_ctd_exchange.m`.
OVIDE station number starts from 0.0 (and not integer).

### 2006, 2010
Data are provided in the NetCDF format and use `read_NetCDF_OVIDE.m`.
