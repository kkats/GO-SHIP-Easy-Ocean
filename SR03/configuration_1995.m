% SR03 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:62]) = 1.0e-3 * 0.0; % unknown (09AR9501_1)
