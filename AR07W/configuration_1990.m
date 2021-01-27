% AR07W, 1990
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:31) = 1.0e-3 * 1.1; % P104 (18DA90012_1)
