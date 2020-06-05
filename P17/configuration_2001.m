% P17, 2001
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:75]) = 1.0e-3 * 0.4; % P139 (49NZ200107_1)
