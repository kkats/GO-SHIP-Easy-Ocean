% P13, 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:103]) = 1.0e-3 * (-0.5); % P161, 49UP20180614/49UP20180806
