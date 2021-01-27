% AR07W, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:64) = 1.0e-3 * 0.2; % P125 (18HU95011_1)
