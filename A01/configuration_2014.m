% A01, 2014
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:234]) = 1.0e-3 * 0.0; % unknown (74JC20140606)
