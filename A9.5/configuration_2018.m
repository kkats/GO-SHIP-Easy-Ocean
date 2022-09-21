% A9.5, 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:121]) = 1.0e-3 * 0.0; % unknown (740H20180228)
