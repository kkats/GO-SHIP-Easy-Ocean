% AR07E, 1991a
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset(1:40) = 1.0e-3 * 1.95; % average of P112 and P114 (64TR91_1) %% updated in 2026
salt_offset(1:40) = 1.0e-3 * 1.15; % average of P112 and P114 (64TR91_1)
