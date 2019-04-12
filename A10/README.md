# A10
## 1. Source
[Jim's table](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Data%20Project%20Section%20List.xlsx) has 5 occupations, 4 of which are available on [CCHDO](https://cchdo.ucsd.edu/search?q=a10).
In accordance with the [GO-SHIP recommendation](https://docs.google.com/document/d/1JEdqSOQu4-glFTCmBOpAQUXB-oqSE5I9cjv3gDz2V4o), 2009 occupation is counted as A9.5.

### 1992
+ [06MT22_5](https://cchdo.ucsd.edu/cruise/06MT22_5)

### 2003
+ [49NZ20031106](https://cchdo.ucsd.edu/cruise/49NZ20031106)

### 2011
+ [33RO20110926](https://cchdo.ucsd.edu/cruise/33RO20110926)

# 2. Glitches

## 1987

### `findJOAstations`
~~~
Warning: 2 JOA stations had no CCHDO stations near by
Warning: not found( 1)  90-99     -29.7500     11.4083 1993-01-26 d=4006
Warning: not found( 2)  73-99     -30.0000    359.9667 1993-01-20 d=4135
~~~
~~~
Warning: 86 station pairs did not match
Warning: 1 JOA   100-1     -28.5117     14.9700 1993-01-28 d= 178
Warning: 1 CCHDO 100-2     -28.5028     14.9990 1993-01-28 d= 174
Warning: 2 JOA    99-1     -28.6350     14.6833 1993-01-28 d= 161
Warning: 2 CCHDO  99-2     -28.6222     14.6867 1993-01-28 d= 160
Warning: 3 JOA    98-1     -28.7600     14.3400 1993-01-28 d= 532
Warning: 3 CCHDO  98-2     -28.7517     14.3665 1993-01-28 d= 461
Warning: 4 JOA    97-1     -28.8883     14.0200 1993-01-28 d=1595
Warning: 4 CCHDO  97-2     -28.8793     14.0453 1993-01-28 d=1490
Warning: 5 JOA    96-1     -29.0117     13.7017 1993-01-28 d=2207
    :       :       :          :           :          :
~~~
The cast number for CTD and Bottle are often different.
The SUM files shows there are many multiple cast stations and ship drift
explains the difference.

## 2003

### `findJOAstations`
~~~
Warning: 2 JOA stations had no CCHDO stations near by
Warning: not found( 1) 992-1     -28.3000     15.7500 2003-12-02 d=  19
Warning: not found( 2) 991-1     -27.6000    311.7000 2003-11-07 d=  19
~~~
These two stations do not appear in the SUM file with unknown reasons -- ignored.
