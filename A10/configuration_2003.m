% A10, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:112]) = 1.0e-3 * (-0.2); % P143 (49NZ20031106)
