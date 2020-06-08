% A02, 1997
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:79]) = 1.0e-3 * 0.4; % P29 (06MT039_3)
