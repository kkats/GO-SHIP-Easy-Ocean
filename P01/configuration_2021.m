% P01, 2021
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:94]) = 1.0e-3 * (-0.5); % P164 (49NZ20210717)
