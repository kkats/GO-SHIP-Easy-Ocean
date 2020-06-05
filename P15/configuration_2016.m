% P15, 2016
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:141]) = 1.0e-3 * (-0.7); % P157, 09U20160426
