% S04I, 2012
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:150]) = 1.0e-3 * 0.6; % P154 (49NZ20121129/49NZ20130106)
