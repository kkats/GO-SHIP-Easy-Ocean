% A14, 2019
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:77]) = 1.0e-3 * (-0.2); % P161 (29HE20190406)  %% revised in 2026 update
salt_offset([1:77]) = 1.0e-3 * 0.6; % P161 (29HE20190406)
