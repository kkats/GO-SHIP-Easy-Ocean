# I08S-I09N
## 1. Source

### 1995
+ [316N145_5](https://cchdo.ucsd.edu/cruise/316N145_5)
+ [316N145_6](https://cchdo.ucsd.edu/cruise/316N145_6)

### 2007
+ [33RR20070204](https://cchdo.ucsd.edu/cruise/33RR20070204)
+ [33RR20070322](https://cchdo.ucsd.edu/cruise/33RR20070322)

### 2016
+ [33RR20160208](https://cchdo.ucsd.edu/cruise/33RR20160208)
+ [33RR20160321](https://cchdo.ucsd.edu/cruise/33RR20160321)

### 2024
+ [325020240221](https://cchdo.ucsd.edu/cruise/325020240221)
+ [325020250321](https://cchdo.ucsd.edu/cruise/325020250321)

## 2. Glitches

### 1995

All depths are missing. Use the SUM files and extract data;
~~~
awk '$2=="I08S" && $8=="BE" {print $1, $3, $4, $16}' i08ssu.txt >i08s-i09n_1995.depth
awk '$2=="I09N" && $8=="BO" {print $1, $3, $4, $16}' i09nsu.txt >>i08s-i09n_1995.depth
~~~
### 2007

The CTD file `33RR20070204_00050_00002_ctd` shows `FLAG=8` and thus not used.

#### `findJstations`
~~~
Warning: 1 JOA stations had no CCHDO stations near by
Warning: not found( 1) 199-2      18.0032     89.8512 2007-04-27 d=2171
Warning: 0 station pairs did not match
~~~
CTD data for station 199 was not included in the zip file.

### 2016

Depths are missing. At the time of writing, the SUM files are not available.

### 2024

Pressure does not have flag. New US GO-SHIP standard? Use `read_ctd_exchange_2023.m`.
