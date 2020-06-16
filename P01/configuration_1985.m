% P01, 1985
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:115]) = 1.0e-3 * 2.5; % P96 (31TTTPS47)
