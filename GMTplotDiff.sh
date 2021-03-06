#!/bin/sh
#
# Plot difference between two gridded output from GO-SHIP-Easy-Ocean using GMT in PS format
#
# Usage:
# 1. Modify INPUT files here
DATA1=../output/gridded/P16/p16_1992.xyz.gz
DATA2=../output/gridded/P16/p16_2015.xyz.gz
#
# 2. Tweak following variables if necessary
OUT=/tmp/$$.ps
SCALE=-0.22/0.22/0.04
#
# 3. Run this script
# % ./GMTplotDiff.sh
#
#
XYZ1=/tmp/$$.xyz1
XYZ2=/tmp/$$.xyz2
XYZ=/tmp/$$.xyz
CPT=/tmp/$$.cpt
CNT=/tmp/$$.cnt

trap 'rm -fr $XYZ1 $XYZ2 $XYZ $OUT $CPT $CNT; exit 1' 1 2 3 15

gmt gmtset GMT_VERBOSE true PS_MEDIA a4 PS_PAGE_ORIENTATION landscape
gmt gmtset FORMAT_GEO_MAP F

zcat $DATA1 >$XYZ1
zcat $DATA2 >$XYZ2

# generate 2 column data with "latlon|depth  value"
awk '!/^#/ && $2 >= 2000 {printf("%f|%f%12.4f\n", $1, $2, $6)}' $XYZ1 >$XYZ
mv $XYZ $XYZ1
awk '!/^#/ && $2 >= 2000 {printf("%f|%f%12.4f\n", $1, $2, $6)}' $XYZ2 >$XYZ
mv $XYZ $XYZ2
rm -f $XYZ

# use join(1) to combine 2 data
join $XYZ1 $XYZ2 >$XYZ

# separate "latlon|depth" back to 2 columns
awk '{pos = index($1, "|");
      latlon = substr($1, 0, pos-1);
      depth = substr($1, pos+1, length($1)-1);
      if ($2 == -999 || $3 == -999) {print latlon, depth, -999;}
      else {print latlon, depth, ($3-$2);}}' $XYZ >$CNT
mv $CNT $XYZ

# colorbar
rm -f $CPT
gmt makecpt -Cpolar $SCALE >$CPT

# plot
gmt pscontour $XYZ \
          -JX15c/-12c -R-67/56.3/2000/6500 -BWeSn+t'@~DQ@~(2015-1992)'  \
          -Bxaf20+L'Latitude'+u'@~\260@~' -Byaf1000+l'Depth (dbar)' \
          -A- -C$CPT -di-999 -W-thin -N -I -K >$OUT

# landmass -- optional
#
# Since topography in p16_2015.list is not reliable, we use Matlab output in reported/P16/p16.mat
# >> load p16.mat
# >> save 'topo_2015.dat' [D_reported(3).latlist' D_reported(3).deplist'] -ascii
rm -f $CNT
echo -67 6500 >$CNT
cat P16/topo_2015.dat >>$CNT
echo 56.3 6500 >>$CNT
gmt psxy $CNT -J -R -L -Gblack -O -K >>$OUT

gmt psscale  -Bx+l'(@~\260@~C)'  -Dx15.5/0+w12/0.4+e -L -C$CPT -O >>$OUT
rm -f $CPT $CNT $XYZ $XYZ1 $XYZ2 gmt.conf gmt.history
gv $OUT
