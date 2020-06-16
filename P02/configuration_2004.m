% P02, 2004
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:191]) = 1.0e-3 * (-0.5); % P144 (318M200406)
