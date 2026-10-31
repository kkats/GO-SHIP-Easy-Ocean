% A10, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:111]) = 1.0e-3 * (-0.9); % P120 (06MT22_5) %% updated in 2026
salt_offset([1:111]) = 1.0e-3 * (-1.6); % P120 (06MT22_5)
