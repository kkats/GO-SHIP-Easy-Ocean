% AR07E, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset(1:8) = 1.0e-3 * 0.0; % unknown (06AZ144)
salt_offset(9:66) = 1.0e-3 * 0.6; % P124 (06MT30_3)
