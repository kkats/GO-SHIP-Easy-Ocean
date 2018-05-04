# Procedure
CTD/sampling stations that consitute a section are designated by a `station.list` file. Repeat the process in `1.` to prepare `station.list` for each occupation.
We use `P06` section as an example.

## 1. Prepare `station.list` for each occupation

### 1-1. Salinity offset and user defined interpolator
Edit `configuration.m`.
For each section, the user needs to define the [salinity batch offset](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/SaltBatchOffset/README.md). It is a function of `k`. Here `k` is found in the first column of the station list and *not the original station number*.

It is also necessary to define Matlab functions used in the vertical and horizontal interpolations. Each function *must* have the following argument list;
~~~
interpolated = vertical_interpolator(measured_pressure_p1(:), ...
                                     measured_variable_on_p1(:), ...
                                     interpolating_pressure_grid(:))
~~~
and
~~~
[interpolated, bottom_depth] = horizontal_interpolator(measured_latlon(:,:), ...
                                                       measured_variable(:,:), ...
                                                       bottom_depth_uninterpolated(:), ...
                                                       pressure_grid(:), ...
                                                       latlon_grid(:))
~~~
As default options, `vinterp.m` and `hinterp.m` are provided. The former uses Hanning smoothing and the latter shape-preserving piecewise cubic interpolation following [Purkey and Johnson (2010)](https://doi.org/10.1175/2010JCLI3682.1). In `configuration.m`, the functions are listed as;
~~~
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
~~~
using Matlab's function handle. Feel free to change.

### 1-2. Raw data in Matlab format and station list

1. Download and unzip *all* CTD files necessary to form one complete section. For example, three zip files `p06e_nc_ctd.zip`, `p06c_nc_ctd.zip`, and `p06w_nc_ctd.zip` are necessary for the P06 1992 section. Unzip the archive *in one directory* (say, `P06/1992/CTD`). At this moment, **whp_netcdf** is the preferred format.
1. Start Matlab and run `read_ctd_nc`. In this example, output goe to `P06/1992/p06_1992.mat`.
~~~
>> read_ctd_nc('P06/1992/CTD', 'P06/1992/p06_1992');
>> load P06/1992/p06_1992.mat
~~~

### 1-3. Correspondence with existing products
1. (optional. When JOA data is available for this occupation;) Use [JOA application](http://joa.ucsd.edu/joa) to convert  [The "Best" Vertical Section Data](http://joa.ucsd.edu/data/best.html) into the CSV format using `File` → `Export as Spread Sheet` with comma separation. On Mac/Linux, you might need to convert [newline](https://en.wikipedia.org/wiki/Newline) characters of the CSV file.
1. (optional. When Purkey's product is available for this occupation;) Find stations in JOA, Purkey's product, and in the WOCE Atlas.
1. (optional. When WOCE Atlas header is available for this occupation;) Find stations in WOCE Atlas.
~~~
>> flagJ = findJOAstations(stations, 'P06/JOA/P06_1992_bottle.csv');
>> load P06/ctd_all_gridded_P06.mat % Purkey's product
>> flagP = findPstations(stations, D_ctd(1));
>> flagA = findAstations(stations, 'P06/1992/Atlas/info/p6.header');
~~~
At this stage, it is likely a few (or more!) warnings pop out which have to be manually checked. See [P06/README.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/P06/README.md), for example.

### 1-4. Write `station list`
~~~
>> station_list(stations, flagJ, flagP, flagA, 'P06/1992/p06_1992.list');
~~~
If any flag is missing, use `zeros(length(stations), 1)` as a dummy flag.

### 1-5. Edit `station.list`
The `station list`s prepared above are the seed of the clean data. Those stations listed in the station list will be incorporated in the output. Those stations commented out will not.

1. Use your favourite editor to edit the station list (`p06_1992.list`). Comment out (by `#` or `%`) those stations to be excluded.


## 2. Clean reported data
It is necessary to use the right `configuration.m` file. Here `%` is Shell prompt and `>>` is Matlab prompt.
~~~
% cp P06/1992/configuration.m .
>> D_reported(1) = reported_data('P06/1992/p06_1992.list', 'P06/1992/p06_1992.mat');
% cp P06/2003/configuration.m .
>> D_reported(2) = reported_data('P06/2003/p06_2003.list', 'P06/2003/p06_2003.mat');
% cp P06/2010/configuration.m .
>> D_reported(3) = reported_data('P06/2010/p06_2010.list', 'P06/2010/p06_2010.mat');
% cp P06/2017/configuration.m .
>> D_reported(4) = reported_data('P06/2017/p06_2017.list', 'P06/2017/p06_2017.mat');
~~~
1. Output in WHP Exchange format
~~~
>> reported_WHPX(D_reported(1), 'output/reported/P06/work/P06_1992');
% zip P06_1992_ct1 P06_1992_*.csv
>> reported_WHPX(D_reported(2), 'output/reported/P06/work/P06_2003');
% zip P06_2003_ct1 P06_2003_*.csv
>> reported_WHPX(D_reported(3), 'output/reported/P06/work/P06_2010');
% zip P06_2010_ct1 P06_2010_*.csv
>> reported_WHPX(D_reported(4), 'output/reported/P06/work/P06_2017');
% zip P06_2017_ct1 P06_2017_*.csv
~~~
1. Ouput in Matlab
~~~
>> save 'output/reported/P06/P06_reported.mat' D_reported
~~~

## 4. Clean data in uniform grid
(TODO) Output format?
~~~
>> pr_grid = [0:20:6500];
>> ll_grid = [153:(1/5):289];
>> D_pr(1) = grid_data_pressure(D_reported(1), pr_grid, ll_grid);
>> D_pr(2) = grid_data_pressure(D_reported(2), pr_grid, ll_grid);
>> D_pr(3) = grid_data_pressure(D_reported(3), pr_grid, ll_grid);
>> D_pr(4) = grid_data_pressure(D_reported(4), pr_grid, ll_grid);
>> gridded_XYZ(D_pr(1), 'output/reported/P06/P06_1992.xyz');
>> gridded_XYZ(D_pr(2), 'output/reported/P06/P06_2003.xyz');
>> gridded_XYZ(D_pr(3), 'output/reported/P06/P06_2010.xyz');
>> gridded_XYZ(D_pr(4), 'output/reported/P06/P06_2017.xyz');
>> save 'output/gridded/P06_gridded.mat' D_pr
~~~
