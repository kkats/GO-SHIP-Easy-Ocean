% SR01 2014
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:118]) = 1.0e-3 * 0.1; % P155 (74JC20140308)
