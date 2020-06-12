% A12, 1999
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:256]) = 1.0e-3 * 0.3; % P134, 06AQ199901_2
