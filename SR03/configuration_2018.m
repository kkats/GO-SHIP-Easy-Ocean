% SR03 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:108])   = 1.0e-3 * (-0.2);  % P158 and P161 (096U20180111)
