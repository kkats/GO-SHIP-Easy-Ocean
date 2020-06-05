% P17, 1991
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:141]) = 1.0e-3 * 2.0; % P114 (31WTTUNES_1, 31WTTUNES_2(124-140))
salt_offset([142:221]) = 1.0e-3 * 1.7; % P108 31WTTUNES_2 (141-220)
salt_offset([222:455]) = 1.0e-3 * (-0.9); % P120 316N138_9, 316N138_10
salt_offset([456:658]) = 1.0e-3 * 0.4; % P122 325021_2
