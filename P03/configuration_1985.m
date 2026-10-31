% P03, 1985
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% salt_offset([1:216]) = 1.0e-3 * 2.5; % P96 (314TTTPS24_1/31TTTPS24_2) %% updated in 2026
salt_offset([1:216]) = 1.0e-3 * 1.3; % P96 (314TTTPS24_1/31TTTPS24_2)
