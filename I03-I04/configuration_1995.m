% I03-I04, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:157]) = 1.0e-3 * 0.6; %  P126 (316N145_8, 316N145_9)
