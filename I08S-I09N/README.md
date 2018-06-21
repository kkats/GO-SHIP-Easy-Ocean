# I08S-I09N
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 3 occupations.

### 1995
+ [316N145_5](https://cchdo.ucsd.edu/cruise/316N145_5)
+ [316N145_6](https://cchdo.ucsd.edu/cruise/316N145_6)

### 2007
+ [33RR20070204](https://cchdo.ucsd.edu/cruise/33RR20070204)
+ [33RR20070322](https://cchdo.ucsd.edu/cruise/33RR20070322)

### 2016
+ [33RR20160208](https://cchdo.ucsd.edu/cruise/33RR20160208)
+ [33RR20160321](https://cchdo.ucsd.edu/cruise/33RR20160321)

# 2. Glitches

## 1995

All depths are missing. Use the SUM files and extract data;
~~~
tail -452 i08ssu.txt | awk '/I08S/ && /ROS/ && /BE/ {print $3, $4, $16}' > i08s-i09n_1995.depth
tail -423 i09nsu.txt | awk '/I09N/ && /ROS/ && /BE/ {print $3, $4, $16}' >> i08s-i09n_1995.depth
~~~
Then follow
section 4-1 of [Procedure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Procedure.md).

## 2007

The CTD file `33RR20070204_00050_00002_ctd` shows `FLAG=8` and thus not used.

### `findJstations`
~~~
Warning: 1 JOA stations had no CCHDO stations near by
Warning: not found( 1) 199-2      18.0032     89.8512 2007-04-27 d=2171
Warning: 0 station pairs did not match
~~~
CTD data for station 199 was not included in the zip file.

## 2016

Depths are missing. At the time of writing, the SUM files are not available. Follow
section 4-2 of [Procedure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Procedure.md).
