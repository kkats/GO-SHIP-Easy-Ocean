% P13, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:85]) = 1.0e-3 * 2.0; % P114, 3220CGC92_0/1/2
