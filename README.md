# WOCE-GO-SHIP-clean-sections
GO-SHIP Gridded Time Series; user friendly WOCE/CLIVAR/GO-SHIP data from [CCHDO](https://cchdo.ucsd.edu).

#### Reference
K. Katsumata, B. Sloyan, R. Cowley, S. Diggs, T. Moore, S. Purkey, J. Swift, L. Talley, _User friendly ship based hydrographic section data_ (in preparation)


# Output Formats

Uninterpolated data (station data) are called _reported_ data. Horizontally interpolated data are called _gridded_ data. These are stored under separate directories. Remarks common to all formats are;
+ Temperature is in IPTS-68 (*not* ITS-90). This is useful for [gamma surface calculation](http://www.teos-10.org/preteos10_software/neutral_density.html).
+ Unless otherwise noted (e.g. [I01](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/tree/master/I01/)), only _good_ (as defined by `flag=2`) data are used. This behaviour
can be changed by modifying the QC section in `read_ctd_exchange.m`.
+ Missing value is `-999` for ASCII and binary outputs and `NaN` otherwise.
+ Vertical coordinate is in pressure. Assuming `Depth` and/or `Corrected depth` in the Exchange CTD or SUM is in meters, we convert them to pressure (in `reported_data.m`). If depth is missing, we assume the bottom of measurement is 10 dbar above seabed. If `Uncorrected depth` is available but `Corrected depth` is missing, we use the former.
+ Used v3.06 of [TEOS-10](http://www.teos-10.org/software.htm) to calculate Conservative Temperature and Absolute Salinity.
+ Dissolved oxygen concentration is converted to umol/kg (micro mol per kilogram).

## 0. Quick start
To visualize`P16` section occupied in 2015, use;

| application | _reported_ | _gridded_ |
|-|-|-|
|[Matlab](https://stackoverflow.blog/2017/10/31/disliked-programming-languages/) |`reported/P16/p16.mat`|`gridded/P16/p16.mat`|
|[Ocean Data View](https://odv.awi.de/)|`reported/P16/p16_2015_ct1.zip`| - |
| [Java Ocean Atlas](http://joa.ucsd.edu/joa)|`reported/P16/p16_2015_ct1.zip`| - |
|[GrADS](http://cola.gmu.edu/grads/)|-|`gridded/P16/p16.bin.ctl`|
|[GMT](http://gmt.soest.hawaii.edu/)*|-|`gridded/P16_2015.xyz.gz`|
|[binary](https://en.wikipedia.org/wiki/IEEE_754)|-|`gridded/P16.bin`|
|ASCII|`reported/P16/p16_2015_ct1.zip`|`gridded/p16_2015.xyz.gz`|
|NetCDF|(work in progress)|(work in progress)|

\* see [GMTplotDiff.sh](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/GMTplotDiff.sh) as example.


## 1. Reported data

This is the clean data with no horizontal interpolation and no vertical interpolation.
We support Matlab format
and ASCII CSV in [WHP Exchange format](https://cchdo.ucsd.edu/formats).

### 1.1 Matlab format

D_r is an array holding one Matlab `structure` for one occupation of the hydrographic section.
In typical cases, `D_r(1)` is by WOCE cruises in the 1980s and 1990s and `D_r(2)` is by
CLIVAR/GO-SHIP cruises.

~~~
D_r(1) = struct('Station', {stnW(1), stnW(3), ..} ...
                'lonlist', lon(:), ...
                'latlist', lat(:), ...
                'deplist', depth(:), ...
                'CTDprs', ctdprs(:,:),  ...
                'CTDsal', ctdsal(:,:),  ...
                'CTDtem', ctdtem(:,:),  ...
                'CTDoxy', ctdoxy(:,:)))
~~~
Lat/Lon, depths,... etc. can be extracted from `station`s (see below), but for ease of access,
`latlist`, `lonlist`, and `deplist` are provided by `reported_data.m`.
For zonal sections in the Atlantic Ocean, `lonlist` uses negative longitudes.
`CTDsal`, `CTDtem`, and `CTDoxy` are aggregations of station measurements with the pressure given by `CTDprs`.
The entry `'Station'` holds a cell list of `Station` data structure defined as
~~~
stations(23) = struct('EXPO', '320620140320', ...
                      'Stnnbr',   '45',        ...
                      'Cast',        1,       ...
                      'Lat',   -45.0002,      ...
                      'Lon',  -149.5998,      ...
                      'Time', datenum(2014,4,17,19,47,0), ...
                      'Depth',     5350,      ...         % in pressure [dbar]
                      'CTDtemUnit', 'ITS-90', ...
                      'CTDsalUnit', 'PSS-78', ...
                      'CTDoxyUnit', 'umol/kg')
~~~
+ Some `Stnnbr` has letters (e.g. `X12` for cross points) so that `Stnnbr` is not restricted to numbers but characters are accepted.
+ In `Lat` and `Lon`, use decimal degree, not degree-minute-second.
+ Time follows MATLAB convention with fixed `seconds=0`.

### 1.2 ASCII format
One zipped archive corresponds to one occupation of the hydrographic section. In the
archive, there are CSV files, one file for one CTD station. Each file has a header
showing `DATE`, `LONGITUDE`, etc. Note [Creation Stamp](https://exchange-format.readthedocs.io/en/latest/common.html#file-requirements) is dummy.

When unzipped, the data are in ASCII and can be easily edited by your favourite
editors. It is in CSV so that spreadsheet program can handle them. In particular,
these can be read by [Ocean Data View](https://odv.awi.de/) with`Import` → `WOCE Formats` → `WHP CTD (exchange format)` menu.
They can also be read
by [Java Ocean Atlas](http://joa.ucsd.edu/joa) with `File` → `Open` menu.

### 1.3 NetCDF format
(work in progress)

## 2. Gridded data

### 2.1. Matlab format
Data are stored in 2 dimensional matrices as entries to a `structure`, one for each
occupation. The axes are defined in `ll_grid`
(longitude or latitude) and `pr_grid` (pressure).

### 2.2. Binary format
Binary is in [IEEE754](https://en.wikipedia.org/wiki/IEEE_754), 4-byte `float` in
[Big Endian](https://en.wikipedia.org/wiki/Endianness). The first datum is southmost/westmost
shallowest temperature datum. The second is the shallowest datum from the next horizontal grid.
After _XDEF_ data, data from the second shallowest depth follow. Vertical number
of data is _YDEF_. After temperature, the following data are stored in the order;
salinity, oxygen, Conservative Temperature, and Absolute Salinity.

This information and grid lat/lon are found in the form of GrADS control file
placed in the output directory (e.g. `P16.bin.ctl` for `P16`). One could actually
use GrADS to visualize the data, but there is a caveat;
GrADS is designed to visualize horizontally collected data (i.e. lat/lon) and not
sectional data (i.e. lat/depth). For this reason, the horizontal coordinate (lat/lon)
appears as longitude and depth as latitude. Occupation appears in time coordinate.
Hopefully this is not a problem for other applications.

### 2.3 ASCII format
When unzipped, the first line shows the content of the data. The missing value is `-999`.
An example for the use of these ASCII data to plot the difference between occupations with GMT can be found in [GMTplotDiff.sh](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/GMTplotDiff.sh).

### 2.3 NetCDF format
(work in progress)

## 3 ToDo

+ [A25/OVIDE](https://cchdo.ucsd.edu/search?q=OVIDE)
+ [75N](https://cchdo.ucsd.edu/search?q=75N)
+ [AR07](https://cchdo.ucsd.edu/search?q=AR07) or reprocess A01?
