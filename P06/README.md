# P06
### 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 4 occupations.
#### 1967
#### 1992
+ [316N138_3](https://cchdo.ucsd.edu/cruise/316N138_3)
+ [316N138_4](https://cchdo.ucsd.edu/cruise/316N138_4)
+ [316N138_5](https://cchdo.ucsd.edu/cruise/316N138_5)

#### 2003
+ [49NZ20030803](https://cchdo.ucsd.edu/cruise/49NZ20030803)
+ [49NZ20030909](https://cchdo.ucsd.edu/cruise/49NZ20030909)

#### 2010
+ [318M20091121](https://cchdo.ucsd.edu/cruise/318M20091121)
+ [318M20100105](https://cchdo.ucsd.edu/cruise/318M20100105)

#### 2017
+ [320620170703](https://cchdo.ucsd.edu/cruise/320620170703)
+ [320620170820](https://cchdo.ucsd.edu/cruise/320620170820)

### 2. Procedure
1. Download and unzip *all* CTD files necessary to form one complete section. For example, three zip files `p06e_nc_ctd.zip`, `p06c_nc_ctd.zip`, and `p06w_nc_ctd.zip` are necessary for the 1992 section. Unzip the archive *in one directory*. At this moment, **whp_netcdf** is the preferred format.
1. Start Matlab and run `read_ctd_nc`.
~~~
>> read_ctd_nc('1992/CTD', '1992/p06_1992');
~~~
1. Use [JOA application](http://joa.ucsd.edu/joa) to convert  [The "Best" Vertical Section Data](http://joa.ucsd.edu/data/best.html) into the CSV format with `File` → `Export as Spread Sheet`. On Mac/Linux, you might need to convert [newline](https://en.wikipedia.org/wiki/Newline) characters of the CSV file.
1. (optional) Find stations in JOA, Purkey's product, and in the Atlas.
~~~
>> flagJ = findJOAstations(stations, 'JOA/P06_1992_bottle.csv');
>> load ctd_all_gridded_P06.mat % Purkey's product
>> flagP = findPstations(stations, D_ctd(1));
>> flagA = findAstations(stations, '1992/Atlas/info/p6.header');
~~~
At this stage, it is likely a few (or more!) warnings pop out which have to be manually checked. See below.

1. Write station list
~~~
>> print_station(stations, jflag, pflag, aflag, '1992/p06_1992.list');
~~~
If any (or all) flag(s) is missing, use `zeros(length(stations), 1)` as dummy.

### 3. Glitches
#### `findJOAstations`
1. Not found
~~~
Warning: not found( 1)  32-1     -32.5010    273.4500 1992-05-13 d=3917
~~~
JOA's longitude is 86.55W = 273.45E, while CTD files has 86.0W = 274.0E. The SUM file supports the latter.

2. Not match
~~~
Warning: 1 JOA     3-1     -32.5013    288.3323 1992-05-04 d=5818
Warning: 1 CCHDO   5-1     -32.5013    288.3323 1992-05-04 d= 486
~~~
CTD file for station 3 does not exist.

3. Not match
~~~
Warning: 2 JOA    32-1     -32.5010    273.4500 1992-05-13 d=3917
Warning: 2 CCHDO  33-1     -32.5135    273.3270 1992-05-13 d=3782
~~~
As explained above in 3.1.1.

4. Not match
~~~
Warning: 3 JOA   234-1     -30.0845    156.5153 1992-07-23 d=4826
Warning: 3 CCHDO 233-1     -30.0810    156.4958 1992-07-23 d=4815
~~~
JOA's location corresponds to that at BO in the SUM. CTD files for station 234 has lat=-30.0828 & lon=156.5297 which is BE in the SUM.
