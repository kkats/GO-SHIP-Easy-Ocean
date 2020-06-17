% P11, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:143]) = 1.0e-3 * 0.0; % unknown
