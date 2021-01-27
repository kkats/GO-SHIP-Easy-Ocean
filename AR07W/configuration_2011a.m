% AR07W, 2011a
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:86) = 1.0e-3 * (-0.5); % P151 (18HU20110506)
