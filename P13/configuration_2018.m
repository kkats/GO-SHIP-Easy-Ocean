% P13, 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:103]) = 1.0e-3 * (-0.5); % P161, 49UP20180614/49UP20180806  %% revised in 2026 update
salt_offset([1:103]) = 1.0e-3 * 0.6; % P161 (49UP20180614/49UP20180806)
