% IR06-I10, 1995c
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:61]) = 1.0e-3 * 0.6; % P126, 316N145_13
