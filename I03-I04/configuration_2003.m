% I03-I04, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:145]) = 1.0e-3 * 0.2; %  P142 (49Z20031209)
