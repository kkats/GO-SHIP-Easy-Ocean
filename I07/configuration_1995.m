% I07, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:177]) = 1.0e-3 * 0.6; % P126 (316N145_9, 316N145_10)
