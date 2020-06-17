% SR03 1991
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:25]) = 1.0e-3 * 2.5; % P115 (09AR9101_1)
