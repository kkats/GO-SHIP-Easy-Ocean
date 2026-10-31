% A14, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:234]) = 1.0e-3 * 0.7; % P123 (3230CITHER2_1)  %% revised in 2026 update
salt_offset([1:234]) = 1.0e-3 * 0.0; % P123 (3230CITHER2_1)
