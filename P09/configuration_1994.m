% P09, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:105]) = 1.0e-3 * 0.7; % P123 (49RY9407_1)  %% revised in 2026 update
salt_offset([1:105]) = 1.0e-3 * 0.0; % P123 (49RY9407_1)
