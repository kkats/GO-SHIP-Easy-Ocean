% P03, 2005
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:216]) = 1.0e-3 *(-1.0); % P145 (49NZ20051031/49NZ20051127/49NZ20060120)
