# GO-SHIP Easy Ocean
GO-SHIP Gridded Time Series; user friendly WOCE/CLIVAR/GO-SHIP data from [CCHDO](https://cchdo.ucsd.edu).
Product is available at [doi:10.7942/GOSHIP-EasyOcean](https://dx.doi.org/10.7942/GOSHIP-EasyOcean).

#### Reference
K. Katsumata, S. G. Purkey, R. Cowley, B. M. Sloyan, S. C. Diggs, T. S. Moore II, L. D. Talley, J. H. Swift, _GO-SHIP Easy Ocean: Formatted and gridded ship-based hydrographic section data_ (submitted, 2020).
This publication describes version [1.1](https://github.com/kkats/GO-SHIP-Easy-Ocean/releases/tag/v1.1)
which has a [doi:10.5281/zenodo.3937962](https://doi.org/10.5281/zenodo.3937962).

# Output Formats

Uninterpolated data (station data) are called _reported_ data. Horizontally interpolated and vertically smoothed data are called _gridded_ data. These are stored under separate directories. Remarks common to all formats are;
+ Temperature is in ITS-90. Use `t90tot68.m` for conversion to IPTS-68 (e.g. input to [gamma surface calculation](http://www.teos-10.org/preteos10_software/neutral_density.html)). The unit recorded in Matlab `Station` header (e.g. `D_pr(1).Station`) is the unit of the original CTD data, not the unit in our product.
+ Unless otherwise noted (e.g. [I01](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/tree/master/I01/)), only _good_ (as defined by `flag=2`) data are used. This behaviour
can be changed by modifying the QC section in `read_ctd_exchange.m`.
+ Missing value is `-999` for ASCII and binary outputs and `NaN` otherwise.
+ Vertical coordinate is in pressure. Assuming `Depth` and/or `Corrected depth` in the Exchange CTD or SUM is in meters, we convert them to pressure (in `reported_data.m`). If depth is missing, we assume the bottom of measurement is 10 dbar above seabed. If `Uncorrected depth` is available but `Corrected depth` is missing, we use the former.
+ Used v3.06 of [TEOS-10](http://www.teos-10.org/software.htm) to calculate Conservative Temperature and Absolute Salinity.
+ Dissolved oxygen concentration is converted to μmol/kg (micro mol per kilogram), often written `umol/kg`.
+ No horizontal interpolation is applied for stations more than 2 degrees apart. This behaviour can be modified by `MAX_SEPARATION` paramter in `configuration_yyyy.m` files.

## 0. Quick start
To visualize a section, e.g. `P16` section occupied in 2015, use;

| application | _reported_ | _gridded_ |
|-|-|-|
|[Matlab](https://stackoverflow.blog/2017/10/31/disliked-programming-languages/) |`reported/P16/p16.mat`|`gridded/P16/p16.mat`|
|[Ocean Data View](https://odv.awi.de/)|`reported/P16/p16_2015_ct1.zip`| - |
| [Java Ocean Atlas](http://joa.ucsd.edu/joa)|`reported/P16/p16_2015_ct1.zip`| - |
|[GrADS](http://cola.gmu.edu/grads/)|-|`gridded/P16/p16.bin.ctl`|
|[GMT](http://gmt.soest.hawaii.edu/)*|-|`gridded/P16/p16_2015.xyz.gz`|
|[binary](https://en.wikipedia.org/wiki/IEEE_754)|-|`gridded/P16/p16.bin`|
|ASCII|`reported/P16/p16_2015_ct1.zip`|`gridded/P16/p16_2015.xyz.gz`|
|NetCDF|(work in progress)|`gridded/P16/p16.nc`|

\* see [GMTplotDiff.sh](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/GMTplotDiff.sh) for example.


## 1. Reported data

This is the clean data with no horizontal interpolation and no vertical interpolation.
We support Matlab format
and ASCII CSV in [WHP Exchange format](https://cchdo.ucsd.edu/formats).
Note: we do not perform any additional quality control. Bad data in the original data set remain in the product.

### 1.1 All stations
It is possible to include all stations in the original CTD file in the `reported` data set, e.g., for float calibration purposes.
When calling `reported_data.m`, use a special file name `'all'` in the first argument
instead of the list file (e.g. `P16/p16_1992.list`). Note that this output cannot be
gridded because of possible duplication and branching of the station tracks.

### 1.2 Matlab format
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

### 1.3 ASCII format
One zipped archive corresponds to one occupation of the hydrographic section. In the
archive, there are CSV files, one file for one CTD station. Each file has a header
showing `DATE`, `LONGITUDE`, etc. Note [Creation Stamp](https://exchange-format.readthedocs.io/en/latest/common.html#file-requirements) is dummy.

When unzipped, the data are in ASCII and can be easily edited by your favourite
editors. It is in CSV so that spreadsheet program can handle them. In particular,
these can be read by [Ocean Data View](https://odv.awi.de/) with`Import` → `WOCE Formats` → `WHP CTD (exchange format)` menu.
They can also be read
by [Java Ocean Atlas](http://joa.ucsd.edu/joa) with `File` → `Open` menu.

## 2. Gridded data

Users interested in data intercomparison should not use gridded data. See
[Secton 3.1](https://github.com/kkats/GO-SHIP-Easy-Ocean/blob/master/README.md#11-all-stations) below.

### 2.1. Matlab format
Data are stored in 2 dimensional matrices as entries to a `structure`, one for each
occupation. The axes are defined in `ll_grid`
(longitude or latitude) and `pr_grid` (pressure). The structure has a field `NTime`
which is the time (in Matlab format) of the measurement at the station nearest
(in lat/lon) to the grid point.

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

### 2.4 NetCDF format
The NetCDF is CF compliant (CF-1.7 ACDD-1.3). The netCDF files are dimensioned by `gridded_section` (an integer indicating the gridded section number), `longitude`, `latitude`, and `depth`. `time` is a time variable associated with each data point, rounded to the day closest to the date of the data used at each grid point.

## 3. Caveats

### 3.1 Coordinate for tracklines
When gridding `reported` data, a choice has to be made as to which horizontal coordinate
to use -- longitude, latitude, distance from the first station, staion number, etc.
We chose longitude/latitude based on the approximate distance (see [sort_stations.m](https://github.com/kkats/GO-SHIP-Easy-Ocean/blob/master/sort_stations.m).
If the distance between the northernmost and southermost stations are larger
than the distance between the easternmost and westernost stations, the the section
is meridional. If the other way arond, it is zonal.

Problems arise when the secton has _oblique_ trajectories. For example,
P17 section extends from (55&deg;N, 200&deg;E) to (40&deg;N, 225&deg;E) -- southeastward then
turns southward until (60&deg;S, 225&deg;E) with a slight turn to avoid islands in the South Pacific.
This will be gridded in latitude from 60&deg;S to 55&deg;N.
When gridded,
the stations north of 40&deg;N appear on the same meridian of 225&deg;E but actually not.
The northmost station is more than 1000 km west of the meridian.
Those users interested in data intercomparison should only use `reported` data,
where `all` option might be useful (see [Section 1.1](https://github.com/kkats/GO-SHIP-Easy-Ocean/blob/master/README.md#11-all-stations).

### 3.2 Choice of 'occupation'
The definition of occupation or repeat on a section is rather subjective.
For example, the cruise [325020080826](https://cchdo.ucsd.edu/cruise/325020080826)
on P16 was regarded too short to be an occupation and was not included here,
but the choice was subjective.
The user is free to make their own choices of cruises to form an occupation.

The cruise [31TUUNES_2](https://cchdo.ucsd.edu/cruise/31WTTUNES_2) was along 209.5&deg;E,
about 0.5&deg; west of later occupations. We included this as part of the 1992 occupation of P16
but it is quite possible to see this section as separate from P16.
We did not have any objective standard when deciding which cruise to include. The user
is again welcome to make the choice.

### 3.3 Section names
As far as we know, the section names have been only roughly designated by WOCE or [GO-SHIP](https://www.go-ship.org/RefSecs/goship_ref_secs.html).
For example, the section A01 is often referred to as section AR07.
It is also not unusual to cover two or more sections in one cruise, ending up the cuise having mutiple section designators (e.g. [316N145_9](https://cchdo.ucsd.edu/cruise/316N145_9) for I04, I05, and I07).
The best place to find this information is [README.md in SaltBatchOffset/](https://github.com/kkats/GO-SHIP-Easy-Ocean/tree/master/SaltBatchOffset/README.md).
The table shows a section name along with "also known as" entry. Try this table
if you cannot find the section you are looking for.

### 3.4 Choice of sections
Those data not archived on [CCHDO](https://www.cchdo.ucsd.edu) are not included
in this product, which does not mean all data available there are included here.
Archived data which do not follow the [recommended format](https://cchdo.ucsd.edu/formats)
were included if the format can be converted to Matlab readable format in a minimal
effort. We welcome volunteers who could convert those missed cruises into
[the format](https://github.com/kkats/GO-SHIP-Easy-Ocean/blob/master/DataStructure.md).
used here.

### 3.5 Oxygen data
Some cruises did not provide oxygen data. If oxygen field is missing in `reported`
or `gridded` product, it is most likely because oxygen was not provided in the source data.
If you notice oxygen in the source but not in the product, please notify us.

### 3.6 Bad data
We do not perform any quality control on top of the [WOCE flags](https://exchange-format.readthedocs.io/en/v1.0.1/quality.html) provided in the source data.

For some obvious cases only, did we manually removed suspect data
even with `flag = 2`(["acceptable measurement"](https://exchange-format.readthedocs.io/en/v1.0.1/quality.html)).
They are recorded in `README.md`'s and tabulated here.
| section | year | EXPO code | station | cast | description |
|:--     |--: |:--         |--:|--:|:--|
|75N     |2006|58GS20060721|266|1  |Bad at 1 db|
|A05     |2011|29AH20110128|6  |1  |Bad below 568 db|
|A12     |1992|06AQANTX_4  |   |   |Noisy salinity|
|A13     |1983|316N19831007,316N19840111|||Gaps in data, salinity suspect|
|A22     |1997|316N151_4   |  7|1  |Spikes in S below 2500 db|
|A22     |1997|316N151_4   | 35|1  |Spikes in T,S around 2612 db|
|AR07E   |2000|64PE20000926|   |   |No quality flag|
|AR07W   |1999--2011       |   |   |Uncalibrated CTD|
|I01     |1995|316N145_11  |   |   |FLAG=3|
|I02     |1995|            |118|  1|Wrong P at 2223 db|
|I06S    |2019|325020190403|5-8|   |Bad oxygen|
|I08S    |2007|33RR20070204| 50|  2|FLAG=8|
|IR06E   |2000|35MF200009  |   |   |Noisy DO|
|IR06E   |2000|35MF200009  | 10|   |Bad DO|
|IR06-I10|1995|09FA9503_1  |   |   |Flag=4 for S|
|P01     |1999|49NZ199901_1|   |   |Flag=1 for P|
|P01     |1999|49KA199905_2|   |   |Noisy S near surface|
|P15     |2009|09SS20090203|116|  1|Extremely low S at P=5784 db|
|SR01    |1997|74JC27_1    | 24|   |Wrong pressure P=1113, 1137 db|


## 4. Reprocessing

All input CTD files can be downloaded from [CCHDO](https://www.cchdo.ucsd.edu).
List of URLs of the CTD files is `getCTD.list`, which is
generated from `README.md`s by `getCTDlist.pl`.

It is possible to reprocess all sections with `all_batch.m`. Note that
`PREFIX` in `batch.m` and `batch.sh` is the output directory. This directory is hard-coded in `all_batch.m`.
Edit all these files as appropriate before running `all_batch.m`.

## ToDo

+ [A25/OVIDE](https://cchdo.ucsd.edu/search?q=OVIDE)
