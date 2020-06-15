% IR06, 1995b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:120]) = 1.0e-3 * 0.0; % unknown, 09FA9508_1
