% I06S, 2008
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:109]) = 1.0e-3 * 0.5; % P149 (I06S, 33RR20080204)  %% revised in 2026 update
salt_offset([1:109]) = 1.0e-3 * 0.5; % P149 (I06S, 33RR20080204)
