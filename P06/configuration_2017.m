% P06, 2017
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:252]) = 1.0e-3 * 0.0; % P160
