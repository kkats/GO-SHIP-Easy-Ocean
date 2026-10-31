% SR01 2021
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:100]) = 1.0e-3 * (-0.5); % P164 (740H20210202)  %% revised in 2026 update
salt_offset([1:100]) = 1.0e-3 * 0.6; % P164 (740H20210202)
