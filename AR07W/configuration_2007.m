% AR07W, 2007
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset(1:61) = 1.0e-3 * (-0.6); % P147 (18HU20070510) %% updated in 2026
salt_offset(1:61) = 1.0e-3 * (-0.9); % P147 (18HU20070510)
