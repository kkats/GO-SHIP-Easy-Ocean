% 75N, 1998
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:287]) = 1.0e-3 * 0.2; % P131 (offset 0.1) and P133 (offset 0.3) but usage unknown hence the average (06AQ19990623)
