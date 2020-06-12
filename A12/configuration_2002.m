% A12, 2002
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:101]) = 1.0e-3 * 0.0; % unknown (ANTXX_2)
