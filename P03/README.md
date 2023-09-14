# P03
## 1. Source
### 1985
+ [31TTTPS24_1](https://cchdo.ucsd.edu/cruise/31TTTPS24_1)
+ [31TTTPS24_2](https://cchdo.ucsd.edu/cruise/31TTTPS24_2)

The CTD data for both cruises are zipped into one file and found
in the [latter](https://cchdo.ucsd.edu/data/10639/p03_ct1.zip).

### 2005
+ [49NZ20051031](https://cchdo.ucsd.edu/cruise/49NZ20051031)
+ [49NZ20051127](https://cchdo.ucsd.edu/cruise/49NZ20051127)
+ [49NZ20060120](https://cchdo.ucsd.edu/cruise/49NZ20060120)

### 2013
+ [49UP20130619](https://cchdo.ucsd.edu/cruise/49UP20130619)

### 2021
+ [49UP20210719](https://cchdo.ucsd.edu/cruise/49UP20210719)

## 2. Glitches

### 1985

The CVS file generated from the [JOA P03](http://joa.ucsd.edu/data_files/best/Pacific_sections/P03_1985/P03_1985_bottle.joa) has NULL characters (ASCII = 0).
It was necessary to remove the NULL's. I could not do this with `sed` and ended up
the following C code;
```
#include <stdio.h>

int main(void)
{
    int c;
    FILE *infile;

    if ((infile = fopen("JOA/P03_1985_bottle.jos", "r")) == NULL)
        return 1;

    while ((c = fgetc(infile)) != EOF) {
        if (c != 0) {
            fputc(c, stdout);
        }
    }

    fclose(infile);
    return 0;
}
```

Depth is missing in the CTD file. Use depth file produced by
```
% cat p03bsu.txt p03asu.txt | awk '$5=="ROS" && $8=="BE" {print $1, $3, $4, $17}' > depth.dat
```
where `p03?su.txt` are SUM files.

The CTD file `p03e_00001_00005_ct1.csv` has two entries for pressure=0.
Hand-removed the first data.
