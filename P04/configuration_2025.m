% P04, 2024
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:84]) = 1.0e-3 * (0.0); % P169 (33H320260511)  %% revised in 2026 update
salt_offset([1:84]) = 1.0e-3 * 0.2; % P169 (33H320260511, personal communication with Salinity PI)
% salt_offset([85:211]) = 1.0e-3 * (-0.8); % P167 (49NZ20250405)  %% revised in 2026 update
salt_offset([85:211]) = 1.0e-3 * 0.5; % P167 (49NZ20250405)
