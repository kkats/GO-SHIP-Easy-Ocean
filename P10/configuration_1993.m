% P10, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:12]) = 1.0e-3 * 2.0; % P114 (3250TN026_1)
salt_offset([13:94]) = 1.0e-3 * (-0.9); % P120 (3250TN026_1)
