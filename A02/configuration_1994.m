% A02, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:73]) = 1.0e-3 * 0.6; % P124 (06MT030_2)
