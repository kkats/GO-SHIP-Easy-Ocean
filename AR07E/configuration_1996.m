% AR07E, 1996
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset(1:55) = 1.0e-3 * 0.4; % P129 (06MT39_5) %% updated in 2026
salt_offset(1:55) = 1.0e-3 * (-0.7); % P129 (06MT39_5)
