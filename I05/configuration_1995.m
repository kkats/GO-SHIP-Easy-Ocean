% I05, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:110]) = 1.0e-3 * 0.6; % P126 (316N145_7, 316N145_9)
