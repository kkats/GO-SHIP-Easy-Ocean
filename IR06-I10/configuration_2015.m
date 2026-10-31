% IR06-I10, 2015
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:62]) = 1.0e-3 * (-0.7); % P157, 49NZ20151223  %% revised in 2026 update
salt_offset([1:62]) = 1.0e-3 * (-0.3); % P157 , 49NZ20151223
