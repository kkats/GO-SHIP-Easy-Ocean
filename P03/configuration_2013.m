% P03W, 2013
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:120]) = 1.0e-3 * 0.1; % P155 (49UP20130619)
