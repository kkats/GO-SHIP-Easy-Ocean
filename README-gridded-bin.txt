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


# Gridded data

### Binary format
Binary is in IEEE754, 4-byte `float` in Big Endian. The first datum is southmost/westmost
shallowest temperature datum. The second is the shallowest datum from the next horizontal grid.
After _XDEF_ data, data from the second shallowest depth follow. Vertical number
of data is _YDEF_. After temperature, the following data are stored in the order;
salinity, oxygen, Conservative Temperature, and Absolute Salinity.

This information and grid lat/lon are found in the form of GrADS control file
placed in the output directory (e.g. `P16.bin.ctl` for `P16`). One could actually
use GrADS to visualize the data, but there is a caveat;
GrADS is designed to visualize horizontally collected data (i.e. lat/lon) and not
sectional data (i.e. lat/depth). For this reason, the horizontal coordinate (lat/lon)
appears as longitude and depth as latitude. Occupation appears in time coordinate.
Hopefully this is not a problem for other applications.
