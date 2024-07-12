GO-SHIP Gridded Time Series; user friendly WOCE/CLIVAR/GO-SHIP data
(https://dx.doi.org/10.7942/GOSHIP-EasyOcean).

(This document is an excerpt from README.md attached to the software. The latest version is fount at [GitHub repository](https://github.com/kkats/GO-SHIP-Easy-Ocean)).

# Reference

K. Katsumata, S. G. Purkey, R. Cowley, B. M. Sloyan, S. C. Diggs, T. S. Moore II, L. D. Talley, J. H. Swift, GO-SHIP Easy Ocean: Gridded ship-based hydrographic section of temperature, salinity, and dissolved oxygen (2022), Scientific Data, https://doi.org/10.1038/s41597-022-01212-w


# Notes

+ Temperature is in ITS-90. Use `t90tot68.m` for conversion to IPTS-68. The unit recorded in Matlab `Station` header (e.g. `D_pr(1).Station`) is the unit of the original CTD data, not the unit in our product.
+ Unless otherwise noted, only _good_ (as defined by `flag=2`) data are used.
+ Missing value is `-999` for ASCII and binary outputs and `NaN` otherwise.
+ Vertical coordinate is in pressure. Assuming `Depth` and/or `Corrected depth` in the Exchange CTD or SUM is in meters, we convert them to pressure. If depth is missing, we assume the bottom of measurement is 10 dbar above seabed. If `Uncorrected depth` is available but `Corrected depth` is missing, we use the former.
+ Used v3.06 of [TEOS-10](http://www.teos-10.org/software.htm) to calculate Conservative Temperature and Absolute Salinity.
+ Dissolved oxygen concentration is converted to μmol/kg (micro mol per kilogram), often written `umol/kg`.
+ No horizontal interpolation is applied for stations more than 2 degrees apart.

# Reported data

This is the clean data with no horizontal interpolation and no vertical interpolation. We support Matlab format
and ASCII CSV in [WHP Exchange format](https://cchdo.ucsd.edu/formats).

Note: we do not perform any additional quality control except for obvious cases listed at https://github.com/kkats/GO-SHIP-Easy-Ocean#36-bad-data.
Bad data in the original data set remain in the product.

## ASCII format
One zipped archive corresponds to one occupation of the hydrographic section. In the
archive, there are CSV files, one file for one CTD station. Each file has a header
showing `DATE`, `LONGITUDE`, etc.

When unzipped, the data are in ASCII and can be easily edited by your favourite
editors. It is in CSV so that spreadsheet program can handle them. In particular,
these can be read by [Ocean Data View](https://odv.awi.de/) with`Import` → `WOCE Formats` → `WHP CTD (exchange format)` menu.
They can also be read
by [Java Ocean Atlas](http://joa.ucsd.edu/joa) with `File` → `Open` menu.
