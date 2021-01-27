% AR07W, 2009
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:45) = 1.0e-3 * 0.7; % P149 (18HU20090517)
