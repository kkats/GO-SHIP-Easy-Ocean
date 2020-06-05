% P21 2009
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:243]) = 1.0e-3 * 0.7; % P150 (49NZ20090410, 49NZ20090521)
