% S04P, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:113]) = 1.0e-3 * 1.7; % P108 (90KDIOFFE6_1)
