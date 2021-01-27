% AR07W, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:54) = 1.0e-3 * 0.7; % P123 (18HU94008_1)
salt_offset(55:112) = 1.0e-3 * 0.6; % P124 (06MT30_3)
