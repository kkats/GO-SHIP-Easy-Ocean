% SR01 2009a
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:84]) = 1.0e-3 * 0.7; % P150 (740H20090203) %% updated in 2026
salt_offset([1:84]) = 1.0e-3 * 0.6; % P150 (740H20090203)
