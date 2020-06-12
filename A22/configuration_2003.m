% A22, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:87]) = 1.0e-3 * (-0.3); % P140/141 (316N200309)
