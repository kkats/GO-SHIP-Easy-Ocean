% AR07W, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:27) = 1.0e-3 * 0.0; % offset for P117 is unknown (18HU93019_1)
