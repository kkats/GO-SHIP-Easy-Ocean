% A05, 2015
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:145]) = 1.0e-3 * 0.0; % unknown (74EQ20151206)
