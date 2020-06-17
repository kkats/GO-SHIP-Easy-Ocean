% SR04 1989
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:84]) = 1.0e-3 * 2.1; % P111 (06AQANTVIII_2)
