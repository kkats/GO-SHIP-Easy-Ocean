% A20, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:91]) = 1.0e-3 * (-0.3); % P140/P141 (316N200309)
