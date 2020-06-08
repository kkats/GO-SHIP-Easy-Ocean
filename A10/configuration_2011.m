% A10, 2011
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:122]) = 1.0e-3 * 0.0; % P152 (33RO20110926)
