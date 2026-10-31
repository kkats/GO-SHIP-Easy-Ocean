% P06, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:257]) = 1.0e-3 * 1.4; % P116 % revised in 2026 update
salt_offset([1:257]) = 1.0e-3 * (-0.5); % P116 
