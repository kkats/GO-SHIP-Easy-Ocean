% SR04 2008
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:207]) = 1.0e-3 * 0.7; % P149 (06AQ20080210)
