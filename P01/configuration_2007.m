% P01, 2007
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:233]) = 1.0e-3 * 0.0; % P148 (49NZ20070724/49NZ20071008)
