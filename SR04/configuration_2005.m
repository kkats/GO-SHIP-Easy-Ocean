% SR04 2005
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:143]) = 1.0e-3 * (-0.5); % P144 (06AQ20050122)
