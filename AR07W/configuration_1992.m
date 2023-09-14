% AR07W, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:54) = 1.0e-3 * (-0.9); % P117 (18HU92014_1)
