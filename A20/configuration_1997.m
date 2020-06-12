% A20, 1997
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:95]) = 1.0e-3 * 0.0; % unknown (316N151_3)
