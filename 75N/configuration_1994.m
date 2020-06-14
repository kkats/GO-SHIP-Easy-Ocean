% 75N, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:85]) = 1.0e-3 * 0.0; % unknown (06AQ19940706)
