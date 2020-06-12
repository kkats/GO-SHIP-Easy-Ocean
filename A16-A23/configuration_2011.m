% A10-A23, 2011
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:29]) = 1.0e-3 * 0.0; % unknown (74DI20110715)
