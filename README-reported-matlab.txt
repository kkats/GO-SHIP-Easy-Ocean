GO-SHIP Gridded Time Series; user friendly WOCE/CLIVAR/GO-SHIP data
(https://dx.doi.org/10.7942/GOSHIP-EasyOcean).

(This document is an excerpt from README.md attached to the software. The latest version is fount at [GitHub repository](https://github.com/kkats/GO-SHIP-Easy-Ocean)).

# Reference

K. Katsumata, S. G. Purkey, R. Cowley, B. M. Sloyan, S. C. Diggs, T. S. Moore II, L. D. Talley, J. H. Swift, GO-SHIP Easy Ocean: Gridded ship-based hydrographic section of temperature, salinity, and dissolved oxygen (2022), Scientific Data, https://doi.org/10.1038/s41597-022-01212-w


# Notes

+ Temperature is in ITS-90. Use `t90tot68.m` for conversion to IPTS-68. The unit recorded in Matlab `Station` header (e.g. `D_pr(1).Station`) is the unit of the original CTD data, not the unit in our product.
+ Unless otherwise noted, only _good_ (as defined by `flag=2`) data are used.
+ Missing value is `-999` for ASCII and binary outputs and `NaN` otherwise.
+ Vertical coordinate is in pressure. Assuming `Depth` and/or `Corrected depth` in the Exchange CTD or SUM is in meters, we convert them to pressure. If depth is missing, we assume the bottom of measurement is 10 dbar above seabed. If `Uncorrected depth` is available but `Corrected depth` is missing, we use the former.
+ Used v3.06 of [TEOS-10](http://www.teos-10.org/software.htm) to calculate Conservative Temperature and Absolute Salinity.
+ Dissolved oxygen concentration is converted to μmol/kg (micro mol per kilogram), often written `umol/kg`.
+ No horizontal interpolation is applied for stations more than 2 degrees apart.

# Reported data

This is the clean data with no horizontal interpolation and no vertical interpolation.

Note: we do not perform any additional quality control except for obvious cases listed at https://github.com/kkats/GO-SHIP-Easy-Ocean#36-bad-data.
Bad data in the original data set remain in the product.

## Matlab format
`D_r` is an array holding one Matlab `structure` for one occupation of the hydrographic section.
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
Lat/Lon, depths,... etc. can be extracted from `station`s, but for ease of access,
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
