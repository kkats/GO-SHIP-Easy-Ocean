% I05, 2009
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:198]) = 1.0e-3 * 0.7; % P149 (33RR20090320)  %% revised in 2026 update
salt_offset([1:198]) = 1.0e-3 * 0.5; % P149 (33RR20090320)
