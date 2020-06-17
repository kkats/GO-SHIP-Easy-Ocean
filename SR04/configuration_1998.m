% SR04 1998
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:151]) = 1.0e-3 * 0.3; % P133 (06AQANTXV_4)
