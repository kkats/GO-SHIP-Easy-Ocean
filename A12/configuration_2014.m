% A12, 2014
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:91]) = 1.0e-3 * 0.0; % P.152 (06AQ20141202)
