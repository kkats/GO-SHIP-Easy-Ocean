% A13, 2010
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:132]) = 1.0e-3 * (-0.6); % P147 (33RO20100308)
