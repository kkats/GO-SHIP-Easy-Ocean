% A12, 2008a
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:111]) = 1.0e-3 * 0.0; % unknown (35MF20080207)
