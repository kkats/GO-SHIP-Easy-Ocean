% I09S, 2024
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:103]) = 1.0e-3 * (-0.8) ; %  P167, 096U20240101  %% revised in 2026 update
salt_offset([1:103]) = 1.0e-3 * 0.5; % P167 , 096U20240101
