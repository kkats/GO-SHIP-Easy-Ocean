% A01, 1991
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:40]) = 1.0e-3 * 1.95; % P112/P114 (64TR91_1)
salt_offset([41:103]) = 1.0e-3 * 1.9; % P112 (06MT18_1)
