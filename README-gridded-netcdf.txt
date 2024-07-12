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

### NetCDF format
The NetCDF is CF compliant (CF-1.7 ACDD-1.3). The netCDF files are dimensioned by `gridded_section` (an integer indicating the gridded section number), `longitude`, `latitude`, and `depth`. `time` is a time variable associated with each data point, rounded to the day closest to the date of the data used at each grid point.
As usual, NetCDF is self-documented.
