% A20, 2012
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:83]) = 1.0e-3 * 0.6; % P153 (33AT20120419)  %% revised in 2026 update
salt_offset([1:83]) = 1.0e-3 * 0.5; % P153 (33AT20120419)
