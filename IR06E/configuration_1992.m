% IR06E, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:149]) = 1.0e-3 * 0.0; % unknown, 35MF71JADE_1
