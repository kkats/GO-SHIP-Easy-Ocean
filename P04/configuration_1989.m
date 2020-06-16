% P04, 1989
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:213]) = 1.0e-3 * 2.1; % P97 (32MW893_1/32MW893_2/32MW892_3)
