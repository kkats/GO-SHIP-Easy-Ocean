% AR07W, 2012
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset(1:46) = 1.0e-3 * 0.4; % P153 (18MF20120601) %% updated in 2026
salt_offset(1:46) = 1.0e-3 * 0.5; % P153 (18MF20120601)
