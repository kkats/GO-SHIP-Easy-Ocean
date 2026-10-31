% A05, 1998
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:130]) = 1.0e-3 * 0.2; % P125 (31RBOACES24N_2)  %% revised in 2026 update
salt_offset([1:130]) = 1.0e-3 * (-0.6); % P125 (31RBOACES24N_2)
