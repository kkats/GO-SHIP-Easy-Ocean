% A9.5, 2009
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:117]) = 1.0e-3 * 0.7; % P150 (740H20090307)
