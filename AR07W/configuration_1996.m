% AR07W, 1996
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:45) = 1.0e-3 * 0.6; % P124 (18HU96006_1)
