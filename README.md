# WOCE-GO-SHIP-clean-sections
User friendly WOCE/GO-SHIP data

## Documents
+ [READEME.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/README.md) This file.
+ [Procedure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/Procedure.md) What to do.
+ [DataStructure.md](https://github.com/kkats/WOCE-GO-SHIP-clean-sections/blob/master/DataStructure.md) Internal data structure.

## Requirements
#### [Matlab](https://stackoverflow.blog/2017/10/31/disliked-programming-languages/)

#### [TEOS-10](http://www.teos-10.org/software.htm)
We use v3.06 for Matlab	 at the time of writing.

## Resources

#### [Clean Ocean Section](https://agu.confex.com/agu/os18/meetingapp.cgi/Paper/319661) by J.Swift (product available as [Java OceanAtlas](http://joa.ucsd.edu/data/best.html))
For bottle data
1. Remove bad (WOCE QC 4) and uncertain (WOCE QC 3) and replace with WOCE missing values
1. Remove bad (usually leaking; WOCE QC 4) botles
1. Eliminates extra bottles (large volume samples) -- usually bottles with no oxygen, nutrients, etc.
1. Adjust data columns into standard columns
1. Repaire oxygen & nutrient units if needed
1. **Eliminate stations not on the section line, duplicate stations, incomplete stations, mearge multiple casts, and sort the stations geographically**
1. Plot bottle S, Do, Si to assess whether any additional stations be removed due to large numbers of missing values that distort plots
1. **Join long sections carried out over multiple cruises into single ocean-spanning transects. Eliminate any overlapping stations & section segments with an eye to data continuity**
1. Convert depth (m) to pressure (db)


#### [WOCE clean sections](http://sam.ucsd.edu/vertical_sections/.index.html) by L.Talley

#### [WOCE ATLAS](http://woceatlas.ucsd.edu/) has bathymetry data and station info
e.g. [I08N](http://whpP-atlas.ucsd.edu/whp_atlas/indian/i08n/info/bathy.htm)

#### [GLODAPv2](https://cdiac3.ornl.gov/waves/glodapv2/) for bottle data

#### Matlab codes on [Google Drive](https://www.google.com/appserve/mkt/p/AFIPhzUx-MnvU6PQKf0JvXqg_YNrVy6TUmRI6rhUWI0wvIrlG1xY2f5TuReGa-fT3NOstufGGkSr-2kBPIVKQ16yyJBxJ7w3vvdMz3ZIDbV_pEwOmTL3ygcAym-ri20) (invitation only) by S.Purkey

#### GO-SHIP telecon (15 Dec 2016) [pdf](http://www.go-ship.org/GO-ShipMinutes15dec2016_final.pdf)
> 6.Clean Section  
> a cleaned-up 1-m T and S dataset from CTDs across the current GO-SHIP survey, and also former WOCE and CLIVAR surveys will be produced in a standardized format. The project aims to increase the value of existing data by better combining them and facilitating their use; Rik recommended to also  look into efforts already done for bottle data as part of GLODAP for BGC data.




## Decisions
#### Two products (at least)
One with vertical interpolation only. The other with horizontal interpolation gridded on Lat/Lon.

#### Use [TEOS-10](http://www.teos-10.org)
With measured TS retained

#### Start from [CCHDO](https://cchdo.ucsd.edu)
<5 new sections per year -- manageable on a volunteer basis

#### IAPSO SSW batch correction applied
As practicable as possible. Extended table of Kawano et al. [(2006)](https://link.springer.com/article/10.1007/s10872-006-0097-8).

#### Basic format in [WHP Exchange](https://cchdo.ucsd.edu/formats)




## Trivia
+ Use two digit section number (i.e. `P06` not `P6`).
+ Use `-999` for missing data as per [WHP Exchange](https://exchange-format.readthedocs.io/en/latest/common.html#parameter-and-unit-lines)
+ Do not use negative logitude (i.e. longitude always in [0,360]). Special treatment needed for sections which run across the Greenwich Meridian (maybe use longitude in [180,540]?).