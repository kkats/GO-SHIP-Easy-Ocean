% I05, 1987
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:108]) = 1.0e-3 * 2.1; % P97 (74AB29_1)
