% P14, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:52]) = 1.0e-3 * (-0.9); % P120, 316N138_7
salt_offset([53:250]) = 1.0e-3 * 0.4; % P122, 325023_1/325024_1
salt_offset([251:429]) = 1.0e-3 * 2.0; % P114, 31DSCG96_1
