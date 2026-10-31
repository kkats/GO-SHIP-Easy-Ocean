% A10-A23, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:88]) = 1.0e-3 * 0.0; % P119 (3175MB93)  %% revised in 2026 update
salt_offset([1:88]) = 1.0e-3 * (-0.4); % P119 (3175MB93)
