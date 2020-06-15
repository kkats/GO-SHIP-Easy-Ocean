% I10, 2015
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:62]) = 1.0e-3 * (-0.7); % P157, 49NZ20151223
