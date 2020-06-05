% P18, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:185]) = 1.0e-3 * 2.0; % P114 (31DSCG94_1/2/3)
