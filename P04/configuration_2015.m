% P04, 2015
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:66]) = 1.0e-3 * (-0.8); % P157 (49UP20150724)
