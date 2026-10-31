% AR07E, 2011
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset(1:46) = 1.0e-3 * (-1.5); % P146 (64PE20110724) %% updated in 2026
salt_offset(1:46) = 1.0e-3 * (-1.9); % P146 (64PE20110724)
