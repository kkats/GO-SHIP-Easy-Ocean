% P06, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:238]) = 1.0e-3 * 0.2; % P142 % revised in 2026 update
salt_offset([1:238]) = 1.0e-3 * (-0.6); % P142 
