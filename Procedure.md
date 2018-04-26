# Procedure for one section

It is necessary to repeat the following procedure for each section.

## 0. Salinity offset and user defined interpolator
For each section, the user must define the [salinity batch offset](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/SalinityOffset/README.md). It is a function of `k`. Here `k` is found in the first column of the station list and *not the original station number*. The function is found in `configuration.m`.

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
As default options, `vinterp.m` and `hinterp.m` are provided. The former uses Hanning smoothing and the latter shape-preserving piecewise cubic interpolation following [Purkey and Johnson (2010)](https://doi.org/10.1175/2010JCLI3682.1). These functions are indicated in configure.m;
~~~
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
~~~
using Matlab's function handle. Feel free to change.

## 1. Raw data in Matlab format and station list

1. Download and unzip *all* CTD files necessary to form one complete section. For example, three zip files `p06e_nc_ctd.zip`, `p06c_nc_ctd.zip`, and `p06w_nc_ctd.zip` are necessary for the P06 1992 section. Unzip the archive *in one directory* (say, `P06/1992/CTD`). At this moment, **whp_netcdf** is the preferred format.
1. Start Matlab and run `read_ctd_nc`. In this example, output goe to `P06/1992/p06_1992.mat`.
~~~
>> read_ctd_nc('P06/1992/CTD', 'P06/1992/p06_1992');
>> load P06/1992/p06_1992.mat
~~~

1. (optional) Use [JOA application](http://joa.ucsd.edu/joa) to convert  [The "Best" Vertical Section Data](http://joa.ucsd.edu/data/best.html) into the CSV format using `File` → `Export as Spread Sheet`. On Mac/Linux, you might need to convert [newline](https://en.wikipedia.org/wiki/Newline) characters of the CSV file.
1. (optional) Find stations in JOA, Purkey's product, and in the WOCE Atlas.
~~~
>> flagJ = findJOAstations(stations, 'P06/JOA/P06_1992_bottle.csv');
>> load P06/ctd_all_gridded_P06.mat % Purkey's product
>> flagP = findPstations(stations, D_ctd(1));
>> flagA = findAstations(stations, 'P06/1992/Atlas/info/p6.header');
~~~
At this stage, it is likely a few (or more!) warnings pop out which have to be manually checked. See [P06/README.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/P06/README.md), for example.
1. Write the station list
~~~
>> station_list(stations, flagJ, flagP, flagA, 'P06/1992/p06_1992.list');
~~~
If any flag is missing, use `zeros(length(stations), 1)` as a dummy flag.

## 2. Clean reported data

The station list prepared above is the seed of the clean data. Those stations listed in the station list will be incorporated in the output. Those stations commented out will not be.

1. Use your favourite editor to edit the station list (`p06_1992.list`). Comment out (by `#` or `%`) those stations to be excluded.
1. Run `reported_data()`;
~~~
>> D_reported = reported_data('P06/1992/p06_1992.list', 'P06/1992/p06_1992.raw');
~~~

## 3. Clean data in uniform grid
~~~
>> pr_grid = [0:20:6500];
>> ll_grid = [153:(1/5):289];
>> D_pr = grid_data_pressure(D_reported, pr_grid, ll_grid);
~~~



