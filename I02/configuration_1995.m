% I05, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:168]) = 1.0e-3 * 1.4; % P128 (316N145_14, 316N145_15)
