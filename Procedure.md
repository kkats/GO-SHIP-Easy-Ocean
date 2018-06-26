# Procedure
CTD/sampling stations that constitute a section are designated by a `station.list` file. Repeat the process in `1.` to prepare `station.list` for each occupation.
We use `P06` section as an example.

## 1. Prepare `station.list`



### 1-1. Raw data in Matlab format and station list

1. Download and unzip *all* CTD files necessary to form one complete section. For example, three zip files `p06e_nc_ctd.zip`, `p06c_nc_ctd.zip`, and `p06w_nc_ctd.zip` are necessary for the P06 1992 section. Unzip the archive *in one directory* (say, `work/P06/1992/`). For this project, **whp_netcdf** is the preferred format.
1. Start Matlab and run `read_ctd_nc`. In this example, output goe to `P06/1992/p06_1992.mat`.
~~~
>> read_ctd_nc('work/P06/1992/', 'work/P06/p06_1992');
>> load 'work/P06/1992/p06_1992.mat'
~~~

### 1-2. Correspondence with existing products
1. (optional. When JOA data is available for this occupation;) Use [JOA application](http://joa.ucsd.edu/joa) to convert  [The "Best" Vertical Section Data](http://joa.ucsd.edu/data/best.html) into the CSV format using `File` → `Export as Spread Sheet` with comma separation. On Mac/Linux, you might need to convert [newline](https://en.wikipedia.org/wiki/Newline) characters of the CSV file (e.g. `nkf -Lu`).
~~~
>> flagJ = findJstations(stations, 'work/P06/JOA/P06_1992_bottle.csv');
~~~
1. (optional. When Purkey's product is available for this occupation;) Find stations in Purkey's product.
~~~
>> load 'work/P06/ctd_all_gridded_P06.mat' % Purkey's product
>> flagP = findPstations(stations, D_ctd(1));
~~~
1. (optional. When WOCE Atlas header is available for this occupation;) Find stations in [WOCE Atlas](http://woceatlas.ucsd.edu). For example, the station file for the WOCE occupation of P06 is available [here](http://whp-atlas.ucsd.edu/pacific/p06/info/bathy.html).
~~~
>> flagA = findAstations(stations, 'work/P06/Atlas/P06_sta_bdep.txt');
~~~
At this stage, it is likely a few (or more!) warnings pop out which have to be manually checked. See [P06/README.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/P06/README.md), for example.

### 1-3. Edit `station list`

1. Output initial version.
~~~
>> station_list(stations, flagJ, flagP, flagA, 'P06/1992/p06_1992.list');
~~~
If any flag is missing, use `zeros(1,length(stations))` as a dummy.

The `station list`'s prepared above are the seed of the clean data. Those stations listed in the station list will be incorporated in the output. Those stations commented out will not.

2. Use your favourite editor to edit the station list (`p06_1992.list`). Comment out (by `#` or `%`) those stations to be excluded. Output from `station_check.m` might be useful where station distance is calculated and a simple station map is shown.


## 2. Clean reported data
### 2-1. Salinity offset and user defined interpolator
Edit `configuration.m`.
For each section, the user needs to define the [salinity batch offset](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/SaltBatchOffset/README.md). It is a function of `k`. Here `k` is the number shown in the first column of the station list and *not the original station number*.

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
Horizontal interpolation is not performed if stations are more than 1 degree (longitude for zonal sections, latitude for meridional) apart. This is done in `grid_data_pressure.m` and can be changed if needed.

As default options, `vinterp.m` and `hinterp.m` are provided. The former uses Hanning smoothing and the latter shape-preserving piecewise cubic interpolation following [Purkey and Johnson (2010)](https://doi.org/10.1175/2010JCLI3682.1). In `configuration.m`, the functions are listed as;
~~~
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
~~~
using Matlab's function handle. Feel free to change.

### 2-2 `reported_data`
It is necessary to use the right `configuration.m` file. Here `%` is Shell prompt and `>>` is Matlab prompt.
~~~
% cp P06/configuration_1992.m configuration.m
>> D_reported(1) = reported_data('P06/1992/p06_1992.list', 'P06/1992/p06_1992.mat');
% cp P06/configuration_2003.m configuration.m
>> D_reported(2) = reported_data('P06/2003/p06_2003.list', 'P06/2003/p06_2003.mat');
% cp P06/configuration_2010.m configuration.m
>> D_reported(3) = reported_data('P06/2010/p06_2010.list', 'P06/2010/p06_2010.mat');
% cp P06/configuration_2017.m configuration.m
>> D_reported(4) = reported_data('P06/2017/p06_2017.list', 'P06/2017/p06_2017.mat');
>> save 'output/reported/I05/i05.mat' D_reported
~~~

### 2-3 Output in WHP Exchange format
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

## 3. Clean data in uniform grid
### Matlab
~~~
>> pr_grid = [0:10:6500];
>> ll_grid = [153.4:(1/10):288.6];
% cp P06/configuration_1992.m configuration.m
>> D_pr(1) = grid_data_pressure(D_reported(1), ll_grid, pr_grid);
% cp P06/configuration_2003.m configuration.m
>> D_pr(2) = grid_data_pressure(D_reported(2), ll_grid, pr_grid);
% cp P06/configuration_2010.m configuration.m
>> D_pr(3) = grid_data_pressure(D_reported(3), ll_grid, pr_grid);
% cp P06/configuration_2017.m configuration.m
>> D_pr(4) = grid_data_pressure(D_reported(4), ll_grid, pr_grid);
>> save 'output/gridded/P06_gridded.mat' D_pr ll_grid pr_grid
~~~
### ASCII
The output can be visualized using e.g.
[The Generic Mapping Tools](http://gmt.soest.hawaii.edu/home).
~~~
>> gridded_xyz(D_pr(1), 'output/gridded/P06/P06_1992.xyz', ll_grid, pr_grid);
>> gridded_xyz(D_pr(2), 'output/gridded/P06/P06_2003.xyz', ll_grid, pr_grid);
>> gridded_xyz(D_pr(3), 'output/gridded/P06/P06_2010.xyz', ll_grid, pr_grid);
>> gridded_xyz(D_pr(4), 'output/gridded/P06/P06_2017.xyz', ll_grid, pr_grid);
~~~

### Binary
The data are in 4-byte, big-endian, IEEE754 floats.
The data can be visualized using e.g.
[Grid Analysis and Display System (GrADS)](http://cola.gmu.edu/grads/)
A tentative control file for GrADS is also output, but note
that GrADS is designed for three dimensinal data set (XYZ) and not for
sectional data (XZ or YZ). The control file output from `gridded_bin.m` *overwrites
`y` as `depth`* to avoid unnecesary re-ordering of the binary data set.
~~~
>> gridded_bin(D_pr, 'output/gridded/P06/p06.bin', ll_grid, pr_grid);
~~~

### NetCDF
~~~
>> gridded_nc(D_pr, 'output/gridded/P06/p06.nc', ll_grid, pr_grid);
~~~


## 4. Notes
### 4-1. When bottom depth data are missing in the CTD file
This often happens. If depth data are available in the SUM file, follow these steps.
First, extract the depth data with `awk`.
For example
~~~
# for I05, 2002
tail -146 i05_74AB20020301su.txt | awk '{print $3, $4, $16}' > i05_2002.depth
~~~
or
~~~
# for I05, 2009
cat i05_33rr20090320su.txt | awk '/ROS/ && /BO/ {print $3, $4, $16}' > i05_2009.depth
~~~
This depth file can be fed as the fourth argument of `grid_data_pressure.m`.


### 4-2. When bottom depth data are missing and the SUM file is unavailable.
The function `grid_data_pressure.m` assumes all CTD casts were terminated at exactly 10 dbar above the bottom.
