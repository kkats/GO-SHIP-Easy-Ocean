# A16-A23
## 1. Source

### 1988
+ [32OC202_1 & 32OC202_2](https://cchdo.ucsd.edu/cruise/32OC202_1)
+ [318MHYDROS4](https://cchdo.ucsd.edu/cruise/318MHYDROS4)
+ [318MSAVE5](https://cchdo.ucsd.edu/cruise/318MSAVE5)

### 1993
+ [3175MB93](https://cchdo.ucsd.edu/cruise/3175MB93)

### 1995-1998
+ [74JC10-1](https://cchdo.ucsd.edu/cruise/74JC10_1)
+ [74DI233_1](https://cchdo.ucsd.edu/cruise/74DI233_1)

### 2003-2005
+ [33RO200306_01 & 33RO200306_02](https://cchdo.ucsd.edu/cruise/33RO200306_01)
+ [33RO200501](https://cchdo.ucsd.edu/cruise/33RO200501)

### 2011
+ [74DI20110715](https://cchdo.ucsd.edu/cruise/74DI20110715)

### 2013
+ [33RO20130803](https://cchdo.ucsd.edu/cruise/33RO20130803)
+ [33RO20131223](https://cchdo.ucsd.edu/cruise/33RO20131223)

# 2. Glitches

### 1988

#### `findJstations`
~~~
Warning: 2 JOA stations had no CCHDO stations near by
Warning: not found( 1)   1-1      63.3300    340.0017 1988-07-23 d= 200
Warning: not found( 2)  65-99      32.8500    338.6690 1988-08-11 d=5398
~~~
The CTD files for A16N station 1 and station 65 cast *99* do not exist.
For station 65, use cast 1. The SUM files reads;
~~~
32OC202_1      A16N     65      1  ROS 080688 1253   BE 33 19.30 N  21 36.40 W UNK  ----  5304              5402      25 1-6
32OC202_2      A16N     65      2  ROS 081188 0411   BE 32 51.00 N  21 19.90 W UNK  ----  ----              2001      24 1-6
~~~

~~~
Warning: 4 station pairs did not match
Warning: 1 JOA    11-2      59.8433    340.0133 1988-07-25 d=2731
Warning: 1 CCHDO  11-1      59.8433    340.0133 1988-07-25 d=2730
Warning: 2 JOA    61-99      35.0960    339.4650 1988-08-05 d=5317
Warning: 2 CCHDO  61-1      35.1000    339.4433 1988-08-04 d=5226
Warning: 3 JOA    62-99      34.6550    339.1890 1988-08-05 d=5251
Warning: 3 CCHDO  62-1      34.6733    339.1900 1988-08-05 d=5154
Warning: 4 JOA    63-99      34.2133    338.9350 1988-08-05 d=5232
Warning: 4 CCHDO  63-1      34.2133    338.9350 1988-08-05 d=5231
~~~
The cruise report reads (section 3.7)
~~~
There were alsoi 4 stations - 61, 62, 63, 65 - which had two casts (deep and shallow)
in order to recover shallower bottle data information missed on the deep casts because of
rosette malfunctions, ... The first three of the two cast stations were collected during
re-occupations of the stations (about 22 hours later).
~~~
We use the "cast 1"s for the CTD data.

### 1993

No depth data available.

### 2003

#### `findJstations`
With `A16_2003_2005_clean_bottle.csv`.

~~~
Warning: 3 station pairs did not match
Warning: 1 JOA    37-99      47.0002    340.0020 2003-06-28 d=4534
Warning: 1 CCHDO  37-2      47.0002    340.0020 2003-06-28 d=4535
Warning: 2 JOA    41-99      44.9983    340.0033 2003-06-30 d=4331
Warning: 2 CCHDO  41-2      44.9983    340.0033 2003-06-30 d=4332
Warning: 3 JOA     1-99     -60.0157    329.1072 2005-01-17 d=2733
Warning: 3 CCHDO   1-1     -60.0157    329.1072 2005-01-17 d=2734
~~~
Again, we use the CTD data as is.
