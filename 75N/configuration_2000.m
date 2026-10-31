% 75N, 2000
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:60]) = 1.0e-3 * 0.3; % P136 (06AQ20010619)  %% revised in 2026 update
salt_offset([1:60]) = 1.0e-3 * -0.3; % P136 (06AQ20010619)
