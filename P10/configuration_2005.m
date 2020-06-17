% P10, 2005
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:127]) = 1.0e-3 * (-1.0); % P145 (49NZ20050525)
