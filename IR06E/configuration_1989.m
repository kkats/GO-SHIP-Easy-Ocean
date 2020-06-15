% IR06E, 1989
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:86]) = 1.0e-3 * 0.0; % unknown, 35MF62JADE_1
