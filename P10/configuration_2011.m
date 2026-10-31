% P10, 2011
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:126]) = 1.0e-3 * 0.4; % P153 (49NZ20111220/49NZ20120113)  %% revised in 2026 update
salt_offset([1:126]) = 1.0e-3 * 0.5; % P153 (49NZ20111220/49NZ20120113)
