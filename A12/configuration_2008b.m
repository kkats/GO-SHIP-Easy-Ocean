% A12, 2008b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:207]) = 1.0e-3 * 0.7; % P149 (06AQ20080210)
