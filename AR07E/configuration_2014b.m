% AR07E, 2014b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset(1:234) = 1.0e-3 * 0.4; % P156 (35PK20140515) %% updated in 2026
salt_offset(1:234) = 1.0e-3 * 0.8; % P156 (35PK20140515)
