% SR04 1990
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:131]) = 1.0e-3 * 0.1; % P113 (06AQANTIX_2)
