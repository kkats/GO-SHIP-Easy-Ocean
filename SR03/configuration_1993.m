% SR03 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:63]) = 1.0e-3 * 0.4; % P121 (09AR9309_1)
