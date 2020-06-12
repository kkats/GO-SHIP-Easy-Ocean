% A22, 1997
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:77]) = 1.0e-3 * 0.1; % P131 (316N151_4)
