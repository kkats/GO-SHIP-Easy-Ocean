% A03, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:125]) = 1.0e-3 * 2.5; % P115 (90CT40_1)
