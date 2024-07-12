% A05, 2020
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:25]) = 1.0e-3 * (-0.5); % P164 (74EQ20220209)
