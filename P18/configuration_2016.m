% P18, 2016
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:213]) = 1.0e-3 * (-0.3); % P159 (33RO20161119)
