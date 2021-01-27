% AR07W, 2008
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:52) = 1.0e-3 * (-0.6); % P147 (18HU20080520)
