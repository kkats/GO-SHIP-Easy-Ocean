# Data structures
## Output
### Clean reported data
This is the clean data with no horizontal interpolation. We support Matlab format
and [WHP Exchange format](https://cchdo.ucsd.edu/formats).
The structure for the Matlab format is described in the
next section.

The WHP format can be read by [Ocean Data View](https://odv.awi.de/) using `Import` → `WOCE Formats` → `WHP CTD (exchange format)` menu.
The WHP format can also be read
by [Java Ocean Atlas](http://joa.ucsd.edu/joa) using `File` → `Open` menu.

### Clearn gridded data
We support
1. Matlab format
1. ASCII format
1. Binary format
1. NetCDF format

## Internal
### Station
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
+ Some `Stnnbr` has letters (e.g. `x12` for cross point) so that `Stnnbr` is char.
+ Use decimal degree in Lat and Lon.
+ Time follows *MATLAB* convention with seconds=0.
+ As measureents are given in pressure, we use pressure for bottom depth, i.e., if bottom is given in length (meters), it will be converted.

### CTD and bottle data

#### Clean reported data
~~~
D_r(1) = struct('Station', {stnW(1), stnW(3), ..} ...
                'lonlist', lon(:), ...
                'latlist', lat(:), ...
                'deplist', depth(:), ...
                'CTDprs', ctdprs(:,:),  ...
                'CTDsal', ctdsal(:,:),  ...
                'CTDtem', ctdtem(:,:),  ...
                'CTDoxy', ctdoxy(:,:),  ...
                'BTLprs', btlprs(:,:),  ...
                'BTLoxy', btloxy(:,:),  ...
                    :         :     
                'BTLDO18', btldo18(:,:))
~~~
+ `D_r(1)` is the first occupation (mostly WOCE). `D_r(2)` is the second occupation (mostly CLIVAR/GO-SHIP). `stnW(:)` is the station structure defined above.
+ No vertical interpolation. No horizontal interpolation.
+ But stations have been chosen to form one *clean* section.
+ Temperature is in IPTS-68 (*not* ITS-90). This is useful to apply [gamma surface calculation](http://www.teos-10.org/preteos10_software/neutral_density.html).
+ Flag information have been incorporated (i.e. *Bad* (however defined) data have been removed or replaced with `NaN`).
+ Number of entries is not fixed.
+ Lat/Lon, depths,... etc. are recorded in 'Station' and can be retracted by
~~~
d = D_r(1);
nstn = length(d.Station);
[latlist, lonlist, deplist] = deal(NaN(nstn,1));
for i = 1:nstn
    latlist(i) = d.Station{i}.Lat;
    lonlist(i) = d.Station{i}.Lon;
    deplist(i) = d.Station{i}.Depth;
end
~~~
But for ease of access, `latlist`, `lonlist`, and `deplist` are provided by `reported_data.m`.
For zonal sections in the Atlantic Ocean, `lonlist` uses negative longitudes.

#### Clean gridded data on pressure coordinate
~~~
pressure_grid = [0, 20, 40, .., 6500];
latlon_grid = [150, 150.2, 150,4, ..., 300];
D_pr(1) = struct('Station', {stnW(1), stnW(3), ..}, ...
                 'CTDsal', ctdsal(:,:),  ...
                 'CTDtem', ctdtem(:,:),  ...
                 'CTDoxy', ctdoxy(:,:), ...
                 'BTLoxy', btloxy(:,:), ...
                    :           :
                 'BTLDO18', btdo18(:,:));
~~~
+ Other vertical coordinates (neutral surface, potential density) can be defined similarly.
+ Do we need an intermediate product with vertical uniform grid but no horizontal interpolation?
