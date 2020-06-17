% SR03 1996
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:20]) = 1.0e-3 * 1.4; % P128 (09AR9601_1)
salt_offset([21:66]) = 1.0e-3 * 0.3; % P130 (09AR9601_1)
