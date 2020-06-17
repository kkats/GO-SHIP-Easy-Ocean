% S04P, 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:118]) = 1.0e-3 * 0.0; % P161 (320620180309)
