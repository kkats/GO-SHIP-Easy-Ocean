% I05, 2023
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:232]) = 1.0e-3 * (-0.5); % P166 (33RR20230722)
